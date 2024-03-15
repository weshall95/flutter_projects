import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

dynamic database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = await openDatabase(
    join(await getDatabasesPath(), "ToDoDB.db"),
    version: 1,
    onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE ToDoData(
          title TEXT PRIMARY KEY,
          description TEXT,
          date INTEGER
        )
      ''');
    },
  );

  final todoAppUIState = _TODOAppUIState();

  // Fetch data from the database using the instance
  final List<Map<String, dynamic>> data = await todoAppUIState.getTaskData();
  for (final taskData in data) {
    print(
        'Title: ${taskData['title']}, Description: ${taskData['description']}, Date: ${taskData['date']}');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TODOAppUI(),
    );
  }
}

class TODOAppUI extends StatefulWidget {
  const TODOAppUI({super.key});

  @override
  State<TODOAppUI> createState() => _TODOAppUIState();
}

class _TODOAppUIState extends State<TODOAppUI> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<TODOModel> tasks = []; // List to hold tasks

  Future<void> initializeDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), "ToDoDB.db"),
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE ToDoData(
            title TEXT PRIMARY KEY,
            description TEXT,
            date INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertTaskData(TODOModel task) async {
    final db = await database;
    await db.insert(
      'ToDoData',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getTaskData() async {
    final db = await database;
    return await db.query('ToDoData');
  }

  Future<void> deleteTaskData(String title) async {
    final db = await database;
    await db.delete(
      'ToDoData',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  Future<void> showBottomSheet(BuildContext context, doEdit,
      [TODOModel? todoModelObj]) async {
    // Function to show bottom sheet for adding/editing tasks
    await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Create Tasks",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                          color: const Color.fromRGBO(89, 57, 241, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: "Enter Title",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(89, 57, 241, 1),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Description",
                        style: TextStyle(
                          color: const Color.fromRGBO(89, 57, 241, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Enter Description",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(89, 57, 241, 1),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Date",
                        style: TextStyle(
                          color: const Color.fromRGBO(89, 57, 241, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      TextFormField(
                        controller: dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Enter Date",
                          suffixIcon: const Icon(Icons.date_range_rounded),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(89, 57, 241, 1),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2025),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat.yMMMd().format(pickedDate);
                            dateController.text = formattedDate;
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      backgroundColor: const Color.fromRGBO(89, 57, 241, 1),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (doEdit) {
                          // Edit existing task
                          // Update the task in the list with new data
                          final editedTask = TODOModel(
                            title: titleController.text,
                            description: descriptionController.text,
                            date: DateFormat.yMMMd().parse(dateController.text),
                          );
                          setState(() {
                            tasks[tasks.indexWhere((element) =>
                                    element.title == todoModelObj!.title)] =
                                editedTask;
                          });
                          deleteTaskData(todoModelObj!.title);
                          insertTaskData(editedTask);
                        } else {
                          // Add new task
                          final newTask = TODOModel(
                            title: titleController.text,
                            description: descriptionController.text,
                            date: DateFormat.yMMMd().parse(dateController.text),
                          );
                          setState(() {
                            tasks.add(newTask);
                            // Clear text fields after adding a new task
                            titleController.clear();
                            descriptionController.clear();
                            dateController.clear();
                          });
                          insertTaskData(newTask);
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                "Good Morning",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                "Vishal",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "CREATE TASKS",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: FutureBuilder<List<Map<String, dynamic>>>(
                          future: getTaskData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasData) {
                              tasks = snapshot.data!
                                  .map((taskMap) => TODOModel.fromMap(taskMap))
                                  .toList();
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: tasks.length,
                                itemBuilder: (context, index) {
                                  final task = tasks[index];
                                  final colors = [
                                    const Color.fromRGBO(250, 232, 232, 1),
                                    const Color.fromRGBO(232, 237, 250, 1),
                                    const Color.fromRGBO(250, 249, 232, 1),
                                    const Color.fromRGBO(250, 232, 250, 1),
                                    const Color.fromRGBO(250, 232, 232, 1),
                                    const Color.fromRGBO(252, 232, 232, 1),
                                    const Color.fromRGBO(233, 237, 250, 1),
                                    const Color.fromRGBO(255, 249, 232, 1),
                                    const Color.fromRGBO(256, 232, 250, 1),
                                  ];
                                  final color = colors[index % colors.length];
                                  return Slidable(
                                    closeOnScroll: true,
                                    endActionPane: ActionPane(
                                      extentRatio: 0.25,
                                      motion: const DrawerMotion(),
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  // Edit task
                                                  titleController.text =
                                                      task.title;
                                                  descriptionController.text =
                                                      task.description;
                                                  dateController.text =
                                                      DateFormat.yMMMd()
                                                          .format(task.date);
                                                  showBottomSheet(
                                                      context, true, task);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                        89, 57, 241, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  // Delete task
                                                  setState(() {
                                                    tasks.removeAt(index);
                                                  });
                                                  deleteTaskData(task.title);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(
                                                        89, 57, 241, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    key: ValueKey(index),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20, top: 20),
                                      decoration: BoxDecoration(
                                        color:
                                            color, // Assign color based on index
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 0.05),
                                            width: 0.5),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 20,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.13),
                                          ),
                                        ],
                                        borderRadius:
                                            const BorderRadius.all(Radius.zero),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(
                                                  217, 217, 217, 1),
                                            ),
                                            child: Image.network(
                                              "https://cdni.iconscout.com/illustration/premium/thumb/todo-list-6114062-5059486.png", // Provide correct path to your image
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width:
                                                200, // Adjusted width to fit content properly
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  task.title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  task.description,
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        0, 0, 0, 0.7),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  DateFormat.yMMMd()
                                                      .format(task.date),
                                                  style: TextStyle(
                                                    color: const Color.fromRGBO(
                                                        0, 0, 0, 0.7),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Checkbox(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            activeColor: Colors.green,
                                            value: true,
                                            onChanged: (val) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text('No tasks available'),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(89, 57, 241, 1),
        onPressed: () async {
          // Show bottom sheet for adding a new task
          await showBottomSheet(context, false);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TODOModel {
  final String title;
  final String description;
  final DateTime date;

  TODOModel({
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory TODOModel.fromMap(Map<String, dynamic> map) {
    return TODOModel(
      title: map['title'],
      description: map['description'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }
}
