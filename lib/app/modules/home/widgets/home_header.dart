import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/todo_list_auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Selector<TodoListAuthProvider, String>(
            selector: (context, authProvider) =>
                authProvider.user?.displayName ?? "Não informado",
            builder: (_, value, __) {
              return Text(
                'E ai, $value!',
                style: context.textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              );
            },
          ),
        );
  }
}
