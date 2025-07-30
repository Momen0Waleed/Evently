import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.title,
    required this.prefixIcon,
    required this.isPassword,
    required this.isName,
    required this.isLogin,
    this.isConfirmPassword = false,
    this.originalPasswordController,

    required this.controller,

  });
  final String title;
  final Icon prefixIcon;
  final bool isPassword;
  final bool isName;
  final bool isLogin;
  final bool isConfirmPassword;
  final TextEditingController? originalPasswordController;

  final TextEditingController controller;


  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool obscurePassword = true;
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        // controller: !widget.isPassword ? _emailController : _passwordController,
        controller: widget.controller,

        validator: (value) {
          if (widget.isConfirmPassword) {
            return validateConfirmPassword(value);
          } else if (!widget.isName) {
            if (!widget.isPassword) {
              return validateEmail(value);
            } else if (widget.isLogin) {
              return null;
            } else {
              return validatePassword(value);
            }
          } else {
            return null;
          }
        },
        obscureText: !widget.isName
            ? (widget.isPassword ? obscurePassword : false)
            : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: EventlyColors.white,
          hintText: widget.title,
          hintStyle: theme.bodyMedium,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(width: 1, color: EventlyColors.gray),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(width: 1, color: EventlyColors.gray),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: EventlyColors.redError, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: EventlyColors.redError, width: 1),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email (ex: example@mail.com)';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must contain uppercase, lowercase,\nnumber, and special character.';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != widget.originalPasswordController?.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
