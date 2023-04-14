import 'dart:ffi';

class ClassModel {
  int cod;
  String description;
  String synopsis;

  ClassModel({
    this.cod = 0,
    this.description = '',
    this.synopsis = '',
  });

  factory ClassModel.fromMap(Map<String, dynamic> snippet) {
    return ClassModel(
      cod: snippet['vcodigo'],
      description: snippet['vdescricao'],
      synopsis: snippet['vementa'],
    );
  }
}
