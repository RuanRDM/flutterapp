import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/curso.dart';
import 'app_database.dart';

class CursoDao {
  static const String _tableName = "cursos";
  static const String _id = "id";
  static const String _nome = "nome";
  static const String _horas = "horas";
  static const String _descricao = "descricao";
  static const String _autor = "autor";

  static const String tableSql = 'CREATE TABLE cursos ( '
      ' id INTEGER PRIMARY KEY, '
      ' nome TEXT, '
      ' horas TEXT, '
      ' descricao TEXT, '
      ' autor TEXT)';

  Map<String, dynamic> toMap(Curso curso){
    final Map<String, dynamic> cursoMap = Map();
    cursoMap[_nome] = curso.nome;
    cursoMap[_horas] = curso.horas;
    cursoMap[_descricao] = curso.descricao;
    cursoMap[_autor] = curso.autor;
    return cursoMap;
  }

  Future<int> save(Curso curso) async{
    final Database db = await getDatabase();
    Map<String, dynamic> cursoMap = toMap(curso);
    return db.insert(_tableName, cursoMap);
  }

  Future<int> update(Curso curso) async{
    final Database db = await getDatabase();
    Map<String, dynamic> cursoMap = toMap(curso);
    return db.update(_tableName, cursoMap, where: 'id = ?',
        whereArgs: [curso.id]);
  }

  Future<int> delete(int id ) async {
    final Database db = await getDatabase();
    return db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  List<Curso> toList (List<Map<String, dynamic>> result){
    final List<Curso> cursos = [];
    for (Map<String, dynamic> row in result){
      final Curso curso = Curso(row[_id],
          row[_nome],
          row[_horas],
          row[_descricao],
          row[_autor]);
      cursos.add(curso);
    }
    return cursos;
  }
  Future<List<Curso>> findAll() async{
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Curso> cursos = toList(result);
    return cursos;
  }
}
