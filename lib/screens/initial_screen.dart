import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:personal_task_organizer/components/task.dart';
import 'package:personal_task_organizer/data/task_dao.dart';
import 'package:personal_task_organizer/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final String text = loremIpsum(words: 60);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
        title: const Text('Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Task task = items[index];
                            return task;
                          });
                    }
                    return const Center(
                      child: Column(
                        children: [
                          Icon(Icons.error_outline, size: 128),
                          Text(
                            'Não há tarefas cadastradas',
                            style: TextStyle(fontSize: 32),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Text('Erro ao carregar tarefas');
                case ConnectionState.waiting ||
                      ConnectionState.active ||
                      ConnectionState.none:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando')
                      ],
                    ),
                  );
              }
              return Text('Erro interno');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contextNew) => FormScreen(
                      taskContext: context,
                    )),
          ).then((value) => setState(
              () {})); // A função setState será chamada toda vez que a navegação voltar para a tela inicial.
          // Nesse caso, essa função ficará responsável por recarregar os dados do banco de dados em na tela quando voltar para a tela inicial.
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
