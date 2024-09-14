import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/tasks/domin/repository/task_repository.dart';

import '../entity/task.dart';

class AddTaskUsecase extends UseCase<DataState<Task>, Task> {
  final TaskRepository _taskRepository;
  AddTaskUsecase(this._taskRepository);

  @override
  Future<DataState<Task>> call(Task param) {
    return _taskRepository.addTask(param);
  }
}
