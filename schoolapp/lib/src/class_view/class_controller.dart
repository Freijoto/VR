import 'package:schoolapp/src/class_view/class_model.dart';
import 'package:schoolapp/src/common/school_repository.dart';
import 'package:schoolapp/src/common/utilities/school_network_const.dart';

class ClassController {
  static SchoolRepository repository = SchoolRepository.instance;

  Future<List<ClassModel>> getClass() async {
    Map<String, String> parameters = {
      'codigo': '0',
    };
    List<ClassModel> classes = await repository.getClasses(
        parameters, SchoolNetworkStrings.getClassRoute);
    return classes;
  }

  addClass(description, synopsis) {
    Map<String, String> parameters = {
      'descricao': "'$description'",
      'ementa': "'$synopsis'",
    };
    repository.addRecord(parameters, SchoolNetworkStrings.addClassRoute);
  }

  deleteClass(id) {
    Map<String, String> parameters = {'codigo': id.toString()};
    repository.deleteRecord(parameters, SchoolNetworkStrings.deleteClassRoute);
  }

  editClass(id, description, synopsis) {
    Map<String, String> parameters = {
      'codigo': id.toString(),
      'descricao': "'$description'",
      'ementa': "'$synopsis'"
    };
    repository.editRecord(parameters, SchoolNetworkStrings.editClassRoute);
  }

  filterClasses(text, fullClasses) {
    var classes = [];
    if (text.isNotEmpty) {
      classes = fullClasses
          .where((class_) =>
              class_.description.substring(0, text.length).toLowerCase() ==
              text.toLowerCase())
          .toList();
    } else {
      classes = fullClasses;
    }
    return classes;
  }
}
