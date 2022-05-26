import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:denote/services/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:denote/core/navigators/router.dart';
import 'package:provider/provider.dart';
import 'screens/all_notes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => NotesProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Denote',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: Routers.generateRoute,
          home: AnimatedSplashScreen(
              duration: 3000,
              splash: const Text(
                'DENOTE',
                style: TextStyle(
                  fontFamily: 'VarelaRound',
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              nextScreen: const AllTask(),
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Colors.blue)),
    );
  }
}
