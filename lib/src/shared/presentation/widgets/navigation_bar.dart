import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pedidosvz/src/shared/config/app_icons.dart';
import 'package:pedidosvz/src/shared/presentation/providers/providers.dart';

class NavigationBarWidget extends ConsumerStatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  NavigationBarWidgetState createState() => NavigationBarWidgetState();
}

class NavigationBarWidgetState extends ConsumerState<NavigationBarWidget> {
  int _selectedIndex = 0;
  static const sizeIcons = 28.0;

  final List<bool> _selectedTheme = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: changeDestination,
      minWidth: 100,
      extended: true,
      labelType: NavigationRailLabelType.none,
      unselectedIconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      selectedIconTheme:
          IconThemeData(color: Theme.of(context).colorScheme.secondary),
      leading: const Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: EdgeInsets.only(top: 62),
          child: Text(
            "Virtual Zone",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined, size: sizeIcons),
          selectedIcon: Icon(Icons.home_rounded, size: sizeIcons, fill: 1),
          label: Text('Inicio', style: TextStyle(fontSize: 14)),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.list_alt_rounded, size: sizeIcons),
          selectedIcon: Icon(Icons.list_alt, size: sizeIcons, fill: 1),
          label: Text('Pedidos', style: TextStyle(fontSize: 14)),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.question_mark_rounded, size: sizeIcons),
          selectedIcon:
              Icon(Icons.question_mark_rounded, size: sizeIcons, fill: 1),
          label: Text('Acerca de', style: TextStyle(fontSize: 14)),
        ),
      ],
      trailing: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (index) {
                ref
                    .read(isDarkModeProvider.notifier)
                    .update((state) => index == 1);
                for (int i = 0; i < _selectedTheme.length; i++) {
                  _selectedTheme[i] = i == index;
                }
              },
              isSelected: _selectedTheme,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              selectedColor: Theme.of(context).colorScheme.onSecondaryContainer,
              fillColor: Theme.of(context).colorScheme.secondaryContainer,
              color: Theme.of(context).colorScheme.secondary,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Row(
                    children: [
                      Icon(Icons.sunny),
                      Text("Dia"),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Row(
                    children: [
                      Icon(Icons.nightlight_rounded),
                      Text("Noche"),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  changeDestination(int index) {
    setState(() {
      _selectedIndex = index;
    });
    onTap(index);
  }

  void onTap(int value) {
    switch (value) {
      case 0:
        return context.go('/');
      case 1:
        return context.go('/orders');
      case 2:
        return context.go('/about');
      default:
        return context.go('/');
    }
  }
}
