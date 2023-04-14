import 'package:flutter/material.dart';
import 'package:schoolapp/src/class_view/class_model.dart';
import 'package:schoolapp/src/common/utilities/school_colors.dart';
import 'package:schoolapp/src/common/utilities/school_icons.dart';
import 'package:schoolapp/src/common/utilities/school_numeric_atributes.dart';
import 'package:schoolapp/src/common/utilities/school_strings.dart';
import 'package:schoolapp/src/componnents/student_item.dart';
import 'package:schoolapp/src/register_view/register_controller.dart';
import 'package:schoolapp/src/register_view/register_model.dart';
import 'package:schoolapp/src/students_view/student_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  List<ClassModel> _fullClasses = [];
  List<ClassModel> _fullClassesregister = [];
  List<RegisterModel> _fullRegisters = [];
  List<StudentModel> _fullStudents = [];
  List<RegisterModel> _registers = [];
  List<StudentModel> _students = [];

  String _dropDownClassValue = '';
  String _dropDownStudentValue = '';

  final RegisterController _controller = RegisterController();
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
        title: const Text(SchoolStrings.registerTitle),
        actions: [
          Padding(
            padding: SchoolPadding.medium,
            child: GestureDetector(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: SchoolColors.darkBackground),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Expanded(
                            child: Container(
                              color: SchoolColors.lightButtonColor,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: DropdownButton<String>(
                                        hint: const Text(SchoolStrings
                                            .newRegisterClassTitle),
                                        value: (_dropDownClassValue.isEmpty
                                            ? null
                                            : _dropDownClassValue),
                                        items: _fullClasses
                                            .map(
                                              (option) => DropdownMenuItem(
                                                value: option.cod.toString(),
                                                child: Text(option.description),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) => {
                                              setState(() => {
                                                    _dropDownClassValue =
                                                        value.toString()
                                                  }),
                                            }),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: DropdownButton<String>(
                                        hint: const Text(SchoolStrings
                                            .newRegisterStudentTitle),
                                        value: (_dropDownStudentValue.isEmpty
                                            ? null
                                            : _dropDownStudentValue),
                                        items: _fullStudents
                                            .map(
                                              (option) => DropdownMenuItem(
                                                value: option.cod.toString(),
                                                child: Text(option.name),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) => {
                                              setState(() => {
                                                    _dropDownStudentValue =
                                                        value.toString()
                                                  }),
                                            }),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Center(
                                            child: ElevatedButton(
                                                onPressed: () => {
                                                      addRegister(
                                                          _dropDownClassValue,
                                                          _dropDownStudentValue),
                                                      _dropDownClassValue = '',
                                                      _dropDownStudentValue =
                                                          '',
                                                      Navigator.pop(context)
                                                    },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        SchoolColors
                                                            .darkBackground),
                                                child: const Text(
                                                    SchoolStrings.saveRecord)),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Center(
                                            child: ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        SchoolColors
                                                            .darkBackground),
                                                child: const Text(
                                                    SchoolStrings.cancel)),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: const Text(SchoolStrings.newRecord),
              ),
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
              SchoolColors.lightBackground
            ])),
        child: Column(
          children: [
            Flexible(
                flex: 1,
                child: Padding(
                  padding: SchoolPadding.medium,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: SchoolStrings.registrationFilterTitle,
                      border: OutlineInputBorder(
                        borderRadius: SchoolBorderRadius.medium,
                      ),
                    ),
                    onChanged: (value) => filterData(value, 'text'),
                  ),
                )),
            Flexible(
              flex: 10,
              child: Padding(
                padding: SchoolPadding.medium,
                child: ListView.builder(
                  itemCount: _fullClassesregister.length,
                  itemBuilder: (context, index) {
                    return StudentItem(
                        id: _fullClassesregister[index].cod,
                        name: _fullClassesregister[index].description,
                        onPress: () => {
                              filterData(
                                  _fullClassesregister[index].cod.toString(),
                                  'class'),
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Column(
                                      children: [
                                        Row(children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  deleteAll(
                                                      _fullClassesregister[
                                                              index]
                                                          .cod);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                    SchoolStrings.deleteAll)),
                                          ),
                                        ]),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: _registers.length,
                                            itemBuilder: (context, index) {
                                              return StudentItem(
                                                  id: _registers[index]
                                                      .codRegister,
                                                  name: _registers[index]
                                                      .descstudent,
                                                  onPress: () => {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return ElevatedButton(
                                                                onPressed: () {
                                                                  deleteRegister(
                                                                      _registers[
                                                                              index]
                                                                          .codRegister);

                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    SchoolStrings
                                                                        .deleteStudent),
                                                              );
                                                            })
                                                      });
                                            },
                                          ),
                                        ),
                                      ],
                                    );
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
    var tempClasses = await _controller.getClass();
    var tempClassesregister = await _controller.getClassRegister();
    var tempRegisters = await _controller.getRegister();
    var tempStudents = await _controller.getStudent();
    setState(() {
      _fullClasses = tempClasses;
      _fullClassesregister = tempClassesregister;
      _fullRegisters = tempRegisters;
      _registers = _fullRegisters;
      _fullStudents = tempStudents;
      _students = _fullStudents;
    });
  }

  filterData(String text, type) {
    setState(() {
      if (text.isNotEmpty) {
        if (type == 'class') {
          _registers = _fullRegisters
              .where((register) => register.codClass.toString() == text)
              .toList();
        } else {
          _registers = _fullRegisters
              .where((register) =>
                  register.descClass.substring(0, text.length).toLowerCase() ==
                  text.toLowerCase())
              .toList();
          if (_registers.isEmpty) {
            _registers = _fullRegisters
                .where((register) =>
                    register.descstudent
                        .substring(0, text.length)
                        .toLowerCase() ==
                    text.toLowerCase())
                .toList();
          }
        }
      } else {
        _registers = _fullRegisters;
      }
    });
  }

  addRegister(selectedClass, selectedStudent) {
    _controller.addRegister(selectedClass, selectedStudent);
  }

  deleteRegister(id) {
    _controller.deleteRegister(id);
  }

  deleteAll(id) {
    _controller.deleteAllRegisters(id);
  }
}
