import 'package:flutter/material.dart';

import 'package:todo_app/screens/LoginScreen.dart';

void main() {
  runApp(const MaterialApp(
    home: ToDo(),
  ));
}

class Task {
  late final String text;
  late final String date; // Change the type to String
  bool isCompleted;

  Task({required this.text, required this.date, this.isCompleted = false});
}

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<Task> tasks = [];

  List<Task> filteredTasks = [];

  @override
  void initState() {
    super.initState();
    // Initialize filteredTasks with all tasks initially
    filteredTasks.addAll(tasks);
  }

  void _filterTasks(String query) {
    setState(() {
      if (query.isEmpty) {
        // If the query is empty, show all tasks
        filteredTasks.clear();
        filteredTasks.addAll(tasks);
      } else {
        // If there is a query, filter tasks based on the query
        filteredTasks.clear();
        filteredTasks.addAll(
          tasks.where(
            (task) => task.text.toLowerCase().contains(query.toLowerCase()),
          ),
        );
      }
    });
  }

  void _editTask(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController taskController =
            TextEditingController(text: tasks[index].text);
        TextEditingController dateController =
            TextEditingController(text: tasks[index].date);

        return AlertDialog(
          title: const Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: const InputDecoration(
                  labelText: "Task",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: "Date",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  String taskText = taskController.text;
                  String taskDate = dateController.text;
                  if (taskText.isNotEmpty && taskDate.isNotEmpty) {
                    Task editedTask = Task(text: taskText, date: taskDate);

                    // Update the task in both lists based on identity
                    tasks[index] = editedTask;

                    filteredTasks = filteredTasks
                        .where((task) => task != tasks[index])
                        .toList();
                    filteredTasks.add(editedTask);
                  }
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do-of-Saranya"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Handle the Home menu option here (navigate to home page).
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen())); // Close the drawer
              },
            ),
            // Add more menu options as needed
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              onChanged: _filterTasks,
              decoration: InputDecoration(
                labelText: "Search tasks",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 238, 171, 232),
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        filteredTasks[index].text,
                        style: TextStyle(
                          fontSize: 18,
                          color: filteredTasks[index].isCompleted
                              ? Colors.grey
                              : Colors.black,
                          decoration: filteredTasks[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                          filteredTasks[index].date), // Use date as a string
                      leading: Checkbox(
                        value: filteredTasks[index].isCompleted,
                        onChanged: (bool? value) {
                          setState(() {
                            filteredTasks[index].isCompleted = value ?? false;
                          });
                        },
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              _editTask(index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                tasks.remove(filteredTasks[index]);
                                filteredTasks.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 4, 144, 53),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController taskController = TextEditingController();
              TextEditingController dateController = TextEditingController();

              return AlertDialog(
                title: const Text("Add a Task"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: taskController,
                      decoration: const InputDecoration(
                        labelText: "Task",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        labelText: "Date",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("Add"),
                    onPressed: () {
                      setState(() {
                        String taskText = taskController.text;
                        String taskDate = dateController.text;
                        if (taskText.isNotEmpty && taskDate.isNotEmpty) {
                          tasks.add(
                            Task(text: taskText, date: taskDate),
                          );
                          // Update filteredTasks as well
                          filteredTasks.add(
                            Task(text: taskText, date: taskDate),
                          );
                        }
                        Navigator.of(context).pop(); // Close the dialog
                      });
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
