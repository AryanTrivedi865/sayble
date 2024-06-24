import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sayble/api/environment.dart';
import 'package:sayble/screen/parent_screen.dart';
import 'package:sayble/screen/profile_tabs/profile_screen.dart';
import 'package:sayble/screen/profile_tabs/user_profile.dart';
import 'package:sayble/screen/welcome_screen.dart';
import 'package:sayble/themes/theme.dart';
import 'package:sayble/themes/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xff141313),
      systemNavigationBarColor: Color(0xff141313),
    ),
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String userToken = prefs.getString('apiToken') ?? '';
  Environment.userToken = userToken;

  runApp(const Sayble());
}

class Sayble extends StatefulWidget {
  const Sayble({super.key});

  @override
  State<Sayble> createState() => _SaybleState();
}

class _SaybleState extends State<Sayble> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Fredoka", "ABeeZee");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Sayble',
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.dark,
      home: Environment.userToken.isEmpty
          ? const WelcomeScreen()
          : const ParentScreen(),
    );
  }
}
