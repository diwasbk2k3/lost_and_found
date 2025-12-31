import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/features/auth/domain/usecases/login_usecase.dart';
import 'package:lost_n_found/features/auth/domain/usecases/register_usecase.dart';
import 'package:lost_n_found/features/auth/presentation/state/auth_state.dart';

// Provider implementation for AuthViewModel
final authViewModelProvider = NotifierProvider<AuthViewModel, AuthState>(
  () => AuthViewModel(),
);

class AuthViewModel extends Notifier<AuthState> {
  late final RegisterUsecase _registerUsecase;
  late final LoginUsecase _loginUsecase;

  @override
  AuthState build() {
    _registerUsecase = ref.read(registerUsecaseProvider);
    _loginUsecase = ref.read(loginUsecaseProvider);
    return const AuthState();
  }

  // Register method
  Future<void> register({
    required String fullName,
    required String email,
    String? phoneNumber,
    String? batchId,
    required String username,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    // wait for 2 seconds to simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    final params = RegisterUsecaseParams(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      batchId: batchId,
      username: username,
      password: password,
    );
    final result = await _registerUsecase(params);
    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (authEntity) {
        state = state.copyWith(status: AuthStatus.registered);
      },
    );
  }

  // Login method
  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading);
    final params = LoginUseCaseParams(email: email, password: password);
    // wait for 2 seconds to simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    final result = await _loginUsecase(params);
    result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
        );
      },
      (authEntity) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          authEntity: authEntity,
        );
      },
    );
  }
}
