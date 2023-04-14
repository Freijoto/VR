import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolapp/src/class_view/class_model.dart';
import 'package:schoolapp/src/register_view/register_model.dart';
import 'package:schoolapp/src/students_view/student_model.dart';

class SchoolRepository {
  SchoolRepository._instantiate();
  static final SchoolRepository instance = SchoolRepository._instantiate();

  final String _baseUrl = '192.168.0.114:1802';

  Future<List<StudentModel>> getStudents(parameters, route) async {
    Uri uri = Uri.http(
      _baseUrl,
      route,
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<StudentModel> students = [];
      var son = json.decode(response.body);
      son.forEach((record) => {students.add(StudentModel.fromMap(record))});

      return students;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<ClassModel>> getClasses(parameters, route) async {
    Uri uri = Uri.http(
      _baseUrl,
      route,
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<ClassModel> classes = [];
      var son = json.decode(response.body);
      son.forEach((record) => {classes.add(ClassModel.fromMap(record))});

      return classes;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<RegisterModel>> getRegister(parameters, route) async {
    Uri uri = Uri.http(
      _baseUrl,
      route,
      //parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<RegisterModel> registers = [];
      var son = json.decode(response.body);
      son.forEach((record) => {registers.add(RegisterModel.fromMap(record))});

      return registers;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  editRecord(parameters, route) async {
    Uri uri = Uri.http(
      _baseUrl,
      route,
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    print(Uri.parse(uri.toString()));
    var response = await http.put(uri, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  addRecord(parameters, route) async {
    Uri uri = Uri.http(
      _baseUrl,
      route,
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    //print(Uri.parse(uri.toString()));
    var response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  deleteRecord(parameters, route) async {
    Uri uri = Uri.http(
      _baseUrl,
      route,
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    print(Uri.parse(uri.toString()));
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
