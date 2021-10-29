import 'package:flutter/foundation.dart';
import 'package:image_flip/data/dataSources/local_data_source.dart';
import 'package:image_flip/data/dataSources/remote_data_source.dart';
import 'package:image_flip/data/repositories/api/api_response.dart';
import 'package:image_flip/models/get_meme_response.dart';

class MemeController extends ChangeNotifier {
  bool showLoading = false;
  bool hasError = false;
  String errorMessage = "";

  GetMemeResponseModel? memeResponseModel;

  List<Memes> _memesList = [];
  List<Memes> _savedMemesList = [];

  List<Memes> get memeList => _memesList;

  get savedMemesList => _memesList.where((e) => e.isSaved).toList();

  getMemes({Function? onFailure}) async {
    showLoading = true;
    notifyListeners();

    //fetch metadata from API
    final response = await RemoteDataSource().fetchMemeMetaData();
    if (response.data != null && response.data is GetMemeResponseModel) {
      memeResponseModel = response.data;
      hasError = false;
      errorMessage = "";

      if (memeResponseModel != null) {
        _memesList = memeResponseModel!.data.memes;
      }
    } else if (response.status == Status.ERROR) {
      hasError = true;
      errorMessage = response.message ?? "";
    }
    await getSavedMemes();
    for (var meme in _memesList) {
      final index = _savedMemesList.indexWhere((element) => element.id == meme.id);
      if (index != -1) {
        meme.isSaved = true;
      }
    }
    showLoading = false;
    notifyListeners();
  }

  saveMeme(Memes meme) async {
    await LocalDataSource.saveMemeToDB(meme);
    meme.isSaved = true;
    _savedMemesList.add(meme);
    notifyListeners();
  }

  removeMeme(Memes meme) async {
    await LocalDataSource.removeMemeFromDB(meme);
    meme.isSaved = false;
    _savedMemesList.remove(meme);
    notifyListeners();
  }

  getSavedMemes() async {
    _savedMemesList = await LocalDataSource.getSavedMemes();
    if (_memesList.isNotEmpty) {
      for (var element in _memesList) {
        final index = _savedMemesList.indexWhere((meme) => meme.id == element.id);
        element.isSaved = index != -1;
      }
    } else {
      _savedMemesList.forEach((element) {
        element.isSaved = true;
        _memesList.add(element);
      });
    }
    notifyListeners();
  }
}
