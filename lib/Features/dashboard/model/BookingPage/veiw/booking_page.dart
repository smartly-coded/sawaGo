import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Features/dashboard/model/Home/veiw/home_footer.dart';
import 'package:sawago/Features/dashboard/model/Search/veiw/search_page.dart';
import 'package:sawago/Features/dashboard/model/Trips/controller/trips_cubit.dart';
import 'package:sawago/Features/dashboard/model/Trips/controller/trips_state.dart';
import 'package:sawago/Features/dashboard/model/Trips/model/trip_model.dart';
import 'package:sawago/Features/dashboard/model/Trips/view/custom_search_widget.dart';
import 'package:sawago/Features/dashboard/model/Trips/view/trip_card.dart';

class BookingPage extends StatefulWidget {
  final TripModel trip;

  const BookingPage({super.key, required this.trip});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String carType = "عادية";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<TripsCubit, TripsState>(
        builder: (context, state) {
          final cubit = context.read<TripsCubit>();

          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
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
                                        builder: (_) => const SearchPage()),
                                  );

                                  if (result != null) {
                                    const Color.fromARGB(255, 191, 74, 74);
                                    print("المستخدم اختار: $result");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("تاريخ اليوم",
                                style: TextStyle(
                                    color: const Color(0xFF555555),
                                    fontSize: isTablet ? 20 : 16,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                              style: TextStyle(
                                fontSize: isTablet ? 18 : 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF02C35E),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F7EE),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFF02C35E)),
                          ),
                          child: DriverTripCard(trip: widget.trip),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "نوع السيارة",
                              style: TextStyle(
                                fontSize: isTablet ? 20 : 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF555555),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: const Text("عادية"),
                                    value: "عادية",
                                    groupValue: widget
                                        .trip.carType, 
                                    activeColor: const Color(0xFF02C35E),
                                    onChanged: null, 
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: const Text("كلاسيك"),
                                    value: "كلاسيك",
                                    groupValue: widget
                                        .trip.carType,
                                    activeColor: const Color(0xFF02C35E),
                                    onChanged: null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              "عدد الركاب ",
                              style: TextStyle(
                                fontSize: isTablet ? 18 : 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF555555),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${widget.trip.seats}",
                              style: TextStyle(
                                fontSize: isTablet ? 18 : 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF555555),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              "الكراسي المتاحة",
                              style: TextStyle(
                                fontSize: isTablet ? 18 : 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF555555),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${widget.trip.availableSeats}",
                              style: TextStyle(
                                fontSize: isTablet ? 18 : 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF02C35E),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Row(
                          children: [
                            const Text(
                              "السعر ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF02C35E)),
                            ),
                            const Spacer(),
                            Text('${widget.trip.price}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF02C35E))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF01301B),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text(
                              "تأكيد الحجز",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const AppFooter(),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
