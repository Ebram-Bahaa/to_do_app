import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/features/auth/repositories/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this._todoRepository) : super(TodoInitial());
  final TodoRepository _todoRepository;
  final _firestore = FirebaseFirestore.instance;
  final _firebaseauth = FirebaseAuth.instance;
  Future<void> addTodo({
    required String title,
    required String description,
  }) async {
    emit(TodoLoading());
    try {
      Future<void> addTodo({
        required String title,
        required String description,
      }) async {
        final user = _firebaseauth.currentUser;
        if (user == null) {
          throw Exception("You Must Be signed To Add To Do");
        }
        final _doc = await _firestore.collection('todos').doc();
        _doc.set({
          "userId": _doc.id,
          "title": title,
          "description": description,
          "CreatedAt": FieldValue.serverTimestamp(),
        });
      }
      // await _todoRepository.addTodo(title: title, description: description);
      // emit(TodoSuccess());
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> editToDo({
    required String title,
    required String description,
    required String id,
  }) async {
    final _doc = await _firestore.collection('todos').doc(id);
    _doc.update({
      "title": title,
      "description": description,
      "CreatedAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteToDo({required String id}) async {
    final _doc = await _firestore.collection('todos').doc(id);
    _doc.delete();
  }
}
