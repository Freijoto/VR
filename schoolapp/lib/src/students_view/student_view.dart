import 'package:flutter/material.dart';
import 'package:schoolapp/src/common/utilities/school_colors.dart';
import 'package:schoolapp/src/common/utilities/school_icons.dart';
import 'package:schoolapp/src/common/utilities/school_numeric_atributes.dart';
import 'package:schoolapp/src/common/utilities/school_strings.dart';
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
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SchoolColors.lightBackground,
        title: const Text(SchoolStrings.studentsTitle),
        actions: [
          Padding(
            padding: SchoolPadding.medium,
            child: GestureDetector(
              child: Container(
                height: 35,
                width: 85,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: SchoolColors.darkBackground),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return Container(
                                color: SchoolColors.lightButtonColor,
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration: const InputDecoration(
                                          labelText:
                                              SchoolStrings.studentNameTitle),
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
                                                child: const Text(
                                                    SchoolStrings.saveRecord)),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text(
                                                    SchoolStrings.cancel)),
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
                    child: const Text(SchoolStrings.newRecord)),
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
              SchoolColors.darkBackground,
              SchoolColors.lightBackground,
            ])),
        child: Column(
          children: [
            Flexible(
                flex: 1,
                child: Padding(
                  padding: SchoolPadding.medium,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: SchoolStrings.studentNameTitle,
                      border: OutlineInputBorder(
                        borderRadius: SchoolBorderRadius.medium,
                      ),
                    ),
                    onChanged: (value) => filterData(value),
                  ),
                )),
            Flexible(
              flex: 10,
              child: Padding(
                padding: SchoolPadding.medium,
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
                                        color: SchoolColors.lightButtonColor,
                                        child: Column(
                                          children: [
                                            TextField(
                                              enabled: _editing,
                                              decoration: const InputDecoration(
                                                  labelText: SchoolStrings
                                                      .studentNameTitle),
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
                                                        child: const Text(
                                                            SchoolStrings
                                                                .edit)),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child:
                                                        ElevatedButton(
                                                            onPressed:
                                                                () => {
                                                                      deleteStudent(
                                                                          _students[index]
                                                                              .cod),
                                                                      Navigator.pop(
                                                                          context)
                                                                    },
                                                            child: const Text(
                                                                SchoolStrings
                                                                    .delete)),
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
        tooltip: SchoolStrings.refresh,
        backgroundColor: SchoolColors.darkBackground,
        child: SchoolIcons.schoolRefreshIcon,
      ),
    );
  }

  loadData() async {
    var tempStudents = await _controller.getStudent();
    setState(() {
      _fullStudents = tempStudents;
      _students = _fullStudents;
    });
  }

  filterData(String text) {
    setState(() {
      _students = _controller.filterStudents(text, _fullStudents);
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
