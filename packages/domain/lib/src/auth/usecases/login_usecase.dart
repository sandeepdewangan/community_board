import 'package:core/errors.dart';
import 'package:core/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/repositories.dart';

class LoginParams extends Equatable {
  const new({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class LoginUsecase implements UseCase<void, LoginParams> {
  new({required this._authRepository});

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, void>> call(LoginParams params) async {
    return await _authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}
