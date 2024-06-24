import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * .086),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * .02, vertical: height * .01),
          child: SearchBar(
            backgroundColor: const WidgetStatePropertyAll(
              Color(0xff141313),
            ),
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: width * .03),
            ),
            hintText: 'Search',
            side: const WidgetStatePropertyAll(
              BorderSide(color: Color(0xff484545), width: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
