import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'tarefa_dao.dart';
import 'curso_dao.dart';

const String teste = 'SELECT * from tarefas';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'dbapp32231213.db');
  return openDatabase(path,
      onCreate: (db, version){
        var batch = db.batch();
        db.execute(TarefaDao.tableSql);
        db.execute(CursoDao.tableSql);
        batch.execute('SELECT * from tarefas');
      },
      onUpgrade:( db, oldVersion, newVersion) async{
        var batch = db.batch();
        print("versão antiga: "+ oldVersion.toString());
        print("versão nova: "+ newVersion.toString());
        if (newVersion==2){
          batch.execute('DROP TABLE IF EXISTS tarefas'); // Excluir tabela tarefas
           // Excluir tabela tarefas
          // Criar novamente a tabela tarefas
          batch.execute(TarefaDao.tableSql);
          print("Recriando a tabela tarefas");
          batch.execute('DROP TABLE IF EXISTS cursos');
          batch.execute(CursoDao.tableSql);
          print("Recriando a tabela cursos");

          batch.execute(teste);
        }
        await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
      version: 2);
}