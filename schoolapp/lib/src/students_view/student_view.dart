import 'package:flutter/material.dart';
import 'package:schoolapp/src/componnents/student_item.dart';
import 'package:schoolapp/src/students_view/student_controller.dart';
import 'package:schoolapp/src/students_view/student_model.dart';

class StudentView extends StatefulWidget {
  const StudentView({Key? key}) : super(key: key);

  @override
  _StudentViewState createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  List<StudentModel> _fullStudents = [];
  List<StudentModel> _students = [];
  String _name = '';
  bool _editing = false;

  final StudentController _controller = StudentController();
  @override
  void initState() {
    super.initState();
    _controller.getStudent();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 71, 166, 213),
        title: Text("Alunos"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Container(
                height: 35,
                width: 85,
                color: Color.fromARGB(255, 62, 145, 187),
                child: ElevatedButton(
                  child: Text("Novo"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 52, 120, 154)),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.95,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  TextField(
                                    decoration:
                                        InputDecoration(labelText: 'Nome'),
                                    onChanged: (value) => {_name = value},
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: ElevatedButton(
                                              onPressed: () => {
                                                    addStudent(_name),
                                                    Navigator.pop(context)
                                                  },
                                              child: Text('Salvar')),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancelar')),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                        });
                  },
                ),
              ),
              onTap: () => {},
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
              Color.fromARGB(255, 40, 100, 125),
              Color.fromARGB(255, 71, 166, 213)
            ])),
        child: Column(
          children: [
            Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusColor: Colors.red,
                      ),
                      onChanged: (value) => filterData(value),
                    ),
                  ),
                )),
            Flexible(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    return StudentItem(
                        id: _students[index].cod,
                        name: _students[index].name,
                        onPress: () => {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.95,
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            TextField(
                                              enabled: _editing,
                                              decoration: InputDecoration(
                                                  labelText: 'Nome'),
                                              controller:
                                                  (TextEditingController(
                                                      text: _students[index]
                                                          .name)),
                                              onChanged: (value) =>
                                                  {_name = value},
                                            ),
                                            Center(
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: ElevatedButton(
                                                        onPressed: () => {
                                                              if (_editing)
                                                                {
                                                                  _editing =
                                                                      false,
                                                                  editStudent(
                                                                      _students[
                                                                              index]
                                                                          .cod,
                                                                      _name),
                                                                  Navigator.pop(
                                                                      context)
                                                                }
                                                              else
                                                                {
                                                                  setState(() =>
                                                                      {
                                                                        _editing =
                                                                            true
                                                                      })
                                                                }
                                                            },
                                                        child: Text('Editar')),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: ElevatedButton(
                                                        onPressed: () => {
                                                              deleteStudent(
                                                                  _students[
                                                                          index]
                                                                      .cod),
                                                              Navigator.pop(
                                                                  context)
                                                            },
                                                        child: Text('Deletar')),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                  })
                            });
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: loadData,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  loadData() async {
    var temp = await _controller.getStudent();
    setState(() {
      _fullStudents = temp;
      _students = _fullStudents;
    });
  }

  filterData(String text) {
    setState(() {
      if (text.length > 0) {
        _students = _fullStudents
            .where((student) =>
                student.name.substring(0, text.length).toLowerCase() ==
                text.toLowerCase())
            .toList();
      } else {
        _students = _fullStudents;
      }
    });
  }

  addStudent(name) {
    _controller.addStudent(name);
  }

  deleteStudent(id) {
    _controller.deleteStudent(id);
  }

  editStudent(id, name) {
    _controller.editStudent(id, name);
  }
}
