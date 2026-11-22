import 'package:core/errors.dart';
import 'package:core/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/repositories.dart';

class LogoutUsecase implements UseCase<void, NoParams> {
  new({required this._authRepository});

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _authRepository.logout();
  }
}
