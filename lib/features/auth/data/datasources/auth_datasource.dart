import 'package:lost_n_found/features/auth/data/models/auth_api_model.dart';
import 'package:lost_n_found/features/auth/data/models/auth_hive_model.dart';

abstract interface class IAuthLocalDatasource {
  Future<bool> register(AuthHiveModel model);
  Future<bool> login(String email, String password);
  Future<AuthHiveModel?> getCurrentUser();
  Future<bool> logout();

  // Get Email Exists
  Future<bool> isEmailExists(String email);
}

abstract interface class IAuthRemoteDatasource {
  Future<AuthApiModel> register(AuthApiModel user);
  Future<AuthApiModel> login(String email, String password);
  Future<AuthApiModel> getUserById(String authId);
}