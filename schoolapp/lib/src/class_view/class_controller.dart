import 'package:schoolapp/src/class_view/class_model.dart';
import 'package:schoolapp/src/common/school_repository.dart';

class ClassController {
  static SchoolRepository repository = SchoolRepository.instance;

  Future<List<ClassModel>> getClass() async {
    Map<String, String> parameters = {
      'codigo': '0',
    };
    List<ClassModel> classes =
        await repository.getClasses(parameters, '/curso');
    return classes;
  }

  addClass(description, synopsis) {
    Map<String, String> parameters = {
      'descricao': "'$description'",
      'ementa': "'$synopsis'",
    };
    repository.addRecord(parameters, '/addcurso');
  }

  deleteClass(id) {
    Map<String, String> parameters = {'codigo': id.toString()};
    repository.deleteRecord(parameters, '/delcurso');
    print('Deletando: $id');
  }

  editClass(id, description, synopsis) {
    Map<String, String> parameters = {
      'codigo': id.toString(),
      'descricao': "'$description'",
      'ementa': "'$synopsis'"
    };

    repository.editRecord(parameters, '/updcurso');
    print('Editando: $id com o nome: $description');
  }
}
