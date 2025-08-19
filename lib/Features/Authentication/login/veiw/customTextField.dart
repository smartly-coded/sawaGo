import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.errorText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  double _responsiveSize(double size, BuildContext context) {
    return MediaQuery.of(context).size.shortestSide * (size / 400);
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: _responsiveSize(8, context),
            right: _responsiveSize(12, context),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: const Color(0xFF01301B),
              fontSize: isSmallScreen
                  ? _responsiveSize(14, context)
                  : _responsiveSize(16, context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          obscuringCharacter: '*',
          keyboardType: widget.keyboardType,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: _responsiveSize(12, context),
              horizontal: _responsiveSize(16, context),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_responsiveSize(12, context)),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_responsiveSize(12, context)),
              borderSide: const BorderSide(color: Color(0xFFDFDFDF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_responsiveSize(12, context)),
              borderSide: const BorderSide(color: Color(0xFF01301B)),
            ),
            filled: false,
            fillColor: const Color(0xFFDFDFDF),
            errorText: widget.errorText,
            errorStyle: TextStyle(
              fontSize: _responsiveSize(12, context),
              color: Colors.red,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_responsiveSize(12, context)),
              borderSide: const BorderSide(color: Colors.red),
            ),
            prefixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF01301B),
                      size: _responsiveSize(24, context),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
          style: TextStyle(
            fontSize: isSmallScreen
                ? _responsiveSize(14, context)
                : _responsiveSize(16, context),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
