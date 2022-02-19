import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Będziesz Pan Wisiał",
          style: TextStyle(fontFamily: "Schyler", fontSize: 40.0),
        ),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image(image: AssetImage("assets/img/a.jpg")),
            Image.asset("assets/img/a.jpg"),
            ElevatedButton(onPressed: () {}, child: Text("New Game")),
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
    );
  }
}
