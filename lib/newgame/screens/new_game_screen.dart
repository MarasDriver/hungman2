import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hangman2/newgame/data/provider/new_game_provider.dart';
import 'package:hangman2/newgame/screens/new_game_body.dart';
import 'package:hangman2/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class NewGame extends StatelessWidget {
  const NewGame({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int? _currentWord = Provider.of<NewGameProvider>(context).currentWord;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_left_sharp),
          onPressed:
              Provider.of<NewGameProvider>(context, listen: false).timer == null
                  ? null
                  : () {
                      if (Provider.of<NewGameProvider>(context, listen: false)
                              .timer !=
                          null)
                        Provider.of<NewGameProvider>(context, listen: false)
                            .endTimer();

                      Navigator.pop(context);
                    },
        ),
        centerTitle: true,
        title: MyTextWidget(
          size: 30,
          text: Provider.of<NewGameProvider>(context).time.toString() + "s",
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
