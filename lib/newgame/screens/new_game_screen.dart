import 'package:flutter/material.dart';
import 'package:hangman2/newgame/screens/new_game_body.dart';
import 'package:hangman2/widgets/text_widget.dart';

class NewGame extends StatelessWidget {
  const NewGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const MyTextWidget(
          size: 30,
          text: "Timer",
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: MyTextWidget(
              size: 30,
              text: "1",
            ),
          ),
        ],
      ),
      body: NewGameBody(),
    );
  }
}
