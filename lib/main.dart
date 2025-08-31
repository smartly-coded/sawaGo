import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawago/Core/Routing/app_routes.dart';
import 'package:sawago/Features/Authentication/controller/auth_controller.dart';
import 'package:sawago/Features/dashboard/model/Trips/controller/trips_cubit.dart';
import 'package:sawago/Repo/auth_repository.dart';
import 'package:sawago/Repo/trips_repository.dart';
import 'package:sawago/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'EG'),
      ],
      path: 'assets/languages',
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(AuthRepository()),
          ),
          BlocProvider<TripsCubit>(
            create: (context) => TripsCubit(
              TripsRepository(FirebaseFirestore.instance),
            )..fetchTrips(),
          ),
        ],
        child: DevicePreview(
          enabled: true,
          builder: (context) => const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      initialRoute: AppRoutes.onboarding,
      routes: AppRoutes.getRoutes(),
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      showPerformanceOverlay: false,
    );
  }
}
