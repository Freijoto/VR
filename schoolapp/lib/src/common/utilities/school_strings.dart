import 'package:flutter/material.dart';
import 'package:schoolapp/src/common/utilities/school_colors.dart';

class SchoolStrings {
  static const String schoolAppTitle = 'School';

  static const String classTitle = 'Cursos';
  static const String registerTitle = 'Matriculas';
  static const String studentsTitle = 'Alunos';

  static const String newRecord = 'Novo';

  static const String studentNameTitle = 'Nome';
  static const String classDescriptionTitle = 'Curso';
  static const String classSynopsisTitle = 'Ementa';

  static const String newRegisterClassTitle = 'Selecione o Curso';
  static const String newRegisterStudentTitle = 'Selecione o Aluno';
  static const String registrationFilterTitle = 'Aluno / Curso';

  static const String saveRecord = 'Salvar';
  static const String cancel = 'Cancelar';
  static const String edit = 'Editar';
  static const String delete = 'Deletar';
  static const String refresh = 'Atualizar';
  static const String deleteStudent = 'Remover Aluno';
  static const String deleteAll = 'Remover todos os Alunos';
}

class SchoolStringsStyles {
  static const TextStyle titleStyle = TextStyle(
      fontFamily: 'Lobster', fontSize: 85, color: SchoolColors.lightTextColor);
  static const TextStyle largeButtonTitle =
      TextStyle(color: Color.fromARGB(255, 125, 125, 125), fontSize: 48.0);
  static const TextStyle mediumButtonTitle =
      TextStyle(color: Color.fromARGB(255, 125, 125, 125), fontSize: 32.0);
}
