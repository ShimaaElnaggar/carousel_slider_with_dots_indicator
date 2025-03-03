import 'package:flutter/material.dart';
import 'package:simple_app_showing_carousel_slider_with_dots_indicator/models/carousel_slider_model.dart';

class AllPlantsView extends StatelessWidget {
  final List<CarouselSliderModel> items;
  const AllPlantsView({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffc5e2ce),
        title: const Center(
          child: Text(
            'All Plants',
            style: TextStyle(
                color: Color(0xff114928), fontWeight: FontWeight.w800),
          ),
        ),
      ),
      body: ListView(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xffecf2f0),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: ListTile(
                  leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xffc5e2ce),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          item.image,
                        ),
                      )),
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      color: Color(0xff114928),
                    ),
                  ),
                  trailing: Text('Price: \$${item.price}',
                      style: const TextStyle(color: Color(0xff7eba3e))),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
