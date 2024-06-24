import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sayble/screen/profile_tabs/profile_screen.dart';
import 'package:sayble/screen/profile_tabs/user_profile.dart';
import 'package:sayble/util/bottom_bar.dart';
import 'package:uni_links/uni_links.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? _subscription;
  int selectedIndex = 0;

  Future<void> initUniLinks() async {
    _subscription = linkStream.listen(
      (String? link) {
        if (link != null) {
          var uri = Uri.parse(link);
          log("Got link: $uri");
          String? userId = uri.queryParameters['id'];
          if (userId != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(userId: userId),
              ),
            );
          }
        }
      },
      onError: (Object err) {
        log("Error: $err");
      },
    );

    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        var uri = Uri.parse(initialLink);
        log("Initial link: $uri");
        String? userId = uri.queryParameters['id'];
        if (userId != null) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(userId: userId),
                ),
              );
            },
          );
        }
      }
    } on PlatformException {
      log("Failed to get initial link");
    } on FormatException {
      log("Failed to parse initial link");
    }
  }

  @override
  void initState() {
    initUniLinks();
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          return SizedBox(
            height: height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                IndexedStack(
                  index: selectedIndex,
                  children: <Widget>[
                    Container(
                      width: width,
                      height: height,
                      color: Colors.red,
                      child: const Center(
                        child: Text('Home'),
                      ),
                    ),
                    Container(
                      width: width,
                      height: height,
                      color: Colors.green,
                      child: const Center(
                        child: Text('Search'),
                      ),
                    ),
                    Container(
                      width: width,
                      height: height,
                      color: Colors.blue,
                      child: const Center(
                        child: Text('Explore'),
                      ),
                    ),
                    const ProfileScreen(),
                  ],
                ),
                Positioned(
                  bottom: width * 0.02,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: BottomNavigation(
                          items: [
                            BottomNavigationItem(
                              icon: const Icon(Icons.home),
                              title: const Text('Home'),
                            ),
                            BottomNavigationItem(
                              icon: const Icon(Icons.search),
                              title: const Text('Search'),
                            ),
                            BottomNavigationItem(
                              icon: const Icon(Icons.explore),
                              title: const Text('Explore'),
                            ),
                          ],
                          currentIndex: selectedIndex,
                          onTap: (int index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          backgroundColor: Colors.white,
                          unselectedItemColor: Colors.grey,
                          selectedItemColor: Colors.black,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: (){},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.072),
                        ),
                        child: const Icon(Icons.add),
                      ),
                      SizedBox(width: width * 0.02),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
