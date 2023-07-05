import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HotelGallery extends StatefulWidget {
  const HotelGallery({Key? key, this.images}) : super(key: key);
  final images;
  @override
  State<HotelGallery> createState() => _HotelGalleryState();
}

List<String> listOfUrls = [];

class _HotelGalleryState extends State<HotelGallery> {
  bool btnVisible = true;

  int selectedImageIndex = -1;

  @override
  void initState() {
    setState(() {
      listOfUrls = widget.images;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton:
         Padding(
              padding: const EdgeInsets.only(top: 5),
              child: InkWell(
                onTap: () => Get.back(),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_back,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
                //Icon(Icons.arrow_back,size: 30,color: Colors.black,),
              ),
            ),
      body: Scaffold(
        body: Center(
          child:
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Adjust the number of columns as per your preference
              // mainAxisSpacing: 8.0,
              // crossAxisSpacing: 8.0,
            ),
            itemCount: listOfUrls.length,
            itemBuilder: (BuildContext context, int index) {

              final img = listOfUrls[index];
              var imageProvider = Image.network(listOfUrls[index]).image;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    print(img);
                    setState(() {
                      selectedImageIndex = index;
                    });
                    showImageViewer(
                        context,
                        imageProvider,
                        doubleTapZoomable: true,
                        swipeDismissible: true,
                        backgroundColor: Colors.black26,
                        onViewerDismissed: () {
                      print("dismissed");
                    });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => PhotoView(
                    //       imageProvider: NetworkImage(listOfUrls[selectedImageIndex]),
                    //     ),
                    //   ),
                    // );
                  },
                  child: GridTile(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        listOfUrls[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },

                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
