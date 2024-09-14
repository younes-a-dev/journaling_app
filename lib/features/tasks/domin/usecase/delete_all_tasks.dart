import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/tasks/domin/repository/task_repository.dart';

class DeleteAllTasksUsecase extends UseCase<DataState<String>, NoParams> {
  final TaskRepository _taskRepository;
  DeleteAllTasksUsecase(this._taskRepository);

  @override
  Future<DataState<String>> call(NoParams param) {
    return _taskRepository.deleteAllTasks();
  }
}
