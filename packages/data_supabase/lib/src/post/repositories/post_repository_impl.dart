import 'package:core/errors.dart';
import 'package:domain/post.dart';
import 'package:fpdart/fpdart.dart';

import '../datasources/datasources.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl({required this._postRemoteDatasource});
  final PostRemoteDatasource _postRemoteDatasource;

  @override
  Future<Either<Failure, List<PostDisplay>>> getPosts({
    required int offset,
    required int limit,
  }) async {
    try {
      final posts = await _postRemoteDatasource.getPosts(
        offset: offset,
        limit: limit,
      );
      return Right(posts);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on PermissionException catch (e) {
      return Left(PermissionFailure(message: e.message));
    } on DatabaseException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on UnknownException catch (e) {
      return left(UnknownFailure(message: e.message));
    }
  }
}
