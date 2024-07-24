import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class HomeViewe extends StatefulWidget {
  const HomeViewe({super.key});

  @override
  State<HomeViewe> createState() => _HomeVieweState();
}

class _HomeVieweState extends State<HomeViewe> {
  List<String> images = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
  ];
  CarouselController carouselController = CarouselController();
  int currentIndexPosition = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffc5e2ce),
        title: const Center(
            child: Text(
          "Home",
          style:
              TextStyle(color: Color(0xff114928), fontWeight: FontWeight.w800),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              " Let's find your ",
              style: TextStyle(
                color: Color(0xff114928),
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              " plants!",
              style: TextStyle(
                color: Color(0xff114928),
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
            CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: images.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                margin: const EdgeInsets.all(15),
                height: 85,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: const Color(0xffc5e2ce),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
                    children: [
                      Center(child: Image.asset(images[itemIndex])),
                      buildPriceTextWidget(),
                      buildArrows(),
                    ],
                  ),
                ),
              ),
              options: CarouselOptions(onPageChanged: (index, reason) {
                setState(() {
                  currentIndexPosition = index;
                });
              }),
            ),
            buildDotsIndicator(),
          ],
        ),
      ),
    );
  }

  Center buildDotsIndicator() {
    return Center(
      child: DotsIndicator(
        dotsCount: images.length,
        position: currentIndexPosition,
        decorator: DotsDecorator(
          color: Colors.grey,
          activeColor: const Color(0xff114928),
          activeSize: const Size(18.0, 9.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }

  Row buildArrows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Center(
              child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff114928),
          )),
          onPressed: () {
            carouselController.previousPage();
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xff114928),
          ),
          onPressed: () {
            carouselController.nextPage();
          },
        ),
      ],
    );
  }

  Positioned buildPriceTextWidget() {
    return Positioned(
      bottom: 4,
      left: 4,
      child: Container(
          height: 20,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Center(
              child: Text(
            "50\$",
            style: TextStyle(color: Color(0xff7eba3e)),
          ))),
    );
  }
}
