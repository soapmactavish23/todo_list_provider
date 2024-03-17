import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_page.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service_impl.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(
          bindings: [
            Provider<TasksRepository>(
              create: (context) => TasksRepositoryImpl(
                sqliteConnectionFactory:
                    context.read<SqliteConnectionFactory>(),
              ),
            ),
            Provider<TasksService>(
              create: (context) => TasksServiceImpl(
                tasksRepository: context.read<TasksRepository>(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => TasksCreateController(
                  tasksService: context.read<TasksService>()),
            )
          ],
          routers: {
            '/tasks/create': (context) => TasksCreatePage(
                  controller: context.read<TasksCreateController>(),
                )
          },
        );
}
