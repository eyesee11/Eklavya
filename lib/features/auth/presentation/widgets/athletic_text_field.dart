import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';

class AthleticTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final int maxLines;
  final FocusNode? focusNode;

  const AthleticTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.focusNode,
  });

  @override
  State<AthleticTextField> createState() => _AthleticTextFieldState();
}

class _AthleticTextFieldState extends State<AthleticTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _borderColorAnimation;
  late Animation<Color?> _labelColorAnimation;
  
  bool _obscureText = true;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.isPassword;
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _borderColorAnimation = ColorTween(
      begin: AthleticTheme.textSecondary.withOpacity(0.3),
      end: AthleticTheme.primary,
    ).animate(_controller);
    
    _labelColorAnimation = ColorTween(
      begin: AthleticTheme.textSecondary,
      end: AthleticTheme.primary,
    ).animate(_controller);
    
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    
    if (_isFocused) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: AthleticTheme.cardBackground.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _borderColorAnimation.value ?? AthleticTheme.textSecondary.withOpacity(0.3),
              width: _isFocused ? 2 : 1,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: AthleticTheme.primary.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.isPassword ? _obscureText : false,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: AthleticTheme.textSecondary.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _labelColorAnimation.value ?? AthleticTheme.textSecondary,
                      size: 22,
                    )
                  : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: _labelColorAnimation.value ?? AthleticTheme.textSecondary,
                        size: 22,
                      ),
                      onPressed: _togglePasswordVisibility,
                    )
                  : widget.suffixIcon != null
                      ? IconButton(
                          icon: Icon(
                            widget.suffixIcon,
                            color: _labelColorAnimation.value ?? AthleticTheme.textSecondary,
                            size: 22,
                          ),
                          onPressed: widget.onSuffixIconPressed,
                        )
                      : null,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}

class AthleticSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onChanged;
  final VoidCallback? onClear;

  const AthleticSearchField({
    super.key,
    required this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AthleticTheme.textSecondary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: AthleticTheme.textPrimary,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AthleticTheme.textSecondary.withOpacity(0.7),
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AthleticTheme.textSecondary,
            size: 22,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: AthleticTheme.textSecondary,
                    size: 20,
                  ),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                  },
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        onChanged: (value) => onChanged?.call(),
      ),
    );
  }
}
