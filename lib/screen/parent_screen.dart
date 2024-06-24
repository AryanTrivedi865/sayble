import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sayble/screen/parent_bottom_screen/explore_screen.dart';
import 'package:sayble/screen/parent_bottom_screen/home_screen.dart';
import 'package:sayble/screen/profile_tabs/profile_screen.dart';
import 'package:sayble/screen/profile_tabs/user_profile.dart';
import 'package:sayble/util/bottom_bar.dart';
import 'package:uni_links/uni_links.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  StreamSubscription? _subscription;
  int selectedIndex = 0;

  Future<void> initUniLinks() async {
    _subscription = linkStream.listen(
      (String? link) {
        if (link != null) {
          var uri = Uri.parse(link);
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
    return SafeArea(
      child: Scaffold(
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
                    children: const <Widget>[
                      HomeScreen(),
                      ExploreScreen(),
                      ProfileScreen(),
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
                                icon: const Icon(Icons.home_filled),
                                title: const Text('Home'),
                              ),
                              BottomNavigationItem(
                                icon: const Icon(Icons.explore),
                                title: const Text('Explore'),
                              ),
                              BottomNavigationItem(
                                icon: const Icon(Icons.person),
                                title: const Text('Profile'),
                              ),
                            ],
                            currentIndex: selectedIndex,
                            onTap: (int index) {
                              setState(
                                () {
                                  selectedIndex = index;
                                },
                              );
                            },
                            backgroundColor: Colors.white,
                            unselectedItemColor: Colors.grey,
                            selectedItemColor: Colors.black,
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            if(selectedIndex == 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Reels'),
                                ),
                              );
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Add Post'),
                                ),
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.072),
                          ),
                          child: Icon(
                            selectedIndex == 1
                                ? Icons.slow_motion_video_outlined
                                : Icons.add,
                          ),
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
      ),
    );
  }
}
