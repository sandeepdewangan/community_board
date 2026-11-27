// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(postRemoteDataSource)
final postRemoteDataSourceProvider = PostRemoteDataSourceProvider._();

final class PostRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          PostRemoteDatasource,
          PostRemoteDatasource,
          PostRemoteDatasource
        >
    with $Provider<PostRemoteDatasource> {
  PostRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<PostRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PostRemoteDatasource create(Ref ref) {
    return postRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostRemoteDatasource>(value),
    );
  }
}

String _$postRemoteDataSourceHash() =>
    r'd7a58caa4c778832dcee962af1cb6bffaf77cd30';

@ProviderFor(postRepository)
final postRepositoryProvider = PostRepositoryProvider._();

final class PostRepositoryProvider
    extends $FunctionalProvider<PostRepository, PostRepository, PostRepository>
    with $Provider<PostRepository> {
  PostRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postRepositoryHash();

  @$internal
  @override
  $ProviderElement<PostRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PostRepository create(Ref ref) {
    return postRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostRepository>(value),
    );
  }
}

String _$postRepositoryHash() => r'32c85f5ccfbfa34ddd587f998188f5f850b115f3';

@ProviderFor(getPostUsecase)
final getPostUsecaseProvider = GetPostUsecaseProvider._();

final class GetPostUsecaseProvider
    extends
        $FunctionalProvider<GetPostsUsecase, GetPostsUsecase, GetPostsUsecase>
    with $Provider<GetPostsUsecase> {
  GetPostUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPostUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPostUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetPostsUsecase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetPostsUsecase create(Ref ref) {
    return getPostUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPostsUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPostsUsecase>(value),
    );
  }
}

String _$getPostUsecaseHash() => r'4674bd6258451763277c0328f936f1c1c737b982';
