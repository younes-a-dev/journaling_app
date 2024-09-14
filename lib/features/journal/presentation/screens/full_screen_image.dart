import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  static const routeName = '/Full screen image';

  const FullScreenImage({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    final image = routeArgs['image'];
    final title = routeArgs['title'];
    return Scaffold(
      appBar: AppBar(
        title:  Text(title,style: const TextStyle(color: Color(0xffbdbdbd),fontSize: 24,fontWeight: FontWeight.bold),),
        iconTheme: const IconThemeData(color: Color(0xffbdbdbd)),
        backgroundColor: const  Color(0xff000000),
      ),
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: PhotoView(
            imageProvider:
                MemoryImage(image), // Image provider for the memory image
            backgroundDecoration: const BoxDecoration(
                color: Colors.black), // Optional: Set the background color
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2.0,
          ),
        ),
      ),
    );
  }
}
