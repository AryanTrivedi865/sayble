import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(CupertinoIcons.back),
          title: Text(
            "aryan_.__",
            style: GoogleFonts.fredoka(
              color: Colors.white,
              fontSize: width * 0.048,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.pen),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: width * 0.02, horizontal: width * 0.064),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: width * 0.1,
                      backgroundImage:
                      const AssetImage("lib/assets/jpegs/profile.jpg"),
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
                                    "0",
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
                                    color: Colors.white.withOpacity(0.8),
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
                                    "0",
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
                                    color: Colors.white.withOpacity(0.8),
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
                                    "254",
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
                                    color: Colors.white.withOpacity(0.8),
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
                SizedBox(height: height * 0.024),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "John Doe",
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
                SizedBox(height: width * 0.01),
                SizedBox(
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
                SizedBox(height: height * 0.024),
                const TabBar(
                  tabs: [
                    Tab(text: "Posts"),
                    Tab(text: "Reels"),
                    Tab(text: "Tagged"),
                  ],

                ),
                SizedBox(
                  height: height * 0.56,
                  child: const TabBarView(
                    children: [
                      Center(child: Text("Posts Content")),
                      Center(child: Text("Reels Content")),
                      Center(child: Text("Tagged Content")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
