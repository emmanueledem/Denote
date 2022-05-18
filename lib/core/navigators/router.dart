import 'package:flutter/material.dart';
import 'package:mobbit/pages/all_notes.dart';
import 'package:mobbit/pages/create_note.dart';
import 'package:mobbit/core/navigators/routes.dart';
import 'package:mobbit/pages/edit_note.dart';
import 'package:mobbit/pages/view_note.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.createNote:
        return _getPageRoute(
            routeName: settings.name, viewToShow: const CreateNote());
      case Routes.editNote:
        return _getPageRoute(viewToShow: const EditNote());
      case Routes.viewNote:
        return _getPageRoute(viewToShow: const ViewNote());
      case Routes.allNotes:
        return _getPageRoute(viewToShow: const AllTask());
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

PageRoute _getPageRoute({String? routeName, required Widget viewToShow}) {
  return MaterialPageRoute<dynamic>(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
