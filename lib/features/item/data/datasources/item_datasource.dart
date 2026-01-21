import 'dart:io';

// abstract interface class IItemLocalDataSource{
//   Future<List<ItemHiveModel>> getAllItems();
//   Future<List<ItemHiveModel>> getItemsByUser(String: userId);
// }

abstract interface class IItemRemoteDataSource {
  Future<String> uploadImage(File image);
  Future<String> uploadVideo(File video);
}
