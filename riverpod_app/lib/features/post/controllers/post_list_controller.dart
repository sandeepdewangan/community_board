import 'package:domain/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/unexpected_failure.dart';
import '../presentation/providers/post_providers.dart';
import 'post_list_state.dart';

part 'post_list_controller.g.dart';

const _pageSize = 5;

@riverpod
class PostListController extends _$PostListController {
  @override
  FutureOr<PostListState> build() async {
    final useCase = ref.watch(getPostUsecaseProvider);
    final result = await useCase(
      const GetPostsParams(offset: 0, limit: _pageSize),
    );
    return result.fold(
      (failure) =>
          PostListState(status: PostListStatus.failure, failure: failure),
      (posts) => PostListState(
        status: PostListStatus.loaded,
        posts: posts,
        hasReachedMax: posts.length < _pageSize,
      ),
    );
  }

  Future<void> fetchNextPage() async {
    final snapshot = state.value;
    if (snapshot == null || state.isLoading) return;
    if (snapshot.hasReachedMax ||
        snapshot.status == PostListStatus.fetchingNextPage ||
        snapshot.status == PostListStatus.refreshing ||
        snapshot.status == PostListStatus.refilling) {
      return;
    }
    // Show the loading indicator
    state = AsyncData(
      snapshot.copyWith(status: PostListStatus.fetchingNextPage),
    );

    // Fetch the next page
    try {
      await Future.delayed(const Duration(seconds: 2));
      // what if the user left the screen, memory leak will occured. Use if mounted.
      if (!ref.mounted) return; // Is this controller still alive?
      final useCase = ref.read(getPostUsecaseProvider);
      final result = await useCase(
        GetPostsParams(offset: snapshot.posts.length, limit: _pageSize),
      );
      if (!ref.mounted) return;
      // latest can become null when invalidate or refresh is called in between.
      final latest = state.value;
      if (latest == null) return;

      state = AsyncData(
        result.fold(
          (failure) => latest.copyWith(
            status: PostListStatus.loaded,
            transientFailure: () => failure,
          ),
          (newPosts) => latest.copyWith(
            status: PostListStatus.loaded,
            posts: [...latest.posts, ...newPosts],
            hasReachedMax: newPosts.length < _pageSize,
          ),
        ),
      );
    } catch (e, st) {
      // Prevent infinity loading
      if (!ref.mounted) return;
      final latest = state.value;
      if (latest == null) return;
      state = AsyncData(
        latest.copyWith(
          status: PostListStatus.loaded,
          transientFailure: () => logUnexpectedFailure(e, st),
        ),
      );
    }
  }

  Future<void> refresh() async {
    final snapshot = state.value;
    if (snapshot == null || state.isLoading) return;
    if (snapshot.hasReachedMax ||
        snapshot.status == PostListStatus.fetchingNextPage ||
        snapshot.status == PostListStatus.refreshing ||
        snapshot.status == PostListStatus.refilling) {
      return;
    }
    state = AsyncData(snapshot.copyWith(status: PostListStatus.refreshing));

    try {
      final useCase = ref.read(getPostUsecaseProvider);
      final result = await useCase(
        const GetPostsParams(offset: 0, limit: _pageSize),
      );
      if (!ref.mounted) return;

      final latest = state.value;
      if (latest == null) return;

      state = AsyncData(
        result.fold(
          (failure) => latest.copyWith(
            status: PostListStatus.loaded,
            transientFailure: () => failure,
          ),
          (posts) => latest.copyWith(
            status: PostListStatus.loaded,
            posts: posts,
            hasReachedMax: posts.length < _pageSize,
          ),
        ),
      );
    } catch (e, st) {
      if (!ref.mounted) return;
      final latest = state.value;
      if (latest == null) return;
      state = AsyncData(
        latest.copyWith(
          status: PostListStatus.loaded,
          transientFailure: () => logUnexpectedFailure(e, st),
        ),
      );
    }
  }

  void consumeTransientFailure() {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(transientFailure: () => null));
  }
}
