import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String? validatePasswordInput(value) {
    if (value != null && value.length < 6) {
      return "Enter min 6 characters";
    } else {
      return null;
    }
  }

  String? validateEmailInput(value) {
    if (EmailValidator.validate(value)) {
      return null;
    } else {
      return "Enter valid Email";
    }
  }

  String? validateConfirmPasswordInput(value, firstPassword) {
    if (value == firstPassword) {
      return null;
    } else {
      print(firstPassword);
      return "Passwords don't match";
    }
  }

  String? validateValue(value) {
    if (purpose == "email") {
      return validateEmailInput(value);
    } else if (purpose == "password") {
      return validatePasswordInput(value);
    } else if (purpose == "confirm") {
      return validateConfirmPasswordInput(value, firstPassword);
    } else {
      return null;
    }
  }

  final TextEditingController controller;
  final ValueChanged<String>? onChange;
  final String purpose;
  final String? firstPassword;
  final String hintText;
  final bool obscureText; // For passwords

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.purpose,
      this.firstPassword,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      controller: controller,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => validateValue(value),
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black)),
    );
  }
}
