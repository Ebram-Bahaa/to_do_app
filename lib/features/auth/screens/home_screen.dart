import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/auth/cubit/todo_cubit.dart';
import 'package:to_do_app/features/auth/repositories/todo_repository.dart';
import 'package:to_do_app/features/auth/screens/add_to_do_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My To Do List")),
      body: Center(child: Text("to add click on the button")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => TodoCubit(TodoRepository()),
                child: AddToDoScreen(),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
