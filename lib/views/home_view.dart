import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:simple_app_showing_carousel_slider_with_dots_indicator/models/carousel_slider_model.dart';
import 'package:simple_app_showing_carousel_slider_with_dots_indicator/views/all_plants_view.dart';
import 'package:simple_app_showing_carousel_slider_with_dots_indicator/views/details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CarouselSliderModel> dummyData = [
    CarouselSliderModel(
      image: "assets/images/1.png",
      title: 'Indoor',
      price: 50,
    ),
    CarouselSliderModel(
      image: "assets/images/2.png",
      title: 'Outdoor',
      price: 60,
    ),
    CarouselSliderModel(
      image: "assets/images/3.png",
      title: 'Indoor',
      price: 70,
    ),
    CarouselSliderModel(
      image: "assets/images/4.png",
      title: 'Outdoor',
      price: 80,
    ),
    CarouselSliderModel(
      image: "assets/images/5.png",
      title: 'Indoor',
      price: 90,
    ),
  ];
  List<IconData> iconsList = [
    Icons.home,
    Icons.account_circle_outlined,
    Icons.favorite,
    Icons.archive_outlined,
  ];
  CarouselController carouselController = CarouselController();
  int currentIndexPosition = 0;
  int bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffc5e2ce),
        title: const Center(
          child: Text(
            "Home",
            style: TextStyle(
                color: Color(0xff114928), fontWeight: FontWeight.w800),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
         // crossAxisAlignment: CrossAxisAlignment.start,
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
              itemCount: dummyData.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailsView(item: dummyData[itemIndex])));
                },
                child: Container(
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
                        Center(child: Image.asset(dummyData[itemIndex].image)),
                        buildPriceTextWidget(dummyData[itemIndex].price),
                        buildArrows(),
                        Positioned(
                          bottom: 4,
                          left: 4,
                          child: Text(dummyData[itemIndex].title),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              options: CarouselOptions(onPageChanged: (index, reason) {
                setState(() {
                  currentIndexPosition = index;
                });
              }),
            ),
            buildDotsIndicator(carouselController),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffc5e2ce),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AllPlantsView(
                        items: dummyData,
                      )));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildAnimatedBottomNavigationBar(),
    );
  }

  AnimatedBottomNavigationBar buildAnimatedBottomNavigationBar() {
    return AnimatedBottomNavigationBar.builder(
      itemCount: iconsList.length,
      tabBuilder: (int index, bool isActive) {
        return Icon(
          iconsList[index],
          size: 24,
          color: isActive ? const Color(0xff114928) : Colors.grey,
        );
      },
      activeIndex: bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() => bottomNavIndex = index ),
      //other params
    );
  }

  Center buildDotsIndicator(CarouselController carouselController) {
    return Center(
      child: DotsIndicator(
        onTap: carouselController.animateToPage,
        dotsCount: dummyData.length,
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

  Positioned buildPriceTextWidget(int price) {
    return Positioned(
      bottom: 4,
      right: 4,
      child: Container(
          height: 20,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
              child: Text(
            '\$${price.toString()}',
            style: const TextStyle(color: Color(0xff7eba3e)),
          ))),
    );
  }

}
