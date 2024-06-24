import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayble/api/environment.dart';
import 'package:sayble/api/user.dart';
import 'package:sayble/models/user_model.dart';
import 'package:sayble/screen/profile_tabs/profile_screen.dart';
import 'package:sayble/screen/settings.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.userId});

  final String userId;

  static const platform = MethodChannel('com.aryan.sayble/share');

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<UserModel> _userFuture;

  @override
  void initState() {
    _userFuture = User.getUserById(widget.userId);
    super.initState();
  }

  Future<void> _refresh() async {
    setState(
          () {
        _userFuture = User.getUserById(widget.userId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return FutureBuilder<UserModel>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          log('Error: ${snapshot.error}');
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.048,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _refresh,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No user data'));
        }
        UserModel user = snapshot.data!;

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(CupertinoIcons.back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                user.username!,
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: width * 0.048,
                  fontWeight: FontWeight.w400,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(CupertinoIcons.share),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          ShareProfile(
                              link: "${Environment.shareUrl}/user/?id=${user
                                  .id}"),
                    );
                  },
                ),
              ],
            ),
            body: RefreshIndicator(
                onRefresh: _refresh,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: width * 0.02,
                          horizontal: width * 0.032,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: Row(
                                children: [
                                  InkWell(
                                    borderRadius:
                                    BorderRadius.circular(width * 0.1),
                                    onLongPress: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          opaque: false,
                                          barrierDismissible: true,
                                          pageBuilder:
                                              (BuildContext context, _, __) {
                                            return BackdropFilter(
                                              filter: ImageFilter.blur(
                                                sigmaX: 10,
                                                sigmaY: 10,
                                              ),
                                              child: Center(
                                                child: Hero(
                                                  tag: "profile_image",
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        width * 0.072),
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                      "lib/assets/jpegs/profile.jpg",
                                                      image: user.image ?? "",
                                                      width: width * 0.8,
                                                      height: height * 0.6,
                                                      fit: BoxFit.cover,
                                                      imageErrorBuilder:
                                                          (context, error,
                                                          stack) {
                                                        return Image.asset(
                                                          "lib/assets/jpegs/profile.jpg",
                                                          width: width * 0.8,
                                                          height: width * 0.6,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: "profile_image",
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(width * 0.12),
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                          "lib/assets/jpegs/profile.jpg",
                                          image: user.image ?? "",
                                          width: width * 0.2,
                                          height: width * 0.2,
                                          fit: BoxFit.cover,
                                          imageErrorBuilder:
                                              (context, error, stack) {
                                            return Image.asset(
                                              "lib/assets/jpegs/profile.jpg",
                                              width: width * 0.2,
                                              height: width * 0.2,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.086),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: width * 0.12,
                                                child: Text(
                                                  "24",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.064,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Followers",
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: width * 0.032,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: width * 0.086),
                                          Column(
                                            children: [
                                              Container(
                                                width: width * 0.12,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "24",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.064,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Following",
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: width * 0.032,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: width * 0.086),
                                          Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: width * 0.12,
                                                child: Text(
                                                  "7",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.064,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Posts",
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: width * 0.032,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.018),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${user.firstName!} ${user.lastName!}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.056,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.04),
                                  Text(
                                    "he/him",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: width * 0.032,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.008),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: SizedBox(
                                width: width * 0.8,
                                child: Text(
                                  "To anyone that ever told you you're no good... they're no better. — Hayley Williams",
                                  maxLines: 4,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: width * 0.036,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.012),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const ProfileScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text("Follow"),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const SettingsScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text("Message"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: const TabBar(
                          tabs: [
                            Tab(text: "Posts"),
                            Tab(text: "Reels"),
                            Tab(text: "Tagged"),
                          ],
                        ),
                      ),
                    ),
                    SliverStaggeredGrid(
                      gridDelegate:
                      SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        staggeredTileBuilder: (index) =>
                        const StaggeredTile.fit(1),
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[300],
                            ),
                            child: Image.network(
                              "https://picsum.photos/${50 * index}/${50 *
                                  index}?random=$index",
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        childCount: 30,
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
