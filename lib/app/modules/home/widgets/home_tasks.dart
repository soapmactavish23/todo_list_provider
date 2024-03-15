import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/modules/home/widgets/task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'TASK\'S DE HOJE',
            style: context.textStyle,
          ),
          const Column(
            children: [
              Task(),
              Task(),
              Task(),
              Task(),
            ],
          )
        ],
      ),
    );
  }
}
