import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sawago/Core/Theme/app_colors.dart';
import 'package:sawago/Features/dashboard/model/Home/controller/location_autocomplete.dart';
import 'package:sawago/Features/dashboard/model/Trips/controller/trips_cubit.dart';
import 'package:sawago/Features/dashboard/model/Trips/view/TripsPage.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController passengersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LocationAutocompleteField(
            label: "من",
            icon: Icons.location_on,
            controller: fromController,
          ),
          const SizedBox(height: 12),
          LocationAutocompleteField(
            label: "إلى",
            icon: Icons.flag,
            controller: toController,
          ),
          const SizedBox(height: 12),
          CustomInputField(
            controller: dateController,
            hint: "التاريخ",
            icon: Icons.date_range,
            readOnly: true,
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                initialDate: DateTime.now(),
              );
              
              if (pickedDate != null) {
                dateController.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
              }
            },
            validator: (value) =>
                value == null || value.isEmpty ? "اختر تاريخ الرحلة" : null,
          ),
          const SizedBox(height: 12),
          CustomInputField(
            controller: passengersController,
            hint: "عدد الركاب",
            icon: Icons.people,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "أدخل عدد الركاب";
              }
              final number = int.tryParse(value);
              if (number == null || number <= 0) {
                return "أدخل رقم صحيح أكبر من 0";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SubmitButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final from = fromController.text.trim();
                final to = toController.text.trim();
                final date = dateController.text.trim();
                final passengers = int.parse(passengersController.text.trim());

                context.read<TripsCubit>().searchTrips(
                      from: from,
                      to: to,
                      date: date,
                      passengers: passengers,
                    );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TripsPage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomInputField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
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
  final VoidCallback onPressed;

  const SubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
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
