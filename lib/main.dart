import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hangman2/auth/data/providers/auth_state.dart';
import 'package:hangman2/auth/sign_up.dart';
import 'package:hangman2/home/screens/home.dart';
import 'package:hangman2/newgame/data/provider/new_game_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewGameProvider()),
        ChangeNotifierProvider(
          create: (context) => AuthState(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthState>().userChanges,
            initialData: null)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LoginHandler(),
      ),
    );
  }
}

class LoginHandler extends StatelessWidget {
  const LoginHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User?>();
    return _firebaseUser == null ? SignupPage() : Home();
  }
}
