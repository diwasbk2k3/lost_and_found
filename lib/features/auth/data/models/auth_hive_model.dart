import 'package:hive/hive.dart';
import 'package:lost_n_found/core/constants/hive_table_constant.dart';
import 'package:lost_n_found/features/auth/domain/entities/auth_entity.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.authTypeId)

class AuthHiveModel extends HiveObject {
  @HiveField(0)
  String? authId;

  @HiveField(1)
  String fullName;

  @HiveField(2)
  String email;

  @HiveField(3)
  String? phoneNumber;

  @HiveField(4)
  String? batchId;

  @HiveField(5)
  String username;

  @HiveField(6)
  String? password;

  @HiveField(7)
  String? profilePicture;

  AuthHiveModel({
    String? authId,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.batchId,
    required this.username,
    this.password,
    this.profilePicture,
  }) : authId = authId ?? const Uuid().v4();


  // From Entity 
  factory AuthHiveModel.fromEntity(entity) {
    return AuthHiveModel(
      authId: entity.authId,
      fullName: entity.fullName,
      email:  entity.email,
      phoneNumber: entity.phoneNumber,
      batchId: entity.batchId,
      username: entity.username,
      password: entity.password,
      profilePicture: entity.profilePicture,
    );
  }

  // To Entity
  AuthEntity toEntity({BatchEntity? batchEntity}) {
    return AuthEntity(
      authId: authId,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      batchId: batchId,
      batch: batchEntity,
      username: username,
      password: password,
      profilePicture: profilePicture,
    );
  }

  // To Entity List
  static List<AuthEntity> toEntityList(List<AuthHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
