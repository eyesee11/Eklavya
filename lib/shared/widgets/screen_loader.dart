import 'package:flutter/material.dart';
import '../../shared/theme/athletic_theme.dart';

class ScreenLoader extends StatefulWidget {
  final Widget child;
  
  const ScreenLoader({super.key, required this.child});

  @override
  State<ScreenLoader> createState() => _ScreenLoaderState();
}

class _ScreenLoaderState extends State<ScreenLoader> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    // Start animations
    _animationController.forward();
    _pulseController.repeat(reverse: true);
    
    // Hide loader after delay
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading) {
      return widget.child;
    }

    return Scaffold(
      backgroundColor: AthleticTheme.background,
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AthleticTheme.primary.withOpacity(0.1),
                    AthleticTheme.background,
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Logo/Icon
                    AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AthleticTheme.primary,
                                        Colors.amber,
                                        AthleticTheme.primary,
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AthleticTheme.primary.withOpacity(0.5),
                                        blurRadius: 30,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.sports,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // App Title
                    Text(
                      'SIH Sports Assessment',
                      style: TextStyle(
                        color: AthleticTheme.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      'AI-Powered Talent Discovery',
                      style: TextStyle(
                        color: AthleticTheme.textSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    
                    const SizedBox(height: 60),
                    
                    // Loading Animation
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          // Progress Bar
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                return FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: _animationController.value * 0.8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AthleticTheme.primary,
                                          Colors.amber,
                                          Colors.red,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AthleticTheme.primary.withOpacity(0.5),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Loading Text
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              final progress = (_animationController.value * 100).toInt();
                              String loadingText = 'Initializing...';
                              
                              if (progress > 20) loadingText = 'Loading AI Models...';
                              if (progress > 40) loadingText = 'Setting up Analytics...';
                              if (progress > 60) loadingText = 'Preparing Dashboard...';
                              if (progress > 80) loadingText = 'Almost Ready...';
                              
                              return Text(
                                loadingText,
                                style: TextStyle(
                                  color: AthleticTheme.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
