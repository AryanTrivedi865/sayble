import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final List<String> images = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/400',
    'https://picsum.photos/300/400',
    'https://picsum.photos/400/500',
    'https://picsum.photos/500/600',
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) => Card(
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(width * 0.02),
            child: Image.network(
              images[index],
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
        staggeredTileBuilder: (int index) =>
        const StaggeredTile.fit(2),
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
      ),
    );
  }
}