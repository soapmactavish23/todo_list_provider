import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_task_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';

class HomeFilter extends StatelessWidget {
  const HomeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    bool _getSelected(TaskFilterEnum filter) {
      return context.select<HomeController, TaskFilterEnum>(
              (value) => value.filterSelected) ==
          filter;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.textTheme.titleSmall,
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: 'Hoje',
                taskFilter: TaskFilterEnum.today,
                totalTaskModel: context.select<HomeController, TotalTaskModel?>(
                    (controller) => controller.todayTotalTasks),
                selected: _getSelected(TaskFilterEnum.today),
              ),
              TodoCardFilter(
                label: 'Amanhã',
                taskFilter: TaskFilterEnum.tomorow,
                totalTaskModel: context.select<HomeController, TotalTaskModel?>(
                    (controller) => controller.tomorowTotalTasks),
                selected: _getSelected(TaskFilterEnum.tomorow),
              ),
              TodoCardFilter(
                label: 'Semana',
                taskFilter: TaskFilterEnum.week,
                totalTaskModel: context.select<HomeController, TotalTaskModel?>(
                  (controller) => controller.weekTotalTasks,
                ),
                selected: _getSelected(TaskFilterEnum.week),
              ),
            ],
          ),
        )
      ],
    );
  }
}
