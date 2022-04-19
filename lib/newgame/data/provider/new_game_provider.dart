import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hangman2/newgame/data/model/random_Words.dart';
import 'package:hangman2/newgame/data/model/random_Words.dart';
import 'package:http/http.dart' as http;

class NewGameProvider extends ChangeNotifier {
  RandomWords? _randomWords;
  int? _currentWord;

  int? get currentWord => _currentWord;

  set currentWord(int? newIndex) {
    _currentWord = newIndex;
    notifyListeners();
  }

  int? _mistakes;
  int? get mistakes => _mistakes;

  set mistakes(int? newMistake) {
    _mistakes = newMistake;
    notifyListeners();
  }

  List<String>? _passedWords = [];

  List<String>? get passedWords => _passedWords;

  set passedWords(List<String>? newList) {
    _passedWords = newList;
    notifyListeners();
  }

  addPassedLetter(String letter) {
    _passedWords!.add(letter);
    notifyListeners();
  }

  bool? _loading;
  bool? get loading => _loading;
  set loading(bool? newLoad) {
    _loading = newLoad;
    notifyListeners();
  }

  bool? _moveToNextLvl;
  bool? get moveToNextLvl => _moveToNextLvl;
  set moveToNextLvl(bool? newLvl) {
    _moveToNextLvl = newLvl;
    notifyListeners();
  }

  init() {
    _randomWords = RandomWords(randomWords: [""]);
    _currentWord = 0;
    _mistakes = 0;
    _passedWords = [];
    _loading = true;
    _moveToNextLvl = false;
    _fetchData();
  }

  RandomWords? get randomWords => _randomWords;
  Future _fetchData() async {
    try {
      http.Response response = await http.get(
          Uri.parse("https://random-word-api.herokuapp.com/word?number=10"));

      _randomWords = RandomWords.fromJson(response.body);
      _loading = false;
      startTimer();
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  NewGameProvider() {
    // _init();
  }
  final List _alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  List get alphabet => _alphabet;
  int _time = 0;
  int get time => _time;
  set time(int newTime) {
    _time = newTime;
    notifyListeners();
  }

  Timer? _timer;
  Timer? get timer => _timer;
  set timer(Timer? newTimer) {
    _timer = newTimer;
    notifyListeners();
  }

  startTimer() {
    time = 0;
    mistakes = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _time = timer.tick;
      notifyListeners();
    });
  }

  endTimer() {
    timer!.cancel();
    timer = null;
  }
}
