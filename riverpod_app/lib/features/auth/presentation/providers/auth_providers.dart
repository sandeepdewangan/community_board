import 'package:data_supabase/auth.dart';
import 'package:domain/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/supabase_providers.dart';

part 'auth_providers.g.dart';

// ---------------------------------------------------
// Data Layer Provider
// ---------------------------------------------------

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return SupabaseAuthRemoteDataSource(
    supabaseClient: ref.watch(supabaseClientProvider),
  );
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepoImpl(
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
  );
}

// ---------------------------------------------------
// Domain Layer Provider
// ---------------------------------------------------

@riverpod
SignupUsecase signupUsecase(Ref ref) {
  return SignupUsecase(authRepository: ref.watch(authRepositoryProvider));
}

@riverpod
LoginUsecase loginUsecase(Ref ref) {
  return LoginUsecase(authRepository: ref.watch(authRepositoryProvider));
}

@riverpod
LogoutUsecase logoutUsecase(Ref ref) {
  return LogoutUsecase(authRepository: ref.watch(authRepositoryProvider));
}
