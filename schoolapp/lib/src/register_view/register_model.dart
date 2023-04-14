class RegisterModel {
  int codRegister;
  int codClass;
  int codStudent;
  String descClass;
  String descstudent;

  RegisterModel({
    this.codRegister = 0,
    this.codClass = 0,
    this.codStudent = 0,
    this.descClass = '',
    this.descstudent = '',
  });

  factory RegisterModel.fromMap(Map<String, dynamic> snippet) {
    return RegisterModel(
      codRegister: snippet['codmatricula'],
      codClass: snippet['codcurso'],
      codStudent: snippet['codaluno'],
      descClass: snippet['curso'],
      descstudent: snippet['aluno'],
    );
  }
}
