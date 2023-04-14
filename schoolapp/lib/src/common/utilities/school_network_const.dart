class SchoolNetworkStrings {
  static const String baseUrl = '192.168.0.114:1802';
  static const String baseHeader = 'application/json';

  static const String addStudentRoute = '/addaluno';
  static const String getStudentRoute = '/aluno';
  static const String deleteStudentRoute = '/delaluno';
  static const String editStudentRoute = '/updaluno';

  static const String addClassRoute = '/addcurso';
  static const String getClassRoute = '/curso';
  static const String deleteClassRoute = '/delcurso';
  static const String editClassRoute = '/updcurso';

  static const String addRegisterRoute = '/addmatricula';
  static const String getRegisterRoute = '/matricula';
  static const String getClassRegisterRoute = '/cursomatricula';
  static const String deleteRegisterRoute = '/delmatricula';
  static const String deleteAllRegistersRoute = '/delmatriculascurso';
}
