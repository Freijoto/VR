import 'package:flutter/material.dart';
import 'package:schoolapp/src/class_view/class_view.dart';
import 'package:schoolapp/src/common/utilities/school_assets.dart';
import 'package:schoolapp/src/common/utilities/school_colors.dart';
import 'package:schoolapp/src/common/utilities/school_icons.dart';
import 'package:schoolapp/src/common/utilities/school_numeric_atributes.dart';
import 'package:schoolapp/src/common/utilities/school_strings.dart';
import 'package:schoolapp/src/componnents/custom_button.dart';
import 'package:schoolapp/src/register_view/register_view.dart';
import 'package:schoolapp/src/students_view/student_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  final String title = SchoolStrings.schoolAppTitle;

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
            colors: [SchoolColors.darkBackground, SchoolColors.lightBackground],
          ),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: Padding(
                        padding: SchoolPadding.xLarge,
                        child: Image.asset(SchoolAssets.logo),
                      ),
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    child: FittedBox(
                      child: Center(
                        child: Text(
                          SchoolStrings.schoolAppTitle,
                          style: SchoolStringsStyles.titleStyle,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: SchoolPadding.medium,
                child: Column(
                  children: const [
                    CustomButton(
                        icon: SchoolIcons.schoolStudentsIcon,
                        title: SchoolStrings.studentsTitle,
                        target: StudentView()),
                    CustomButton(
                        icon: SchoolIcons.schoolClassesIcon,
                        title: SchoolStrings.classTitle,
                        target: ClassView()),
                    CustomButton(
                        icon: SchoolIcons.schoolRegistersIcon,
                        title: SchoolStrings.registerTitle,
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
