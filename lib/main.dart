import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sayble/api/environment.dart';
import 'package:sayble/screen/profile_screen.dart';
import 'package:sayble/screen/welcome_screen.dart';
import 'package:sayble/themes/theme.dart';
import 'package:sayble/themes/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
    (_) {
      runApp(const Sayble());
    },
  );
}

class Sayble extends StatelessWidget {
  const Sayble({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Fredoka", "ABeeZee");
    MaterialTheme theme = MaterialTheme(textTheme);
    getUserToken();
    return MaterialApp(
      title: 'Sayble',
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.dark,
      home: Environment.userToken==''
          ? const WelcomeScreen()
          : const ProfileScreen(),
    );
  }

  getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Environment.userToken = prefs.getString('apiToken') ?? '';
  }
}
