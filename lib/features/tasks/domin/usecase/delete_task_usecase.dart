import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/tasks/domin/entity/task.dart';
import 'package:trading_journal/features/tasks/domin/repository/task_repository.dart';

class DeleteTaskUsecase extends UseCase<DataState<Task>, Task> {
  final TaskRepository _taskRepository;
  DeleteTaskUsecase(this._taskRepository);

  @override
  Future<DataState<Task>> call(Task param) {
    return _taskRepository.deleteTask(param);
  }
}
