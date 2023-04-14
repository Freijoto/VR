import 'package:flutter/material.dart';
import 'package:schoolapp/src/class_view/class_controller.dart';
import 'package:schoolapp/src/class_view/class_model.dart';
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
    _controller.getClass();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 71, 166, 213),
        title: Text("Cursos"),
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
                                    onChanged: (value) =>
                                        {_description = value},
                                  ),
                                  TextField(
                                    maxLines: null,
                                    decoration:
                                        InputDecoration(labelText: 'Ementa'),
                                    onChanged: (value) => {_synopsis = value},
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: ElevatedButton(
                                              onPressed: () => {
                                                    addClass(_description,
                                                        _synopsis),
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.95,
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            TextField(
                                              enabled: _editing,
                                              decoration: InputDecoration(
                                                  labelText: 'Descrição'),
                                              controller:
                                                  (TextEditingController(
                                                      text: _classes[index]
                                                          .description)),
                                              onChanged: (value) =>
                                                  {_description = value},
                                            ),
                                            TextField(
                                              maxLines: null,
                                              enabled: _editing,
                                              decoration: InputDecoration(
                                                  labelText: 'Ementa'),
                                              controller:
                                                  (TextEditingController(
                                                      text: _classes[index]
                                                          .synopsis)),
                                              onChanged: (value) =>
                                                  {_synopsis = value},
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
                                                                  editClass(
                                                                      _classes[
                                                                              index]
                                                                          .cod,
                                                                      _description,
                                                                      _synopsis),
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
                                                              deleteClass(
                                                                  _classes[
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
    var temp = await _controller.getClass();
    setState(() {
      _fullClasses = temp;
      _classes = _fullClasses;
    });
  }

  filterData(String text) {
    setState(() {
      if (text.length > 0) {
        _classes = _fullClasses
            .where((student) =>
                student.description.substring(0, text.length).toLowerCase() ==
                text.toLowerCase())
            .toList();
      } else {
        _classes = _fullClasses;
      }
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
