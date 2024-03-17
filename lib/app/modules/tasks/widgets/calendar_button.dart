// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_controller.dart';

class CalendarButton extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/y');

  CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(const Duration(days: 10 * 365));

        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: lastDate,
        );

        context.read<TasksCreateController>().selectedDate = selectedDate;
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.today,
                color: Colors.grey,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0),
            //   child: Text(
            //     'SELECIONE UMA DATA',
            //     style: context.textTheme.titleSmall,
            //   ),
            // ),
            Selector<TasksCreateController, DateTime?>(
              selector: (context, controller) => controller.selectedDate,
              builder: (context, selectedDate, child) {
                if (selectedDate != null) {
                  return Text(
                    dateFormat.format(selectedDate),
                    style: context.textTheme.titleSmall,
                  );
                } else {
                  return Text(
                    'SELECIONE UMA DATA',
                    style: context.textTheme.titleSmall,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
