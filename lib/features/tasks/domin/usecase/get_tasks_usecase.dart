import 'package:trading_journal/core/resources/data_state.dart';
import 'package:trading_journal/core/usecase/use_case.dart';
import 'package:trading_journal/features/tasks/domin/repository/task_repository.dart';

import '../entity/task.dart';

class GetTasksUsecase extends UseCase<DataState<List<Task>>, NoParams> {
  final TaskRepository _taskRepository;
  GetTasksUsecase(this._taskRepository);

  @override
  Future<DataState<List<Task>>> call(NoParams param) {
    return _taskRepository.getTasks();
  }
}
