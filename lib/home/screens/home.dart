import 'package:flutter/material.dart';
import 'package:hangman2/newgame/data/providers/new_game_provider.dart';
import 'package:hangman2/newgame/screens/new_game_screen.dart';
import 'package:hangman2/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewGameProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const MyTextWidget(
            size: 30.0,
            text: "Będziesz Pan Wisiał",
          ),
        ),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image(image: AssetImage("assets/img/a.jpg")),
              Image.asset("assets/img/a.jpg"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewGame()));
                  },
                  child: Text("New Game")),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70.0),
                child: ElevatedButton(
                    onPressed: () {}, child: Text("Wall of the hanged")),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {},
                  child: Text("Logout")),
            ],
          ),
        ),
      ),
    );
  }
}
