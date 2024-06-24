import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sayble/api/environment.dart';
import 'package:sayble/api/user.dart';
import 'package:sayble/models/user_model.dart';
import 'package:sayble/screen/profile_tabs/posts_screen.dart';
import 'package:sayble/screen/settings.dart';
import 'package:sayble/util/page_route.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const platform = MethodChannel('com.aryan.sayble/share');

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserModel> _userFuture;

  @override
  void initState() {
    _userFuture = User.getCurrentUser();
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      _userFuture = User.getCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder<UserModel>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
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
                icon: Icon(CupertinoIcons.share, size: width*0.06,),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ShareProfile(
                        link: "${Environment.shareUrl}/user/?id=${user.id}"),
                  );
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
                  icon: const Icon(CupertinoIcons.gear),
                  onPressed: () {
                    Navigator.push(
                      context,
                      SwipePageRoute(
                          builder: (context) => const SettingsScreen(),
                          routeAnimation: RouteAnimation.horizontal,
                          currentChild: widget),
                    );
                  },
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: width * 0.02,
                    horizontal: width * 0.032,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Row(
                          children: [
                            Stack(
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
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholder:
                                                        "lib/assets/jpegs/profile.jpg",
                                                    image: user.image ?? "",
                                                    width: width * 0.8,
                                                    height: height * 0.6,
                                                    fit: BoxFit.cover,
                                                    imageErrorBuilder: (context,
                                                        error, stack) {
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
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.3),
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          final double sheetHeight =
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.26;
                                          final double itemHeight =
                                              sheetHeight * 0.24;
                                          return SizedBox(
                                            height: sheetHeight,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: EdgeInsets.only(
                                                    bottom: height * 0.01,
                                                    left: width * 0.06,
                                                    right: width * 0.08,
                                                    top: height * 0.02,
                                                  ),
                                                  child: Text(
                                                    'Select new profile picture',
                                                    style: TextStyle(
                                                      fontSize: width * 0.064,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    final XFile? image =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                    if (image != null) {
                                                      User.uploadProfileImage(
                                                              image.path)
                                                          .then(
                                                        (value) {
                                                          if (context.mounted) {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    'Profile picture updated'),
                                                              ),
                                                            );
                                                            _refresh();
                                                          }
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    height: itemHeight,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.06),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                            Icons.camera),
                                                        SizedBox(
                                                            width:
                                                                width * 0.04),
                                                        const Text(
                                                            'Select from camera'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    final XFile? image =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    if (image != null) {
                                                      User.uploadProfileImage(
                                                              image.path)
                                                          .then(
                                                        (value) {
                                                          if (context.mounted) {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    'Profile picture updated'),
                                                              ),
                                                            );
                                                            _refresh();
                                                          }
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    height: itemHeight,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.06),
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.photo),
                                                        SizedBox(
                                                            width:
                                                                width * 0.04),
                                                        const Text(
                                                            'Select from gallery'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: itemHeight,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.06),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                            Icons.cancel),
                                                        SizedBox(
                                                            width:
                                                                width * 0.04),
                                                        const Text(
                                                            'Delete existing profile picture'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(width * 0.01),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.black12.withOpacity(0.72),
                                        size: width * 0.042,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: width * 0.086),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            color:
                                                Colors.white.withOpacity(0.8),
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
                                            color:
                                                Colors.white.withOpacity(0.8),
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
                                            color:
                                                Colors.white.withOpacity(0.8),
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
                      SizedBox(height: height * 0.016),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
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
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
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
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: const TabBar(
                          tabs: [
                            Tab(text: "Posts"),
                            Tab(text: "Reels"),
                            Tab(text: "Tagged"),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.006),
                      SizedBox(
                        height: height * 0.6,
                        child: const TabBarView(
                          children: [
                            PostsScreen(),
                            Center(
                              child: Text("Reels Content"),
                            ),
                            Center(
                              child: Text("Tagged Content"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ShareProfile extends StatelessWidget {
  final String link;

  const ShareProfile({super.key, required this.link});

  static Future<void> shareText(String text, BuildContext context) async {
    try {
      await ProfileScreen.platform.invokeMethod('shareText', {'text': text});
    } on PlatformException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to share: ${e.message}"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.all(width * 0.04),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Share Profile',
            style: TextStyle(
              fontSize: width * 0.064,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: width * 0.04),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.04),
            ),
            child: QrImageView(
              data: link,
              version: QrVersions.auto,
              size: width * 0.6,
            ),
          ),
          SizedBox(height: width * 0.04),
          SizedBox(
            width: width * 0.6,
            height: width * 0.1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                shareText('Check out this profile on Sayble: $link', context);
              },
              child: const Text(
                'Share Link',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
