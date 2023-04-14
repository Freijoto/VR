import 'package:flutter/material.dart';
import 'package:schoolapp/src/componnents/student_item.dart';
import 'package:schoolapp/src/register_view/register_controller.dart';
import 'package:schoolapp/src/register_view/register_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  List<RegisterModel> _fullClasses = [];
  List<RegisterModel> _classes = [];
  String _description = '';
  String _synopsis = '';
  bool _editing = false;

  final RegisterController _controller = RegisterController();
  @override
  void initState() {
    super.initState();
    _controller.getRegister();
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
                      onChanged: (value) => filterData(value, 'text'),
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
                        id: _classes[index].codClass,
                        name: _classes[index].descClass,
                        onPress: () => {
                              filterData(
                                  _classes[index].codClass.toString(), 'class'),
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Column(
                                      children: [
                                        Row(children: [
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Text(
                                                  'Remover todos os alunos')),
                                        ]),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: _classes.length,
                                            itemBuilder: (context, index) {
                                              return StudentItem(
                                                  id: _classes[index].codClass,
                                                  name: _classes[index]
                                                      .descstudent,
                                                  onPress: () => {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return ElevatedButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                      'Remover Aluno'));
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
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  loadData() async {
    var temp = await _controller.getRegister();
    setState(() {
      _fullClasses = temp;
      _classes = _fullClasses;
    });
  }

  filterData(String text, type) {
    setState(() {
      if (text.length > 0) {
        if (type == 'class') {
          _classes = _fullClasses
              .where((student) => student.codClass.toString() == text)
              .toList();
        } else {
          _classes = _fullClasses
              .where((student) =>
                  student.descClass.substring(0, text.length).toLowerCase() ==
                  text.toLowerCase())
              .toList();
          if (_classes.length == 0) {
            _classes = _fullClasses
                .where((student) =>
                    student.descstudent
                        .substring(0, text.length)
                        .toLowerCase() ==
                    text.toLowerCase())
                .toList();
          }
        }
      } else {
        _classes = _fullClasses;
      }
    });
  }

  addClass(description, synopsis) {
    _controller.addRegister(description, synopsis);
  }

  deleteClass(id) {
    _controller.deleteRegister(id);
  }
}
