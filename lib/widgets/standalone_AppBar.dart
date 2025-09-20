import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/theme_cubit.dart';

class StandaloneAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? titleWidget;

  const StandaloneAppBar({super.key, this.titleWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      title: titleWidget,
      actions: [
        IconButton(
          icon: BlocBuilder<ThemeCubit, int>(
            builder: (context, state) {
              return Icon(state == 0 ? Icons.dark_mode : Icons.light_mode);
            },
          ),
          onPressed: () {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          thickness: 1,
          height: 1,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
