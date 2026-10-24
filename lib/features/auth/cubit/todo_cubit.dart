import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/features/auth/repositories/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this._todoRepository) : super(TodoInitial());
  final  TodoRepository _todoRepository;
  Future<void> addTodo({
    required String title,
    required String description,
  }) async {
    emit(TodoLoading());
    try {
      await _todoRepository.addTodo(title: title, description: description);
      emit(TodoSuccess());
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }
}
