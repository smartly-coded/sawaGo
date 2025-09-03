import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Features/dashboard/model/BookingPage/veiw/booking_page.dart';
import 'package:sawago/Features/dashboard/model/Trips/controller/trips_cubit.dart';
import 'package:sawago/Features/dashboard/model/Trips/model/trip_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  List<TripModel> filteredTrips = [];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<TripsCubit>();
    filteredTrips = cubit.allTrips; // في البداية كل الرحلات
  }

  void _filterSearch(String query) {
    final cubit = context.read<TripsCubit>();
    setState(() {
      if (query.trim().isEmpty) {
        filteredTrips = cubit.allTrips;
      } else {
        filteredTrips = cubit.allTrips.where((trip) {
          return trip.from.contains(query.trim()) ||
              trip.to.contains(query.trim());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: isTablet ? 60 : 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF02C35E)),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: _filterSearch,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "ابحث باسم المدينة أو الوجهة",
                    suffixIcon: Icon(Icons.search, color: Color(0xFF555555)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: filteredTrips.isEmpty
                  ? const Center(
                      child: Text(
                        "لا توجد رحلات متاحة",
                        style: TextStyle(
                            fontSize: 18, color: Color(0xFF555555)),
                      ),
                    )
                  : ListView.separated(
                      itemCount: filteredTrips.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final trip = filteredTrips[index];
                        return ListTile(
                          title: Text(
                            trip.from,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            "إلى ${trip.to}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          leading: const Icon(Icons.chevron_left,
                              color: Color(0xFF02C35E)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookingPage(trip: trip),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
