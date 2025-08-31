import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationAutocompleteField extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;

  const LocationAutocompleteField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
  });

  @override
  State<LocationAutocompleteField> createState() =>
      _LocationAutocompleteFieldState();
}

class _LocationAutocompleteFieldState extends State<LocationAutocompleteField> {
  List<String> suggestions = [];

  Future<List<String>> fetchSuggestions(String query) async {
    if (query.isEmpty) return [];

    final url =
        "https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5";

    final response = await http.get(Uri.parse(url), headers: {
      "User-Agent": "FlutterApp",
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<String>.from(data.map((item) => item["display_name"]));
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: Colors.grey[600]),
            labelText: widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          onChanged: (value) async {
            final results = await fetchSuggestions(value);
            setState(() {
              suggestions = results;
            });
          },
          validator: (value) =>
              value == null || value.isEmpty ? "أدخل ${widget.label}" : null,
        ),
        ...suggestions.map(
          (s) => ListTile(
            title: Text(s),
            onTap: () {
              setState(() {
                widget.controller.text = s;
                suggestions.clear();
              });
            },
          ),
        ),
      ],
    );
  }
}
