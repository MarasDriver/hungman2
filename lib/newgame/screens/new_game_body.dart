import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hangman2/auth/data/providers/auth_state.dart';
import 'package:hangman2/newgame/data/provider/new_game_provider.dart';
import 'package:hangman2/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class NewGameBody extends StatelessWidget {
  const NewGameBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _alphabet = Provider.of<NewGameProvider>(context).alphabet;
    List listOfWords =
        Provider.of<NewGameProvider>(context).randomWords!.randomWords!;

    int? _currentWord = Provider.of<NewGameProvider>(context).currentWord;
    List _textList = listOfWords[_currentWord!].toLowerCase().split("");
    int _mistakes = Provider.of<NewGameProvider>(context).mistakes!;

    List _passedWords = Provider.of<NewGameProvider>(context).passedWords!;

    return listOfWords.first == '' ||
            Provider.of<NewGameProvider>(context).loading!
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 1 / 3,
                  color: Colors.green,
                  child: Stack(
                    children: [
                      SvgPicture.asset("assets/svg/hangman.svg"),
                      if (_mistakes > 0)
                        SvgPicture.asset("assets/svg/head.svg"),
                      if (_mistakes > 1) SvgPicture.asset("assets/svg/c.svg"),
                      if (_mistakes > 2) SvgPicture.asset("assets/svg/lA.svg"),
                      if (_mistakes > 3) SvgPicture.asset("assets/svg/lL.svg"),
                      if (_mistakes > 4) SvgPicture.asset("assets/svg/rA.svg"),
                      if (_mistakes > 5) SvgPicture.asset("assets/svg/rL.svg"),
                    ],
                  )),
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
                                MyTextWidget(
                                    size: 15,
                                    text: _passedWords.contains(e.toLowerCase())
                                        ? e
                                        : "#$e"),
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
                                      // step 1

                                      onPressed:
                                          _passedWords.contains(e.toLowerCase())
                                              ? null
                                              : () {
                                                  _checkButton(
                                                      letter: e.toLowerCase(),
                                                      textList: _textList,
                                                      context: context);

                                                  //   print(e);
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

  _checkButton({String? letter, List? textList, context}) {
    if (textList!.contains(letter)) {
      Provider.of<NewGameProvider>(context, listen: false)
          .addPassedLetter(letter!);
      // is next level check
      bool _mylocalBool = false;
      List<bool> _wordCheck = [];

      textList.forEach((element) {
        if (Provider.of<NewGameProvider>(context, listen: false)
            .passedWords!
            .contains(element)) {
          _wordCheck.add(true);
        } else {
          _wordCheck.add(false);
        }
      });

      if (_wordCheck.contains(false)) {
        // Nie wszystkie słowa odgadnięte
        _mylocalBool = false;
      } else {
        // Partia skończona, co dalej
        _mylocalBool = true;
      }
      if (Provider.of<NewGameProvider>(context, listen: false).currentWord! <
          Provider.of<NewGameProvider>(context, listen: false)
                  .randomWords!
                  .randomWords!
                  .length -
              1) {
        if (_mylocalBool) {
          Provider.of<NewGameProvider>(context, listen: false).endTimer();

          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            borderSide: BorderSide(color: Colors.green, width: 2),
            // width: 280,
            buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
            headerAnimationLoop: false,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Congrats',
            desc: 'Go to next level?',
            dismissOnBackKeyPress: false,
            btnCancelText: "Restart",
            btnCancelOnPress: () {
              Provider.of<NewGameProvider>(context, listen: false).loading =
                  true;

              Provider.of<NewGameProvider>(context, listen: false).init();
            },
            btnOkOnPress: () {
              Provider.of<NewGameProvider>(context, listen: false).currentWord =
                  Provider.of<NewGameProvider>(context, listen: false)
                          .currentWord! +
                      1;

              Provider.of<NewGameProvider>(context, listen: false).passedWords =
                  [];
              Provider.of<NewGameProvider>(context, listen: false).startTimer();
            },
          ).show();
        } else {}
      } else if (_mylocalBool) {
        Provider.of<NewGameProvider>(context, listen: false).endTimer();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          borderSide:
              BorderSide(color: Color.fromARGB(255, 9, 35, 153), width: 2),
          // width: 280,
          buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Okay! You Win!',
          desc: "Wanna hang more?",
          dismissOnBackKeyPress: false,
          btnCancelText: "Menu",
          btnOkText: "One more game!",
          btnCancelOnPress: () {
            FirebaseFirestore.instance.collection("Leader").add({
              'login': Provider.of<AuthState>(context, listen: false)
                  .auth
                  .currentUser!
                  .email,
              'score': Provider.of<NewGameProvider>(context, listen: false)
                  .currentWord
                  .toString(),
              'time': Provider.of<NewGameProvider>(context, listen: false)
                  .time
                  .toString(),
            }).whenComplete(() => Navigator.of(context).pop());
          },
          btnOkOnPress: () {
            FirebaseFirestore.instance.collection("Leader").add({
              'login': Provider.of<AuthState>(context, listen: false)
                  .auth
                  .currentUser!
                  .email,
              'score': Provider.of<NewGameProvider>(context, listen: false)
                  .currentWord
                  .toString(),
              'time': Provider.of<NewGameProvider>(context, listen: false)
                  .time
                  .toString(),
            }).whenComplete(() => Navigator.of(context).pop());
            Provider.of<NewGameProvider>(context, listen: false).loading = true;
            Provider.of<NewGameProvider>(context, listen: false).init();
          },
        ).show();
      }
    } else {
      Provider.of<NewGameProvider>(context, listen: false).mistakes =
          Provider.of<NewGameProvider>(context, listen: false).mistakes! + 1;
      if (Provider.of<NewGameProvider>(context, listen: false).mistakes! >= 6) {
        Provider.of<NewGameProvider>(context, listen: false).endTimer();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          borderSide: BorderSide(color: Colors.red, width: 2),
          // width: 280,
          buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Hunged',
          desc: 'Wanna hang again?',
          dismissOnBackKeyPress: false,
          btnCancelOnPress: () {
            FirebaseFirestore.instance.collection("Leader").add({
              'login': Provider.of<AuthState>(context, listen: false)
                  .auth
                  .currentUser!
                  .email,
              'score': Provider.of<NewGameProvider>(context, listen: false)
                  .currentWord
                  .toString(),
              'time': Provider.of<NewGameProvider>(context, listen: false)
                  .time
                  .toString(),
            }).whenComplete(() => Navigator.of(context).pop());
          },
          btnOkOnPress: () {
            FirebaseFirestore.instance.collection("Leader").add({
              'login': Provider.of<AuthState>(context, listen: false)
                  .auth
                  .currentUser!
                  .email,
              'score': Provider.of<NewGameProvider>(context, listen: false)
                  .currentWord
                  .toString(),
              'time': Provider.of<NewGameProvider>(context, listen: false)
                  .time
                  .toString(),
            }).whenComplete(() => Navigator.of(context).pop());
            Provider.of<NewGameProvider>(context, listen: false).loading = true;
            Provider.of<NewGameProvider>(context, listen: false).init();
          },
        ).show();
      }
      ;
    }
  }
}
