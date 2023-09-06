import 'package:carousel_slider_demo/normal.videoplayer.dart';
import 'package:carousel_slider_demo/ytplayer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

List<String> mediaUrls = [
  "https://youtube.com/shorts/O4meJOZYPP4?si=s-5otgm-sBKB3F3f",
  "https://youtu.be/W_dF07JvrJo?si=VPXw-sZLoao9sRUm",
  "https://commondatastorage.googleapis.com/codeskulptor-demos/riceracer_assets/img/car_2.png",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://codeskulptor-demos.commondatastorage.googleapis.com/pang/LdTCEUo.png"
];

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            
              height: MediaQuery.of(context).size.width * 0.9,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: buildMediaContent(mediaUrls))),
      // bottomNavigationBar: Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     buildAddLinkButton(),
      //     buildClearListButton(),
      //   ],
      // ),
    );
  }

  Widget buildAddLinkButton() {
    return Container(
      color: Colors.white,
      height: 50,
      margin: EdgeInsetsDirectional.only(bottom: 10, start: 5, end: 5),
      width: MediaQuery.of(context).size.width * 0.45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          elevation: 2,
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(55),
          ),
        ),
        onPressed: () => showAddLinkDialog(),
        child: Text(
          "Add Link",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget buildClearListButton() {
    return Container(
      color: Colors.white,
      height: 50,
      margin: EdgeInsetsDirectional.only(bottom: 10, start: 5, end: 5),
      width: MediaQuery.of(context).size.width * 0.45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          elevation: 2,
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(55),
          ),
        ),
        onPressed: () => clearMediaList(),
        child: Text(
          "Clear List",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  void showAddLinkDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newLink = '';
        return Center(
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 150,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      labelText: 'Enter Link',
                    ),
                    onChanged: (value) {
                      newLink = value;
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      elevation: 2,
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(55),
                      ),
                    ),
                    onPressed: () {
                      if (newLink.isNotEmpty) {
                        mediaUrls.add(newLink);
                        setState(() {});
                      }
                      Navigator.pop(context);
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void clearMediaList() {
    mediaUrls.clear();
    setState(() {});
  }

  Widget buildMediaContent(List<String> mediaUrls) {
    List<Widget> mediaWidgets = [];

    for (String mediaUrl in mediaUrls) {
      if (linkCheck(mediaUrl) == "Image") {
        mediaWidgets.add(Image.network(mediaUrl, fit: BoxFit.contain));
      } else if (linkCheck(mediaUrl) == "Video") {
        mediaWidgets.add(NormalVideoPlayer(videoUrl: mediaUrl));
      } else if (linkCheck(mediaUrl) == "Youtube") {
        mediaWidgets.add(YTPlayer().videoPlayer(mediaUrl));
      }
    }

    return CarouselSlider(
      items: mediaWidgets,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        
      ),
    );
  }

  String linkCheck(String link) {
    if (RegExp(r'^(https?:\/\/)?(www\.)?youtube\.com').hasMatch(link) ||
        RegExp(r'^(https?:\/\/)?(www\.)?youtu\.be').hasMatch(link) ) {
      return "Youtube";
    } else if (RegExp(r'\.mp4$').hasMatch(link)) {
      return "Video";
    } else if (RegExp(r'\.(jpeg|jpg|png)$').hasMatch(link) ||
        RegExp(r'^https:\/\/images\.unsplash\.com\/.*$').hasMatch(link)) {
      return "Image";
    } else {
      return "Text";
    }
  }
}
