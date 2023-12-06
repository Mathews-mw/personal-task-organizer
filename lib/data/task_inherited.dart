import 'package:flutter/material.dart';
import 'package:personal_task_organizer/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
    Task(
      task: 'Aprender Flutter',
      image:
          'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
      difficulty: 4,
    ),
    Task(
      task: 'Ler',
      image:
          'https://thebogotapost.com/wp-content/uploads/2017/06/636052464065850579-137719760_flyer-image-1.jpg',
      difficulty: 3,
    ),
    Task(
      task: 'Meditar',
      image:
          'https://manhattanmentalhealthcounseling.com/wp-content/uploads/2019/06/Top-5-Scientific-Findings-on-MeditationMindfulness-881x710.jpeg',
      difficulty: 5,
    ),
    Task(
      task: 'Aprender Android',
      image:
          'https://images.unsplash.com/photo-1607252650355-f7fd0460ccdb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
      difficulty: 3,
    ),
    Task(
      task: 'Jogar videogame',
      image:
          'https://images.unsplash.com/photo-1580327344181-c1163234e5a0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2067&q=80',
      difficulty: 5,
    ),
    Task(
      task: 'Programar',
      image:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
      difficulty: 4,
    ),
  ];

  void newTask({required task, required image, required difficulty}) {
    taskList.add(Task(task: task, image: image, difficulty: difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
