import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/todo_model.dart';

class ApiService {
  Future<List<Todo>> fetchTodos() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Todo> todos =
          body.map((dynamic item) => Todo.fromJson(item)).toList();
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
