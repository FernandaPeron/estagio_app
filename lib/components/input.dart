import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  InputField({
    this.hint,
    this.obscureText = false,
    this.icon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: TextStyle(
        color: Color(0xFFC4C4C4),
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        errorBorder: _buildOutlineInputBorder(),
        focusedBorder: _buildOutlineInputBorder(),
        enabledBorder: _buildOutlineInputBorder(),
        focusedErrorBorder: _buildOutlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(25, 5, 0, 0),
        filled: true,
        fillColor: Color(0xFF5A5A5A),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }
}
