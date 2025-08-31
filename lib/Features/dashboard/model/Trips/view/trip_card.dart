import 'package:flutter/material.dart';
import 'package:sawago/Features/dashboard/model/BookingPage/veiw/booking_page.dart';
import 'package:sawago/Features/dashboard/model/Trips/model/trip_model.dart';

class DriverTripCard extends StatelessWidget {
  final TripModel trip;

  const DriverTripCard({
    super.key,
    required this.trip,
  });

  String _tripDuration() {
    final duration = trip.endTime.difference(trip.startTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0 && minutes > 0) {
      return "$hours س $minutesد";
    } else if (hours > 0) {
      return "$hours س";
    } else {
      return "$minutes د";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                trip.from,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.black54,
                        endIndent: 1,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        _tripDuration(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF02C35E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward, size: 25, color: Colors.black54),
              const SizedBox(width: 6),
              Text(
                trip.to,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                trip.startTimeFormatted,
                style: const TextStyle(
                  color: Color(0xFF02C35E),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 30),
              Text(
                trip.endTimeFormatted,
                style: const TextStyle(
                  color: Color(0xFF02C35E),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                trip.category,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Divider(height: 20, thickness: 2, color: Color(0xFFE0E0E0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFF555555),
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.person_2_outlined, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    trip.driverName,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("التقييم",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 6),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        size: 10,
                        color: index < trip.rating.round()
                            ? Colors.amber
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BookingPage(trip: trip)),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF02C35E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "حجز فوري",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF02C35E),
                    ),
                  ),
                ),
              ),
              Text(
                "${trip.price} ل.س",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
