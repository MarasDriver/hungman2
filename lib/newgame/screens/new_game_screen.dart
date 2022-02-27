import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hangman2/newgame/data/provider/new_game_provider.dart';
import 'package:hangman2/newgame/data/provider/timer_provider.dart';
import 'package:hangman2/newgame/screens/new_game_body.dart';
import 'package:hangman2/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class NewGame extends StatefulWidget {
  const NewGame({Key? key}) : super(key: key);

  @override
  State<NewGame> createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  Timer? _timer;

  @override
  void initState() {
    // Provider.of<TimerProvider>(context).init();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      context.read<TimerProvider>().time = timer.tick;
    });
    // TODO implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? _currentWord = Provider.of<NewGameProvider>(context).currentWord;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_left_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: MyTextWidget(
          size: 30,
          text: Provider.of<TimerProvider>(context).time.toString() + "s",
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: MyTextWidget(
              size: 30,
              text: (_currentWord! + 1).toString(),
            ),
          ),
        ],
      ),
      body: NewGameBody(),
    );
  }
}
