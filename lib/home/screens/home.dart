import 'package:flutter/material.dart';
import 'package:hangman2/home/screens/auth/data/providers/auth_state.dart';
import 'package:hangman2/newgame/data/provider/new_game_provider.dart';
import 'package:hangman2/newgame/screens/new_game_screen.dart';
import 'package:hangman2/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const MyTextWidget(
          size: 30.0,
          text: "Będziesz Pan Wisiał",
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image(image: AssetImage("assets/img/a.jpg")),
              Image.asset("assets/img/a.jpg"),
              ElevatedButton(
                  onPressed: () {
                    if (Provider.of<NewGameProvider>(context, listen: false)
                            .timer !=
                        null)
                      Provider.of<NewGameProvider>(context, listen: false)
                          .endTimer();
                    Provider.of<NewGameProvider>(context, listen: false).init();
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
                  onPressed: () {
                    // User Logout
                    Provider.of<AuthState>(context, listen: false).signOut();
                  },
                  child: Text("Logout")),
            ],
          ),
        ),
      ),
    );
  }
}
