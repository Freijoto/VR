import 'package:schoolapp/src/common/school_repository.dart';
import 'package:schoolapp/src/register_view/register_model.dart';

class RegisterController {
  static SchoolRepository repository = SchoolRepository.instance;

  Future<List<RegisterModel>> getRegister() async {
    Map<String, String> parameters = {};
    List<RegisterModel> classes =
        await repository.getRegister(parameters, '/matricula');
    return classes;
  }

  addRegister(description, synopsis) {
    Map<String, String> parameters = {
      'descricao': "'$description'",
      'ementa': "'$synopsis'",
    };
    repository.addRecord(parameters, '/addcurso');
  }

  deleteRegister(id) {
    Map<String, String> parameters = {'codigo': id.toString()};
    repository.deleteRecord(parameters, '/delcurso');
    print('Deletando: $id');
  }
}
