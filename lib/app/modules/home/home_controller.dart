import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/total_task_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  var filterSelected = TaskFilterEnum.today;
  TotalTaskModel? todayTotalTasks;
  TotalTaskModel? tomorowTotalTasks;
  TotalTaskModel? weekTotalTasks;

  HomeController({required TasksService tasksService})
      : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait({
      _tasksService.getToday(),
      _tasksService.getTomorow(),
      _tasksService.getWeek(),
    });

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTasks = TotalTaskModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );
    tomorowTotalTasks = TotalTaskModel(
      totalTasks: tomorowTasks.length,
      totalTasksFinish: tomorowTasks.where((task) => task.finished).length,
    );
    weekTotalTasks = TotalTaskModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length,
    );

    notifyListeners();
  }
}
