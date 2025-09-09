import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OptionalScreenLoader extends StatefulWidget {
  final Widget child;
  
  const OptionalScreenLoader({super.key, required this.child});

  @override
  State<OptionalScreenLoader> createState() => _OptionalScreenLoaderState();
}

class _OptionalScreenLoaderState extends State<OptionalScreenLoader>
    with TickerProviderStateMixin {
  late AnimationController _paintController;
  late AnimationController _textController;
  late Animation<double> _paintAnimation;
  late Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();
    
    // Paint splash animation controller
    _paintController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    
    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    // Paint splash animation (starts from center and expands)
    _paintAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _paintController,
      curve: Curves.easeOutQuart,
    ));
    
    // Text opacity animation (appears after paint splash)
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));
    
    // Start animations
    _paintController.forward();
    
    // Start text animation after 1.5 seconds
    Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _textController.forward();
      }
    });
    
    // Navigate to main app after 5 seconds
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => widget.child),
        );
      }
    });
  }

  @override
  void dispose() {
    _paintController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_paintController, _textController]),
        builder: (context, child) {
          return Stack(
            children: [
              // Black background
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
              ),
              
              // Orange paint splash effect
              CustomPaint(
                size: screenSize,
                painter: PaintSplashPainter(
                  progress: _paintAnimation.value,
                  screenSize: screenSize,
                ),
              ),
              
              // App title "Eklavya" - remains black and visible
              Center(
                child: AnimatedBuilder(
                  animation: _textOpacity,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textOpacity.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Main title with black text (visible against orange)
                          Text(
                            'Eklavya',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              letterSpacing: 4,
                              shadows: [
                                Shadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Subtitle
                          Text(
                            'Sports Talent Assessment',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Loading indicator at bottom
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PaintSplashPainter extends CustomPainter {
  final double progress;
  final Size screenSize;
  
  PaintSplashPainter({
    required this.progress,
    required this.screenSize,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF6600) // Orange color
      ..style = PaintingStyle.fill;
    
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.sqrt(size.width * size.width + size.height * size.height) / 2;
    
    // Create multiple paint splashes for realistic effect
    final splashes = [
      _PaintSplash(center, maxRadius * 1.2, 0.0, 1.0),
      _PaintSplash(
        Offset(center.dx - size.width * 0.1, center.dy - size.height * 0.1),
        maxRadius * 0.8,
        0.1,
        0.9,
      ),
      _PaintSplash(
        Offset(center.dx + size.width * 0.15, center.dy + size.height * 0.2),
        maxRadius * 0.6,
        0.2,
        0.8,
      ),
    ];
    
    for (final splash in splashes) {
      final splashProgress = ((progress - splash.startDelay) / (splash.endDelay - splash.startDelay))
          .clamp(0.0, 1.0);
      
      if (splashProgress > 0) {
        final currentRadius = splash.maxRadius * _easeOutQuart(splashProgress);
        
        // Create irregular splash shape
        final path = Path();
        final points = <Offset>[];
        
        for (int i = 0; i < 12; i++) {
          final angle = (i / 12) * 2 * math.pi;
          final radiusVariation = 0.8 + 0.4 * math.sin(angle * 3 + progress * 10);
          final radius = currentRadius * radiusVariation;
          
          points.add(Offset(
            splash.center.dx + radius * math.cos(angle),
            splash.center.dy + radius * math.sin(angle),
          ));
        }
        
        if (points.isNotEmpty) {
          path.moveTo(points[0].dx, points[0].dy);
          for (int i = 1; i < points.length; i++) {
            path.lineTo(points[i].dx, points[i].dy);
          }
          path.close();
          
          canvas.drawPath(path, paint);
        }
      }
    }
  }
  
  double _easeOutQuart(double t) {
    return 1 - math.pow(1 - t, 4).toDouble();
  }
  
  @override
  bool shouldRepaint(PaintSplashPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _PaintSplash {
  final Offset center;
  final double maxRadius;
  final double startDelay;
  final double endDelay;
  
  _PaintSplash(this.center, this.maxRadius, this.startDelay, this.endDelay);
}
