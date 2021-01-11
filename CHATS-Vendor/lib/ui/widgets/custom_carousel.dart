import 'package:CHATS_Vendor/core/constants/colors_contants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderImages extends StatefulWidget {
  final List<String> imageList;
  final List<Widget> scrollText;

  SliderImages({@required this.imageList, this.scrollText});
  @override
  State<StatefulWidget> createState() {
    return _SliderImagesState();
  }
}

int tracker;

class _SliderImagesState extends State<SliderImages> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> imageSliders = widget.imageList
        .map((imageUrl) => Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ))
        .toList();
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        child: Column(
          children: [
            Container(
              height: size.height / 3.5,
              child: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                  height: size.height,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      tracker = index;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.zero,
                height: 100,
                width: size.width,
                child: widget.scrollText[tracker ?? 0]),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.imageList.length, (int j) {
                  return Container(
                    width: 15,
                    height: 4,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: tracker == j
                            ? AppConstants.purple
                            : AppConstants.kCaro,
                        borderRadius: BorderRadius.circular(10)),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
