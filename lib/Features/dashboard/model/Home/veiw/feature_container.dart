import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sawago/Core/Theme/app_colors.dart';
import 'package:sawago/Features/dashboard/model/Home/model/featureContainers_Model.dart';

class FeatureContainer extends StatelessWidget {
  final FeatureModel feature;

  const FeatureContainer({
    super.key,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    final unitSize = isSmallScreen ? screenWidth / 40 : screenWidth / 50;
    final paddingUnit = unitSize * 1.0;
    final marginUnit = unitSize * 1.5;
    final fontSizeUnit = unitSize * 1.2;

    return Container(
      width: isSmallScreen ? double.infinity : screenWidth * 0.45,
      padding: EdgeInsets.all(paddingUnit * 2),
      margin: EdgeInsets.all(marginUnit),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 226, 233, 246),
        borderRadius: BorderRadius.circular(unitSize * 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: unitSize * 1.2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(paddingUnit * 1.5),
            decoration: BoxDecoration(
              color: AppColors.primaryGradient.colors.first.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              feature.icon,
              width: unitSize * 3.5,
              height: unitSize * 3.5,
              color: AppColors.primaryGradient.colors.first,
            ),
          ),
          SizedBox(height: unitSize * 1.6),
          Text(
            feature.title,
            style: TextStyle(
              fontSize: fontSizeUnit * 1.5,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: unitSize * 0.8),
          Text(
            feature.description,
            style: TextStyle(
              fontSize: fontSizeUnit * 1.5,
              color: const Color(0xFF555555),
              height: 1.4,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
