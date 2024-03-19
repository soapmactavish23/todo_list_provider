// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

class TasksServiceImpl extends TasksService {
  final TasksRepository _tasksRepository;
  TasksServiceImpl({
    required TasksRepository tasksRepository,
  }) : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepository.save(date, description);

  @override
  Future<List<TaskModel>> getToday() async {
    DateTime todayDate = DateTime.now();
    return _tasksRepository.findByPeriod(todayDate, todayDate);
  }

  @override
  Future<List<TaskModel>> getTomorow() async {
    var tomorowDate = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.findByPeriod(tomorowDate, tomorowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      startFilter = startFilter.subtract(
        Duration(
          days: (startFilter.weekday - 1),
        ),
      );
    }

    endFilter = startFilter.add(const Duration(days: 7));
    final tasks = await _tasksRepository.findByPeriod(startFilter, endFilter);
    return WeekTaskModel(
      startDate: startFilter,
      endDate: endFilter,
      tasks: tasks,
    );
  }
}
