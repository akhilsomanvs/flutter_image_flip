import 'package:flutter/foundation.dart';
import 'package:image_flip/data/dataSources/remote_data_source.dart';
import 'package:image_flip/data/repositories/api/api_response.dart';
import 'package:image_flip/data/service/api_service.dart';
import 'package:image_flip/models/get_meme_response.dart';

class MemeController extends ChangeNotifier {

  bool showLoading = false;

  GetMemeResponseModel? memeResponseModel;

  getMemes() async {
    showLoading = true;
    notifyListeners();

    //fetch metadata from API
    final response = await RemoteDataSource().fetchMemeMetaData();
    if (response.data != null && response.data is GetMemeResponseModel) {
      memeResponseModel = response.data;
    }
    showLoading = false;
    notifyListeners();
  }
}
