import 'package:flutter/material.dart';
import 'package:schoolapp/src/class_view/class_view.dart';
import 'package:schoolapp/src/componnents/custom_button.dart';
import 'package:schoolapp/src/register_view/register_view.dart';
import 'package:schoolapp/src/students_view/student_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                children: [
                  Flexible(
                      flex: 2,
                      child: Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Image.asset("assets/images/Logo.png"),
                        )),
                      )),
                  Flexible(
                      flex: 1,
                      child: Center(
                          child: Container(
                              child: Text(
                        "School App",
                        style: TextStyle(
                            fontFamily: 'Lobster',
                            fontSize: 85,
                            color: Color.fromARGB(255, 245, 245, 245)),
                      ))))
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomButton(
                        icon: Icon(
                          Icons.account_circle_sharp,
                          color: Color.fromARGB(255, 71, 166, 213),
                        ),
                        title: "Alunos",
                        target: StudentView()),
                    CustomButton(
                        icon: Icon(
                          Icons.book,
                          color: Color.fromARGB(255, 71, 166, 213),
                        ),
                        title: "Cursos",
                        target: ClassView()),
                    CustomButton(
                        icon: Icon(
                          Icons.assignment_add,
                          color: Color.fromARGB(255, 71, 166, 213),
                        ),
                        title: "Matriculas",
                        target: RegisterView()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
