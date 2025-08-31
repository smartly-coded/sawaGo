import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Features/dashboard/model/Trips/model/trip_model.dart';
import 'package:sawago/Features/dashboard/model/Trips/controller/trips_state.dart';
import 'package:sawago/Repo/trips_repository.dart';

class TripsCubit extends Cubit<TripsState> {
  final ITripsRepository repo;
  TripsCubit(this.repo) : super(TripsInitial());

  bool isFilterVisible = false;
  String selectedCategory = "جميع الرحلات";
  List<TripModel> allTrips = [];

  Future<void> fetchTrips() async {
    emit(TripsLoading());
    try {
      allTrips = await repo.fetchTrips();
      if (allTrips.isEmpty) {
        emit(TripsEmpty());
      } else {
        emit(TripsLoaded(allTrips));
      }
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }

  void toggleFilter() {
    isFilterVisible = !isFilterVisible;
    emit(TripsFilterChanged(isFilterVisible));
    emit(TripsLoaded(allTrips)); 
  }

  void selectCategory(String category) {
    selectedCategory = category;
    emit(TripsLoaded(allTrips)); 
  }
}
