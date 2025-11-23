import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../utils/validators.dart';

/// Custom Text Field Widget
///
/// LEARN: This is a reusable text input widget with built-in validation.
/// It provides consistent styling and error handling across the app.
///
/// Features:
/// - Automatic validation
/// - Error messages
/// - Icons (prefix and suffix)
/// - Password visibility toggle
/// - Custom styling

class CustomTextField extends StatefulWidget {
  /// Label text (shown above field)
  final String? label;

  /// Hint text (shown inside field when empty)
  final String? hint;

  /// Controller for the text field
  ///
  /// LEARN: TextEditingController manages the text field's value.
  /// You create it and pass it to the field.
  final TextEditingController? controller;

  /// Validation function
  ///
  /// LEARN: This function validates the input.
  /// Returns null if valid, error message if invalid.
  final String? Function(String?)? validator;

  /// Field type (text, email, password, phone, etc.)
  final TextFieldType type;

  /// Prefix icon (shown on the left)
  final IconData? prefixIcon;

  /// Suffix icon (shown on the right)
  final IconData? suffixIcon;

  /// Show password visibility toggle (for password fields)
  final bool showPasswordToggle;

  /// Enable/disable the field
  final bool enabled;

  /// Maximum number of lines (null = single line)
  final int? maxLines;

  /// Maximum number of characters
  final int? maxLength;

  /// Custom text input action
  final TextInputAction? textInputAction;

  /// Callback when field value changes
  final void Function(String)? onChanged;

  /// Callback when field is submitted
  final void Function(String)? onSubmitted;

  /// Focus node for controlling focus
  final FocusNode? focusNode;

  /// Autofocus (focus when screen opens)
  final bool autofocus;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.type = TextFieldType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.showPasswordToggle = false,
    this.enabled = true,
    this.maxLines,
    this.maxLength,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  /// Track password visibility
  bool _obscureText = true;

  /// Get validator based on field type
  ///
  /// LEARN: This method returns the appropriate validator
  /// based on the field type (email, password, etc.).
  String? Function(String?)? get _validator {
    // Use custom validator if provided
    if (widget.validator != null) {
      return widget.validator;
    }

    // Use default validator based on type
    switch (widget.type) {
      case TextFieldType.email:
        return Validators.email;
      case TextFieldType.password:
        return Validators.password;
      case TextFieldType.phone:
        return Validators.phone;
      case TextFieldType.text:
      default:
        return null;
    }
  }

  /// Get keyboard type based on field type
  ///
  /// LEARN: Different field types need different keyboards.
  /// Email shows @ key, phone shows numbers, etc.
  TextInputType get _keyboardType {
    switch (widget.type) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.text:
      case TextFieldType.password:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppConstants.spacingS),
        ],

        // Text Field
        TextFormField(
          controller: widget.controller,
          validator: _validator,
          keyboardType: _keyboardType,
          obscureText: widget.type == TextFieldType.password && _obscureText,
          enabled: widget.enabled,
          maxLines:
              widget.maxLines ??
              (widget.type == TextFieldType.password ? 1 : null),
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon)
                : null,
            suffixIcon: _buildSuffixIcon(),
            // LEARN: InputDecoration uses the theme's input decoration theme.
            // We configured this in app_theme.dart.
          ),
        ),
      ],
    );
  }

  /// Build suffix icon (password toggle or custom icon)
  Widget? _buildSuffixIcon() {
    // Password visibility toggle
    if (widget.type == TextFieldType.password && widget.showPasswordToggle) {
      return IconButton(
        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        tooltip: _obscureText ? 'Show password' : 'Hide password',
      );
    }

    // Custom suffix icon
    if (widget.suffixIcon != null) {
      return Icon(widget.suffixIcon);
    }

    return null;
  }
}

/// Text Field Type Enum
///
/// LEARN: Defines different types of text fields.
/// Each type has different validation and keyboard.
enum TextFieldType {
  /// Regular text
  text,

  /// Email address
  email,

  /// Password (hidden text)
  password,

  /// Phone number
  phone,

  /// Numbers only
  number,
}
