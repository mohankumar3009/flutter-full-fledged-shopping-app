import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CardWithDots extends StatefulWidget {
  const CardWithDots({super.key});

  @override
  State<CardWithDots> createState() => _CardWithDotsState();
}

class _CardWithDotsState extends State<CardWithDots> {
  final PageController _controller = PageController();
  //auto swipeing cards......
  int _currentPage = 0;
  final int _numPages = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSwipe();
  }

  void _startAutoSwipe() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> products = [
    {
      "image":
          "https://img.freepik.com/free-vector/elegant-shubh-diwali-sale-banner-with-discount-details-diya-design_1017-39769.jpg",
    },
    {
      "image":
          "https://tse3.mm.bing.net/th/id/OIP.9xIQLcO6fjAX8bK7p6BlbAHaDj?pid=Api&P=0&h=180",
    },
    {
      "image":
          "https://tse1.mm.bing.net/th/id/OIP.hJHIorUANfcspOqL46dMSwHaE7?pid=Api&P=0&h=180",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 247, 247),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  color: Colors.grey[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  elevation: 6,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          child: Image.network(
                            product["image"],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SmoothPageIndicator(
            controller: _controller,
            count: products.length,
            effect: ExpandingDotsEffect(
              paintStyle: PaintingStyle.fill,
              activeDotColor: const Color.fromARGB(255, 94, 163, 220),
              dotColor: Colors.grey.shade300,
              dotHeight: 10,
              dotWidth: 10,
              spacing: 8,
            ),
          ),
        ],
      ),
    );
  }
}
