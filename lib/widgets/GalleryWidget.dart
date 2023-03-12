import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryWidget extends StatefulWidget {
  List<String>? urlImages;
  String urlimage;
  PageController? pageController;
  final int index;
  GalleryWidget({
    super.key,
    this.urlImages,
    required this.urlimage,
    this.index = 0,
  }) : pageController = PageController(initialPage: index);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late int index = widget.index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            PhotoViewGallery.builder(
                pageController: widget.pageController,
                itemCount: 1,
                builder: (BuildContext context, index) {
                  //final urlImage = widget.urlImages[index];
                  return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(widget.urlimage),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained * 4);
                },
                //onPageChanged: ((index) => setState(() => this.index = index))
              ),
            // Container(
            //     padding: EdgeInsets.all(16),
            //     child: Text(
            //       '${index + 1} /${widget.urlImages.length}',
            //       style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            //     )),
            Positioned(
              left: 10,
              top: 50,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }
}
