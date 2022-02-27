import 'package:flutter/material.dart';
import 'package:hangman2/home/screens/home.dart';
import 'package:provider/provider.dart';

import 'newgame/data/provider/new_game_provider.dart';
import 'newgame/data/provider/timer_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewGameProvider()),
        ChangeNotifierProvider(create: (context) => TimerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Home(),
      ),
    );
  }
}
