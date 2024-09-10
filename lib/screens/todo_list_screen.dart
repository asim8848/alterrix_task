import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../services/api_service.dart';
import '../widgets/todo_card.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  List<Todo> filteredTodos = [];
  TextEditingController searchController = TextEditingController();
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    try {
      List<Todo> fetchedTodos = await apiService.fetchTodos();
      setState(() {
        todos = fetchedTodos;
        filteredTodos = [];
      });
    } catch (e) {
      print(e);
    }
  }

  void _filterTodos() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredTodos = todos
          .where((todo) => todo.title.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> _showSearchDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Search Todos',
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: const Text('Enter text to search todos.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child:
                  const Text('Search', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).hintColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _filterTodos();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: isSmallScreen ? 16 : 24),
            ElevatedButton(
              onPressed: _showSearchDialog,
              child: const Text(
                'Search Todos',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: isSmallScreen ? 16 : 24),
            Expanded(
              child: filteredTodos.isEmpty
                  ? const Center(
                      child: Text('No todos to display. Search to find todos.'))
                  : ListView.builder(
                      itemCount: filteredTodos.length,
                      itemBuilder: (context, index) {
                        return TodoCard(todo: filteredTodos[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
