import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.today,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'SELECIONE UMA DATA',
              style: context.textTheme.titleSmall,
            ),
          )
        ],
      ),
    );
  }
}
