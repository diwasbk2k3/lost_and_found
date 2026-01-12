import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/services/hive/hive_service.dart';
import 'package:lost_n_found/core/services/storage/user_session_service.dart';
import 'package:lost_n_found/features/auth/data/datasources/auth_datasource.dart';
import 'package:lost_n_found/features/auth/data/models/auth_hive_model.dart';

// Provide implementation for Auth Local Datasource
final authLocalDatasourceProvider = Provider<AuthLocalDatasource>((ref) {
  final hiveService = ref.read(hiveServiceProvider);
  final userSessionService = ref.read(userSessionServiceProvider);
  return AuthLocalDatasource(
    hiveService: hiveService,
    userSessionService: userSessionService,
  );
});

class AuthLocalDatasource implements IAuthLocalDatasource {
  final HiveService _hiveService;
  final UserSessionService _userSessionService;

  AuthLocalDatasource({
    required HiveService hiveService,
    required UserSessionService userSessionService,
  }) : _hiveService = hiveService,
       _userSessionService = userSessionService;

  @override
  Future<AuthHiveModel?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isEmailExists(String email) {
    // TODO: implement isEmailExists
    throw UnimplementedError();
  }

  @override
  Future<bool> login(String email, String password) async {
    try {
      final user = await _hiveService.loginUser(email, password);
      // Store user session data if login is successful
      if(user != null) {
        await _userSessionService.storeUserSession(
          isLoggedIn: true,
          userId: user.authId!,
          email: user.email,
          username: user.username,
          fullName: user.fullName,
          phoneNumber: user.phoneNumber,
          batchId: user.batchId,
          profilePicture: user.profilePicture ?? "",
        );
      } 
      return user != null;
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await _hiveService.logoutUser();
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<bool> register(AuthHiveModel model) async {
    try {
      await _hiveService.registerUser(model);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
