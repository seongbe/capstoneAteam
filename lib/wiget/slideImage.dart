import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarouselSlider extends StatefulWidget {
  final List<String> imgPaths;

  const ImageCarouselSlider({Key? key, required this.imgPaths}) : super(key: key);

  @override
  _ImageCarouselSliderState createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ImageCarouselSlider> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 240,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
          items: widget.imgPaths.map((path) {
            return imageSlider(path);
          }).toList(),
        ),
        indicator(),
      ],
    );
  }

  Widget imageSlider(String path) {
    return Container(
      width: double.infinity,
      height: 240,
      // color: Colors.white,
      child: path.startsWith('http')
          ? Image.network(path, fit: BoxFit.contain)
          : Image.asset(path, fit: BoxFit.contain),
    );
  }

  Widget indicator() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      alignment: Alignment.bottomCenter,
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.imgPaths.length,
        effect: JumpingDotEffect(
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: Colors.black,
          dotColor: Colors.grey.withOpacity(0.6),
        ),
      ),
    );
  }
}
