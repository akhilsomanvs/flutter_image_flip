import 'package:flutter/foundation.dart';
import 'package:image_flip/data/dataSources/local_data_source.dart';
import 'package:image_flip/data/dataSources/remote_data_source.dart';
import 'package:image_flip/models/get_meme_response.dart';

class MemeController extends ChangeNotifier {
  bool showLoading = false;

  GetMemeResponseModel? memeResponseModel;

  List<Memes> _savedMemesList = [];

  List<Memes> get savedMemesList => _savedMemesList;

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

  saveMeme(Memes meme) async {
    await LocalDataSource.saveMemeToDB(meme);
    notifyListeners();
  }

  removeMeme(Memes meme)async{
    await LocalDataSource.removeMemeFromDB(meme);
    notifyListeners();
  }

  getSavedMemes() async {
    _savedMemesList = await LocalDataSource.getSavedMemes();
    notifyListeners();
  }
}
