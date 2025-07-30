import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.title,
    required this.prefixIcon,
    required this.isPassword,
  });
  final String title;
  final Icon prefixIcon;
  final bool isPassword;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    // var dynamic = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: !widget.isPassword ? _emailController : _passwordController,
        validator: !widget.isPassword ? validateEmail : null,
        obscureText: widget.isPassword ? obscurePassword : false,
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
              obscurePassword
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          )
              : null,
        )

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
}
