import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';

class AthleticButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;

  const AthleticButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isFullWidth = false,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
  });

  @override
  State<AthleticButton> createState() => _AthleticButtonState();
}

class _AthleticButtonState extends State<AthleticButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: widget.isLoading ? null : widget.onPressed,
            child: Container(
              width: widget.isFullWidth ? double.infinity : null,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: widget.onPressed == null
                      ? [
                          Colors.grey.withOpacity(0.3),
                          Colors.grey.withOpacity(0.2),
                        ]
                      : [
                          widget.backgroundColor ?? AthleticTheme.primary,
                          (widget.backgroundColor ?? AthleticTheme.primary)
                              .withOpacity(0.8),
                        ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: widget.onPressed == null || widget.isLoading
                    ? []
                    : [
                        BoxShadow(
                          color: (widget.backgroundColor ?? AthleticTheme.primary)
                              .withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
              ),
              child: widget.isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.textColor ?? Colors.black,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            color: widget.textColor ?? Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          widget.text,
                          style: TextStyle(
                            color: widget.textColor ?? Colors.black,
                            fontSize: widget.fontSize ?? 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

class AthleticSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final IconData? icon;

  const AthleticSecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isFullWidth = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: isFullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AthleticTheme.primary,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: AthleticTheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: AthleticTheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
