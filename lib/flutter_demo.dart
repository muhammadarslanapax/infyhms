import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({Key? key}) : super(key: key);

  @override
  State<FlutterDemo> createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width / 1.2,
              height: 20,
              child: Row(
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(-20),
                      color: Colors.lightBlue,
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.1),

            // CarouselSlider(
            //   options: CarouselOptions(
            //     height: 400.0,
            //     enlargeCenterPage: true,
            //     initialPage: 0,
            //     enableInfiniteScroll: false,
            //   ),
            //   items: [1, 2, 3, 4, 5].map((i) {
            //     return Builder(
            //       builder: (BuildContext context) {
            //         return Container(
            //           width: MediaQuery.of(context).size.width,
            //           margin: const EdgeInsets.symmetric(horizontal: 5.0),
            //           decoration: const BoxDecoration(color: Colors.amber),
            //           child: Text(
            //             'text $i',
            //             style: const TextStyle(fontSize: 16.0),
            //           ),
            //         );
            //       },
            //     );
            //   }).toList(),
            // )
          ],
        ),
      ),
    );
  }
}
