

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Features/dashboard/model/Home/veiw/popular_trips_slider.dart';
import 'package:sawago/Features/dashboard/model/Search/veiw/search_page.dart';
import 'package:sawago/Features/dashboard/model/Trips/controller/trips_cubit.dart';
import 'package:sawago/Features/dashboard/model/Trips/controller/trips_state.dart';
import 'package:sawago/Features/dashboard/model/Trips/view/custom_search_widget.dart';
import 'package:sawago/Features/dashboard/model/Trips/view/trip_card.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: BlocBuilder<TripsCubit, TripsState>(
          builder: (context, state) {
            final cubit = context.read<TripsCubit>();

            if (state is TripsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TripsLoaded || state is TripsFilterChanged) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;

                  return Column(
                    children: [
                      const SizedBox(height: 50),

                      // filter + search
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => cubit.toggleFilter(),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 16 : 8,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(2, 195, 94, 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/Group (1).png",
                                      width: isTablet ? 30 : 24,
                                      height: isTablet ? 30 : 24,
                                    ),
                                    Text(
                                      "فلتر",
                                      style: TextStyle(
                                        fontSize: isTablet ? 20 : 16,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF02C35E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CustomSearchWidget(
                                isTablet: isTablet,
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SearchPage(),
                                    ),
                                  );

                                  if (result != null) {
                                    print("المستخدم اختار: $result");
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),

                      // filter categories
                      if (cubit.isFilterVisible)
                        SizedBox(
                          height: isTablet ? 60 : 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            children: [
                              CategoryItem(
                                title:
                                    "جميع الرحلات (${cubit.categoryCounts["جميع الرحلات"] ?? 0})",
                                icon: "assets/images/Vector (2).png",
                                isSelected:
                                    cubit.selectedCategory == "جميع الرحلات",
                                onTap: () =>
                                    cubit.selectCategory("جميع الرحلات"),
                                isTablet: isTablet,
                              ),
                              CategoryItem(
                                title:
                                    "الحافلات (${cubit.categoryCounts["حافلة"] ?? 0})",
                                icon: "assets/images/Vector (3).png",
                                isSelected: cubit.selectedCategory == "حافلة",
                                onTap: () => cubit.selectCategory("حافلة"),
                                isTablet: isTablet,
                              ),
                              CategoryItem(
                                title:
                                    "سيارات (${cubit.categoryCounts["سيارة"] ?? 0})",
                                icon: "assets/images/Vector (4).png",
                                isSelected: cubit.selectedCategory == "سيارة",
                                onTap: () => cubit.selectCategory("سيارة"),
                                isTablet: isTablet,
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 8),

                      // header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("اليوم",
                                style: TextStyle(
                                    color: const Color(0xFF555555),
                                    fontSize: isTablet ? 20 : 18,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              '${cubit.filteredTrips.length} رحلة متوفرة ',
                              style: TextStyle(
                                fontSize: isTablet ? 20 : 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF02C35E),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // trips list
                      Expanded(
                        child: cubit.filteredTrips.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: isTablet ? 100 : 50),
                                  const Text(
                                    "لا يوجد رحلات اليوم في هذه المنطقة بعد !",
                                    style: TextStyle(
                                        color: Color(0xFF01301B),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: isTablet ? 100 : 50),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF555555),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text(
                                      "حجز موعد رحلة لاحق",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                itemCount: cubit.filteredTrips.length +
                                    (cubit.selectedCategory == "جميع الرحلات"
                                        ? 1
                                        : 0),
                                itemBuilder: (context, index) {
                                  if (index < cubit.filteredTrips.length) {
                                    return SizedBox(
                                      width: maxWidth * 0.9,
                                      child: DriverTripCard(
                                          trip: cubit.filteredTrips[index]),
                                    );
                                  } else {
                                    // السلايدر يظهر فقط في جميع الرحلات
                                    return const Padding(
                                      padding: EdgeInsets.only(
                                          top: 16.0, bottom: 24),
                                      child: PopularTripsSlider(),
                                    );
                                  }
                                },
                              ),
                      ),
                    ],
                  );
                },
              );
            } else if (state is TripsEmpty) {
              return Center(
                child: Column(
                  children: [
                    const Text(
                      "لا يوجد رحلات اليوم في هذه المنطقة بعد !",
                      style: TextStyle(color: Color(0xFF01301B)),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF555555),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        "حجز موعد رحلة لاحق",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is TripsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isTablet;

  const CategoryItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 16 : 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 190, 237, 213)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(icon,
                width: isTablet ? 28 : 20, height: isTablet ? 28 : 20),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF01301B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
