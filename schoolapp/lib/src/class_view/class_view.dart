import 'package:flutter/material.dart';
import 'package:schoolapp/src/class_view/class_controller.dart';
import 'package:schoolapp/src/class_view/class_model.dart';
import 'package:schoolapp/src/common/utilities/school_colors.dart';
import 'package:schoolapp/src/common/utilities/school_icons.dart';
import 'package:schoolapp/src/common/utilities/school_numeric_atributes.dart';
import 'package:schoolapp/src/common/utilities/school_strings.dart';
import 'package:schoolapp/src/componnents/student_item.dart';

class ClassView extends StatefulWidget {
  const ClassView({Key? key}) : super(key: key);

  @override
  _ClassViewState createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  List<ClassModel> _fullClasses = [];
  List<ClassModel> _classes = [];
  String _description = '';
  String _synopsis = '';
  bool _editing = false;

  final ClassController _controller = ClassController();
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
        title: const Text(SchoolStrings.classTitle),
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
                        return StatefulBuilder(builder: (context, setState) {
                          return Container(
                            color: SchoolColors.lightButtonColor,
                            child: Column(
                              children: [
                                Padding(
                                  padding: SchoolPadding.medium,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        labelText: SchoolStrings
                                            .classDescriptionTitle),
                                    onChanged: (value) =>
                                        {_description = value},
                                  ),
                                ),
                                Padding(
                                  padding: SchoolPadding.medium,
                                  child: TextField(
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                        labelText:
                                            SchoolStrings.classSynopsisTitle),
                                    onChanged: (value) => {_synopsis = value},
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Center(
                                          child: ElevatedButton(
                                              onPressed: () => {
                                                    addClass(_description,
                                                        _synopsis),
                                                    Navigator.pop(context)
                                                  },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: SchoolColors
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
                                                  backgroundColor: SchoolColors
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
                          );
                        });
                      });
                },
                child: const Text(SchoolStrings.newRecord),
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
                      labelText: SchoolStrings.classDescriptionTitle,
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
                  itemCount: _classes.length,
                  itemBuilder: (context, index) {
                    return StudentItem(
                        id: _classes[index].cod,
                        name: _classes[index].description,
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
                                            Padding(
                                              padding: SchoolPadding.medium,
                                              child: TextField(
                                                enabled: _editing,
                                                decoration: const InputDecoration(
                                                    labelText: SchoolStrings
                                                        .classDescriptionTitle),
                                                controller:
                                                    (TextEditingController(
                                                        text: _classes[index]
                                                            .description)),
                                                onChanged: (value) =>
                                                    {_description = value},
                                              ),
                                            ),
                                            Padding(
                                              padding: SchoolPadding.medium,
                                              child: TextField(
                                                maxLines: null,
                                                enabled: _editing,
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: SchoolStrings
                                                            .classSynopsisTitle),
                                                controller:
                                                    (TextEditingController(
                                                        text: _classes[index]
                                                            .synopsis)),
                                                onChanged: (value) =>
                                                    {_synopsis = value},
                                              ),
                                            ),
                                            Center(
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Center(
                                                      child: ElevatedButton(
                                                          onPressed: () => {
                                                                if (_editing)
                                                                  {
                                                                    _editing =
                                                                        false,
                                                                    editClass(
                                                                        _classes[index]
                                                                            .cod,
                                                                        _description,
                                                                        _synopsis),
                                                                    Navigator.pop(
                                                                        context)
                                                                  }
                                                                else
                                                                  {
                                                                    setState(
                                                                        () => {
                                                                              _editing = true
                                                                            })
                                                                  }
                                                              },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      SchoolColors
                                                                          .darkBackground),
                                                          child: const Text(
                                                              SchoolStrings
                                                                  .edit)),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Center(
                                                      child: ElevatedButton(
                                                          onPressed:
                                                              () => {
                                                                    deleteClass(
                                                                        _classes[index]
                                                                            .cod),
                                                                    Navigator.pop(
                                                                        context)
                                                                  },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      SchoolColors
                                                                          .darkBackground),
                                                          child: const Text(
                                                              SchoolStrings
                                                                  .delete)),
                                                    ),
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
    var temp = await _controller.getClass();
    setState(() {
      _fullClasses = temp;
      _classes = _fullClasses;
    });
  }

  filterData(String text) {
    setState(() {
      _classes = _controller.filterClasses(text, _fullClasses);
    });
  }

  addClass(description, synopsis) {
    _controller.addClass(description, synopsis);
  }

  deleteClass(id) {
    _controller.deleteClass(id);
  }

  editClass(id, description, synopsis) {
    _controller.editClass(id, description, synopsis);
  }
}
