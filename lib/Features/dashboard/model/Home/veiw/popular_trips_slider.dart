import 'package:flutter/material.dart';

class PopularTripsSlider extends StatefulWidget {
  const PopularTripsSlider({super.key});

  @override
  State<PopularTripsSlider> createState() => _PopularTripsSliderState();
}

class _PopularTripsSliderState extends State<PopularTripsSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> trips = [
    {
      "image": "assets/images/unsplash_R5scocnOOdM.png",
      "from": "برلين",
      "to": "دمشق",
      "price": "22.22\$"
    },
    {
      "image": "assets/images/unsplash_R5scocnOOdM.png",
      "from": "لندن",
      "to": "حمص",
      "price": "30.50\$"
    },
    {
      "image": "assets/images/unsplash_R5scocnOOdM.png",
      "from": "روما",
      "to": "حلب",
      "price": "18.00\$"
    },
  ];

  void _nextPage() {
    if (_currentPage < trips.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.40,
          width: screenWidth * 0.80,
          child: PageView.builder(
            controller: _pageController,
            itemCount: trips.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final trip = trips[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          trip["image"]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.1),
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${trip["from"]}  ←  ${trip["to"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.045, // responsive
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              trip["price"]!,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.04,
                                color: Colors.greenAccent,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.08,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "عرض التفاصيل",
                                style: TextStyle(
                                  color: const Color.fromRGBO(2, 195, 94, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.045,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _prevPage,
              icon: const Icon(Icons.arrow_back_ios,
                  size: 26, color: Color.fromRGBO(1, 48, 27, 1)),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: _nextPage,
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 26,
                color: Color.fromRGBO(1, 48, 27, 1),
              ),
            ),
          ],
        )
      ],
    );
  }
}
