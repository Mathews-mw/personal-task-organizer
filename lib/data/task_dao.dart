import 'package:personal_task_organizer/data/database.dart';
import 'package:sqflite/sqflite.dart';

import '../components/task.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task task) async {
    final Database db = await getDatabase();

    var existingTask = await findByName(task.task);
    Map<String, dynamic> taskMap = toMap(task);

    if (existingTask.isNotEmpty) {
      return await db.update(
        _tableName,
        taskMap,
        where: '$_name = ?',
        whereArgs: [task.task],
      );
    }

    return await db.insert(_tableName, taskMap);
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    return toList(result);
  }

  Future<List<Task>> findByName(String taskName) async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_name = ?',
      whereArgs: [taskName],
    );

    return toList(result);
  }

  delete(String taskName) async {
    final Database db = await getDatabase();

    return await db.delete(
      _tableName,
      where: '$_name = ?',
      whereArgs: [taskName],
    );
  }

  List<Task> toList(List<Map<String, dynamic>> taskMap) {
    final List<Task> taskList = [];

    for (Map<String, dynamic> line in taskMap) {
      final Task task = Task(
        task: line[_name],
        image: line[_image],
        difficulty: line[_difficulty],
      );
      taskList.add(task);
    }

    return taskList;
  }

  Map<String, dynamic> toMap(Task task) {
    final Map<String, dynamic> taskMap = Map();

    taskMap[_name] = task.task;
    taskMap[_image] = task.image;
    taskMap[_difficulty] = task.difficulty;

    return taskMap;
  }
}
