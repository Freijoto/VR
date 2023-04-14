import 'dart:ffi';

class StudentModel {
  int cod;
  String name;

  StudentModel({
    this.cod = 0,
    this.name = '',
  });

  factory StudentModel.fromMap(Map<String, dynamic> snippet) {
    return StudentModel(
      cod: snippet['vcodigo'],
      name: snippet['vnome'],
    );
  }
}
