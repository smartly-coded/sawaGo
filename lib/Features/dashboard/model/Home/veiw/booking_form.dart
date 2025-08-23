import 'package:flutter/material.dart';
import 'package:sawago/Core/Theme/app_colors.dart';

class BookingForm extends StatelessWidget {
  const BookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomInputField(
          hint: "من",
          icon: Icons.location_on,
        ),
        SizedBox(height: 12),
        CustomInputField(
          hint: "إلى",
          icon: Icons.flag,
        ),
        SizedBox(height: 12),
        CustomInputField(
          hint: "التاريخ",
          icon: Icons.date_range,
        ),
        SizedBox(height: 12),
        CustomInputField(
          hint: "عدد الركاب",
          icon: Icons.people,
        ),
        SizedBox(height: 20),
        SubmitButton(),
      ],
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String hint;
  final IconData icon;

  const CustomInputField({super.key, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.greyDark),
        hintText: hint,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "طلب",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
