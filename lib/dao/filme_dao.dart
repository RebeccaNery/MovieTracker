import '../database/database_helper.dart';
import '../model/filme.dart';

class FilmeDao {
  late DatabaseHelper dbHelper;

  FilmesDao() {
    dbHelper = DatabaseHelper();
  }

  Future<int?> save(Filme filme) async {
    final db = await dbHelper.initDB();
    try {
      return await db.insert('filmes', filme.toJson());
    } catch (e) {
      print(e);
      return null;
    } finally {
      db.close();
    }
  }

  Future<List<Filme>?> findAll() async {
    final db = await dbHelper.initDB();
    try {
      final listMap = await db.query('filmes');
      List<Filme> filmes = [];
      for (var map in listMap) {
        filmes.add(Filme.fromJson(map));
      }

      return filmes;
    } catch (e) {
      return null;
    } finally {
      db.close();
    }
  }
}
