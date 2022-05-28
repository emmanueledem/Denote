import 'package:denote/model/notes.dart';
import 'package:denote/screens/all_notes.dart';
import 'package:denote/screens/edit_note.dart';
import 'package:denote/screens/view_note.dart';
import 'package:flutter/material.dart';
import 'package:denote/core/navigators/routes.dart';

import '../../screens/create_note.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.createNote:
        return _getPageRoute(
            routeName: settings.name, viewToShow: const CreateNote());
      case Routes.editNote:
        return _getPageRoute(viewToShow:  EditNote(
          notes: settings.arguments as Notes,
        ));
      case Routes.viewNote:
        return _getPageRoute(viewToShow:  ViewNote(
          notes :settings.arguments as Notes,
        ));
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
