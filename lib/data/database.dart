import 'package:path/path.dart';
import 'package:personal_task_organizer/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'task.db');

  // O método 'onCreate' é chamado caso sqflite não consiga retornar a abertura do banco no caminho especificado para o path;
  // Basicamente, ele vai criar um novo banco de dados caso não encontre um banco de dados já criado no path;
  return openDatabase(path, onCreate: (db, version) {
    db.execute(TaskDao.tableSql);
  }, version: 1);
}
