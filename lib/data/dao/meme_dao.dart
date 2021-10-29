import 'package:image_flip/data/service/app_database.dart';
import 'package:image_flip/models/get_meme_response.dart';
import 'package:sembast/sembast.dart';

class MemeDao {
  static const String MEME_STORE_NAME = "MEMES";
  final _memeStore = intMapStoreFactory.store(MEME_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Memes meme) async {
    await _memeStore.add(await _db, meme.toJson());
  }

  Future update(Memes meme) async {
    final finder = Finder(filter: Filter.byKey(meme.id));
    await _memeStore.update(await _db, meme.toJson(), finder: finder);
  }

  Future delete(Memes meme) async {
    final finder = Finder(filter: Filter.byKey(meme.id));
    await _memeStore.delete(await _db, finder: finder);
  }
}
