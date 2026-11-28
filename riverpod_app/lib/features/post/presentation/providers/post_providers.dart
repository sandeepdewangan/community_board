import 'package:data_supabase/post.dart';
import 'package:domain/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/supabase_providers.dart';

part 'post_providers.g.dart';

// ---------------------------------------------------
// Data Layer Provider
// ---------------------------------------------------

@riverpod
PostRemoteDatasource postRemoteDataSource(Ref ref) {
  return SupabasePostRemoteDatasource(
    supabaseClient: ref.watch(supabaseClientProvider),
  );
}

@riverpod
PostRepository postRepository(Ref ref) {
  return PostRepositoryImpl(
    postRemoteDatasource: ref.watch(postRemoteDataSourceProvider),
  );
}

// ---------------------------------------------------
// Domain Layer Provider
// ---------------------------------------------------

@riverpod
GetPostsUsecase getPostUsecase(Ref ref) {
  return GetPostsUsecase(postRepository: ref.watch(postRepositoryProvider));
}

@riverpod
CreatePostUsecase createPostUsecase(Ref ref) {
  return CreatePostUsecase(postRepository: ref.watch(postRepositoryProvider));
}

@riverpod
UploadPostImageUsecase uploadPostImageUsecase(Ref ref) {
  return UploadPostImageUsecase(
    postRepository: ref.watch(postRepositoryProvider),
  );
}
