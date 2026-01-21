import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/api/api_client.dart';
import 'package:lost_n_found/core/api/api_endpoints.dart';
import 'package:lost_n_found/core/services/storage/token_service.dart';
import 'package:lost_n_found/core/services/storage/user_session_service.dart';
import 'package:lost_n_found/features/auth/data/datasources/auth_datasource.dart';
import 'package:lost_n_found/features/auth/data/models/auth_api_model.dart';

// Provider
final authRemoteDatasoureProvider = Provider<IAuthRemoteDatasource>((ref) {
  return AuthRemoteDataSource(
    apiClient: ref.read(apiClientProvider),
    userSessionService: ref.read(userSessionServiceProvider),
    tokenService: ref.read(tokenServiceProvider),
  );
});

class AuthRemoteDataSource implements IAuthRemoteDatasource {
  final ApiClient _apiClient;
  final UserSessionService _userSessionService;
  final TokenService _tokenService;

  AuthRemoteDataSource({
    required ApiClient apiClient,
    required UserSessionService userSessionService,
    required TokenService tokenService,
  }) : _apiClient = apiClient,
       _userSessionService = userSessionService,
       _tokenService = tokenService;

  @override
  Future<AuthApiModel> getUserById(String authId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<AuthApiModel> login(String email, String password) async {
    final response = await _apiClient.post(
      ApiEndpoints.studentLogin,
      data: {'email': email, "password": password},
    );

    if (response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>;
      final user = AuthApiModel.fromJson(data);

      // Save to session
      await _userSessionService.storeUserSession(
        isLoggedIn: true,
        userId: user.username,
        email: email,
        username: user.username,
        fullName: user.fullName,
        phoneNumber: user.phoneNumber,
        batchId: user.batchId,
      );

      // Save token
      final token = response.data['token'] as String?;
      await _tokenService.saveToken(token!);
      return user;
    }
    return null;
  }

  @override
  Future<AuthApiModel> register(AuthApiModel user) async {
    final response = await _apiClient.post(
      ApiEndpoints.students,
      data: user.toJson(),
    );

    if (response.data["success"] == true) {
      final data = response.data["data"] as Map<String, dynamic>;
      final registeredUser = AuthApiModel.fromJson(data);
      return registeredUser;
    }
    return user;
  }
}
