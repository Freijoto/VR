import 'package:schoolapp/src/common/school_repository.dart';
import 'package:schoolapp/src/students_view/student_model.dart';

class StudentController {
  static SchoolRepository repository = SchoolRepository.instance;

  Future<List<StudentModel>> getStudent() async {
    Map<String, String> parameters = {
      'codigo': '0',
    };

    List<StudentModel> students =
        await repository.getStudents(parameters, '/aluno');
    return students;
  }

  addStudent(name) {
    Map<String, String> parameters = {
      'nome': "'${name}'",
    };

    repository.addRecord(parameters, '/addaluno');
    print('Adicionando: ${name}');
  }

  deleteStudent(id) {
    Map<String, String> parameters = {'codigo': id.toString()};
    repository.deleteRecord(parameters, '/delaluno');
    print('Deletando: ${id}');
  }

  editStudent(id, name) {
    Map<String, String> parameters = {
      'codigo': id.toString(),
      'nome': "'${name}'",
    };

    repository.editRecord(parameters, '/updaluno');
    print('Editando: ${id} com o nome: ${name}');
  }
}
