import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/auth/cubit/todo_cubit.dart';

class AddToDoScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final _formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add To-Do")),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "Title",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please Enter Task Name";
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please Enter Task Desctiption";
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            BlocConsumer<TodoCubit, TodoState>(
          
              listener: (context, state) {
                if(state is TodoSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("To Do Saved"))
                );
                Navigator.pop(context);
                }
                if (state is TodoFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message))
                );
                }
              },
              buildWhen: (previous, current) => current is TodoLoading|| current is TodoFailure|| current is TodoSuccess,
              builder: (context, state) {
                return ElevatedButton(
                  onPressed:state is TodoLoading?null: () {
                    
                    if (_formkey.currentState!.validate()) {
                      context.read<TodoCubit>().addTodo(
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim()
                      );
                    }
                  },
                  child:state is TodoLoading?CircularProgressIndicator():
                   Text("Add To do"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
