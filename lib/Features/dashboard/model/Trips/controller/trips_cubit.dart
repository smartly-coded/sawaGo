import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Features/dashboard/model/Trips/model/trip_model.dart';
import 'trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  TripsCubit() : super(TripsInitial());

  bool isFilterVisible = false;
  String selectedCategory = "جميع الرحلات";

  List<TripModel> allTrips = [];

  void fetchTrips() async {
    emit(TripsLoading());

    await Future.delayed(const Duration(seconds: 2));

    final List<TripModel> allTrips = [
  TripModel(
    from: "دمشق",
    to: "حمص",
    departureTime: "12:00 ظهراً",
    arrivalTime: "6:00 مساءً",
    driverName: "أحمد محمد",
    rating: 4.5,
    price: "20000",
  
  ),
  TripModel(
    from: "دمشق",
    to: "حماة",
    departureTime: "3:00 عصراً",
    arrivalTime: "8:00 مساءً",
    driverName: "خالد علي",
    rating: 4.8,
    price: "25000",
  ),
  TripModel(
    from: "حلب",
    to: "دمشق",
    departureTime: "9:00 صباحاً",
    arrivalTime: "2:00 ظهراً",
    driverName: "محمود حسن",
    rating: 4.2,
    price: "30000",
  ),
  TripModel(
    from: "اللاذقية",
    to: "طرطوس",
    departureTime: "10:00 صباحاً",
    arrivalTime: "11:30 صباحاً",
    driverName: "سامي يوسف",
    rating: 4.7,
    price: "15000",
  ),
];


    if (allTrips.isEmpty) {
      emit(TripsEmpty());
    } else {
      emit(TripsLoaded(allTrips));
    }
  }

  void toggleFilter() {
    isFilterVisible = !isFilterVisible;
    selectedCategory = "جميع الرحلات";
    emit(TripsFilterChanged(isFilterVisible));
    emit(TripsLoaded(allTrips));
  }

  void selectCategory(String category) {
    selectedCategory = category;

    if (category == "جميع الرحلات") {
      emit(TripsLoaded(allTrips));
    } else {
      
      emit(TripsLoaded(allTrips)); 
    }
  }
}
