import 'package:schoolapp/src/common/school_repository.dart';
import 'package:schoolapp/src/common/utilities/school_network_const.dart';
import 'package:schoolapp/src/students_view/student_model.dart';

class StudentController {
  static SchoolRepository repository = SchoolRepository.instance;

  Future<List<StudentModel>> getStudent() async {
    Map<String, String> parameters = {
      'codigo': '0',
    };

    List<StudentModel> students = await repository.getStudents(
        parameters, SchoolNetworkStrings.getStudentRoute);
    return students;
  }

  filterStudents(text, fullStudents) {
    var students = [];
    if (text.isNotEmpty) {
      students = fullStudents
          .where((student) =>
              student.name.substring(0, text.length).toLowerCase() ==
              text.toLowerCase())
          .toList();
    } else {
      students = fullStudents;
    }
    return students;
  }

  addStudent(name) {
    Map<String, String> parameters = {
      'nome': "'$name'",
    };

    repository.addRecord(parameters, SchoolNetworkStrings.addStudentRoute);
  }

  deleteStudent(id) {
    Map<String, String> parameters = {'codigo': id.toString()};
    repository.deleteRecord(
        parameters, SchoolNetworkStrings.deleteStudentRoute);
  }

  editStudent(id, name) {
    Map<String, String> parameters = {
      'codigo': id.toString(),
      'nome': "'$name'",
    };

    repository.editRecord(parameters, SchoolNetworkStrings.editStudentRoute);
  }
}
