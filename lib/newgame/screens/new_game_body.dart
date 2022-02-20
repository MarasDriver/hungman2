import 'package:flutter/material.dart';
import 'package:hangman2/newgame/data/provider/new_game_provider.dart';
import 'package:hangman2/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class NewGameBody extends StatelessWidget {
  const NewGameBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _alphabet = Provider.of<NewGameProvider>(context).alphabet;
    String _example = "Konstyntanopola";
    List _textList = _example.split("");
    print(_textList);
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1 / 3,
          color: Colors.green,
        ),
        Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1 / 6,
            color: Colors.yellow,
            child: Center(
                child: Wrap(
              spacing: 20,
              children: _textList
                  .map((e) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyTextWidget(size: 15, text: e),
                          Container(
                            width: 30,
                            height: 5,
                            color: Colors.black,
                          )
                        ],
                      ))
                  .toList(),
            ))),
        Expanded(
          child: Container(
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                child: Wrap(
                  spacing: 1,
                  runSpacing: 0,
                  children: _alphabet
                      .map((e) => Container(
                            width: 40.0,
                            child: ElevatedButton(
                                onPressed: () {
                                  print(e);
                                },
                                child: Text(e)),
                          ))
                      .toList(),
                ),
              )),
        )
      ],
    );
  }
}
