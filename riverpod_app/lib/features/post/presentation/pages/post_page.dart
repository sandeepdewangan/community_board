import 'package:core/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/errors/presentation_failure_exception.dart';
import '../../../../core/widgets/async_error_retry.dart';
import '../../controllers/post_list_controller.dart';
import '../../controllers/post_list_state.dart';
import '../widgets/post_card.dart';

class PostPage extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<PostPage> createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(postListControllerProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<PostListState>>(
      postListControllerProvider,
      (previous, next) {
        final prevFailure = previous?.value?.transientFailure;
        final nextFailure = next.value?.transientFailure;
        final didFail = prevFailure == null && nextFailure != null;
        if (didFail) {
          if (!mounted) return;
          showErrorSnackbar(context, message: nextFailure.message);
          ref
              .read(postListControllerProvider.notifier)
              .consumeTransientFailure();
        }
      },
    );
    final asyncState = ref.watch(postListControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: asyncState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => AsyncErrorRetryCentered(
          message: presentationFailureMessage(error),
          onRetry: () => ref.invalidate(postListControllerProvider),
        ),
        data: (state) {
          switch (state.status) {
            case PostListStatus.failure:
              return AsyncErrorRetryCentered(
                message: state.failure?.message ?? 'Unknown error',
                onRetry: () => ref.invalidate(postListControllerProvider),
              );
            case _:
              if (state.posts.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(postListControllerProvider.notifier)
                        .refresh();
                  },
                  child: LayoutBuilder(
                    builder: (context, contraints) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: contraints.maxHeight,
                          ),
                          child: const Center(
                            child: Text(
                              'There are no posts to display.',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await ref.read(postListControllerProvider.notifier).refresh();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: state.hasReachedMax
                      ? state.posts.length
                      : state.posts.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.posts.length) {
                      return (state.status == PostListStatus.fetchingNextPage)
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox.shrink();
                    }
                    final post = state.posts[index];
                    return PostCard(post: post);
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
