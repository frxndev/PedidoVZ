import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pedidosvz/src/shared/config/app_icons.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int _selectedIndex = 0;
  static const sizeIcons = 28.0;
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: changeDestination,
      minWidth: 100,
      extended: true,
      labelType: NavigationRailLabelType.none,
      unselectedIconTheme: IconThemeData(color: Colors.grey[600]),
      selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SvgPicture.asset(
          AppIcons.logo,
          height: 40,
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
