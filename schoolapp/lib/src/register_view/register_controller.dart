import 'package:schoolapp/src/class_view/class_model.dart';
import 'package:schoolapp/src/common/school_repository.dart';
import 'package:schoolapp/src/common/utilities/school_network_const.dart';
import 'package:schoolapp/src/register_view/register_model.dart';
import 'package:schoolapp/src/students_view/student_model.dart';

class RegisterController {
  static SchoolRepository repository = SchoolRepository.instance;

  Future<List<ClassModel>> getClassRegister() async {
    Map<String, String> parameters = {
      'codigo': '0',
    };
    List<ClassModel> classes = await repository.getClasses(
        parameters, SchoolNetworkStrings.getClassRegisterRoute);
    return classes;
  }

  Future<List<ClassModel>> getClass() async {
    Map<String, String> parameters = {
      'codigo': '0',
    };
    List<ClassModel> classes = await repository.getClasses(
        parameters, SchoolNetworkStrings.getClassRoute);
    return classes;
  }

  Future<List<RegisterModel>> getRegister() async {
    Map<String, String> parameters = {};
    List<RegisterModel> classes = await repository.getRegister(
        parameters, SchoolNetworkStrings.getRegisterRoute);
    return classes;
  }

  Future<List<StudentModel>> getStudent() async {
    Map<String, String> parameters = {
      'codigo': '0',
    };

    List<StudentModel> students = await repository.getStudents(
        parameters, SchoolNetworkStrings.getStudentRoute);
    return students;
  }

  addRegister(selectedClass, selectedStudent) {
    Map<String, String> parameters = {
      'codcurso': "$selectedClass",
      'codaluno': "$selectedStudent",
    };
    repository.addRecord(parameters, SchoolNetworkStrings.addRegisterRoute);
  }

  deleteRegister(id) {
    Map<String, String> parameters = {'codigo': id.toString()};
    repository.deleteRecord(
        parameters, SchoolNetworkStrings.deleteRegisterRoute);
  }

  deleteAllRegisters(id) {
    Map<String, String> parameters = {'codigo': id.toString()};
    repository.deleteRecord(
        parameters, SchoolNetworkStrings.deleteAllRegistersRoute);
  }
}
