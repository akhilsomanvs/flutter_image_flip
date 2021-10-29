import 'package:image_flip/data/dao/meme_dao.dart';
import 'package:image_flip/models/get_meme_response.dart';

class LocalDataSource {
  static final MemeDao _dao = MemeDao();

  static saveMemeToDB(Memes meme) async {
    await _dao.insert(meme);
  }

  static removeMemeFromDB(Memes meme) async {
    await _dao.delete(meme);
  }

  static Future<List<Memes>> getSavedMemes() async {
    final list = await _dao.getAllMemes();
    return list;
  }
}
