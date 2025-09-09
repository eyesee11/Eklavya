import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../shared/theme/athletic_theme.dart';

class CameraAssessmentPage extends StatefulWidget {
  final String sport;
  final String level;
  final String assessmentType;

  const CameraAssessmentPage({
    super.key,
    required this.sport,
    required this.level,
    required this.assessmentType,
  });

  @override
  State<CameraAssessmentPage> createState() => _CameraAssessmentPageState();
}

class _CameraAssessmentPageState extends State<CameraAssessmentPage>
    with TickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isRecording = false;
  bool _isAnalyzing = false;
  String _currentInstruction = '';
  Timer? _instructionTimer;
  Timer? _assessmentTimer;
  int _currentPhase = 0;
  int _countdownTimer = 3;
  bool _showCountdown = false;
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  final List<String> _poseInstructions = [
    'Stand in a neutral position',
    'Prepare for movement',
    'Begin your exercise',
    'Maintain proper form',
    'Complete the movement',
  ];

  final List<PosePoint> _posePoints = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeCamera();
  }

  void _initializeControllers() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    _pulseController.repeat(reverse: true);

    _progressController = AnimationController(
      duration: const Duration(minutes: 2), // 2-minute assessment
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_progressController);
  }

  Future<void> _initializeCamera() async {
    // Request camera permission
    final status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      _showPermissionDialog();
      return;
    }

    try {
      _cameras = await availableCameras();
      if (_cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _cameraController!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
            _currentInstruction = _poseInstructions[0];
          });
        }
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
      _showErrorDialog('Failed to initialize camera: $e');
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AthleticTheme.cardBackground,
        title: Text(
          'Camera Permission Required',
          style: TextStyle(color: AthleticTheme.textPrimary),
        ),
        content: Text(
          'This app needs camera access to perform motion analysis and pose detection.',
          style: TextStyle(color: AthleticTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel', style: TextStyle(color: AthleticTheme.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: Text('Settings', style: TextStyle(color: AthleticTheme.primary)),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AthleticTheme.cardBackground,
        title: Text(
          'Error',
          style: TextStyle(color: AthleticTheme.textPrimary),
        ),
        content: Text(
          message,
          style: TextStyle(color: AthleticTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('OK', style: TextStyle(color: AthleticTheme.primary)),
          ),
        ],
      ),
    );
  }

  void _startAssessment() {
    setState(() {
      _showCountdown = true;
      _countdownTimer = 3;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownTimer > 1) {
        setState(() {
          _countdownTimer--;
        });
      } else {
        timer.cancel();
        setState(() {
          _showCountdown = false;
          _isRecording = true;
          _isAnalyzing = true;
        });
        _progressController.forward();
        _startInstructionCycle();
      }
    });
  }

  void _startInstructionCycle() {
    _instructionTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (_currentPhase < _poseInstructions.length - 1) {
        setState(() {
          _currentPhase++;
          _currentInstruction = _poseInstructions[_currentPhase];
        });
      } else {
        timer.cancel();
        _completeAssessment();
      }
    });

    // Complete assessment after 2 minutes
    _assessmentTimer = Timer(const Duration(minutes: 2), () {
      _completeAssessment();
    });
  }

  void _completeAssessment() {
    _instructionTimer?.cancel();
    _assessmentTimer?.cancel();
    _progressController.stop();
    
    setState(() {
      _isRecording = false;
      _isAnalyzing = false;
    });

    _showResultsDialog();
  }

  void _showResultsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AthleticTheme.cardBackground,
        title: Row(
          children: [
            Icon(Icons.check_circle, color: AthleticTheme.primary),
            const SizedBox(width: 12),
            Text(
              'Assessment Complete',
              style: TextStyle(color: AthleticTheme.textPrimary),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your ${widget.assessmentType.toLowerCase()} assessment has been completed successfully.',
              style: TextStyle(color: AthleticTheme.textSecondary),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AthleticTheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assessment Details:',
                    style: TextStyle(
                      color: AthleticTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Sport: ${widget.sport}', style: TextStyle(color: AthleticTheme.textSecondary)),
                  Text('Level: ${widget.level}', style: TextStyle(color: AthleticTheme.textSecondary)),
                  Text('Type: ${widget.assessmentType}', style: TextStyle(color: AthleticTheme.textSecondary)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to AI Assessment page
            },
            child: Text('View Results', style: TextStyle(color: AthleticTheme.primary)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _instructionTimer?.cancel();
    _assessmentTimer?.cancel();
    _pulseController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview
            if (_isCameraInitialized && _cameraController != null)
              Positioned.fill(
                child: CameraPreview(_cameraController!),
              )
            else
              const Center(
                child: CircularProgressIndicator(),
              ),

            // Pose Points Overlay
            if (_isAnalyzing)
              Positioned.fill(
                child: CustomPaint(
                  painter: PosePainter(_posePoints),
                ),
              ),

            // Top UI Overlay
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // Header
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'AI MOTION ANALYSIS',
                                style: TextStyle(
                                  color: AthleticTheme.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                '${widget.sport} • ${widget.assessmentType}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _isRecording 
                                ? Colors.red.withOpacity(0.8)
                                : AthleticTheme.primary.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _isRecording ? _pulseAnimation.value : 1.0,
                                    child: Icon(
                                      _isRecording ? Icons.fiber_manual_record : Icons.camera_alt,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _isRecording ? 'RECORDING' : 'READY',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    // Progress Bar
                    if (_isRecording)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              value: _progressAnimation.value,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              valueColor: AlwaysStoppedAnimation<Color>(AthleticTheme.primary),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Instruction Overlay
            if (_currentInstruction.isNotEmpty && !_showCountdown)
              Positioned(
                left: 16,
                right: 16,
                top: MediaQuery.of(context).size.height * 0.3,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AthleticTheme.primary, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.directions_run,
                        color: AthleticTheme.primary,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _currentInstruction,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Countdown Overlay
            if (_showCountdown)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _countdownTimer.toString(),
                          style: TextStyle(
                            color: AthleticTheme.primary,
                            fontSize: 120,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Get Ready!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Bottom Controls
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    if (!_isRecording && !_showCountdown)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isCameraInitialized ? _startAssessment : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AthleticTheme.primary,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'START ASSESSMENT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    
                    if (_isRecording)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildControlButton(
                            icon: Icons.pause,
                            label: 'Pause',
                            onPressed: () {
                              // Implement pause functionality
                            },
                          ),
                          _buildControlButton(
                            icon: Icons.stop,
                            label: 'Stop',
                            onPressed: _completeAssessment,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Pose Point class for storing detected pose landmarks
class PosePoint {
  final double x;
  final double y;
  final double confidence;
  final String label;

  PosePoint({
    required this.x,
    required this.y,
    required this.confidence,
    required this.label,
  });
}

// Custom painter for drawing pose points and connections
class PosePainter extends CustomPainter {
  final List<PosePoint> posePoints;

  PosePainter(this.posePoints);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF6600)
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    // Draw pose points
    for (final point in posePoints) {
      if (point.confidence > 0.5) {
        canvas.drawCircle(
          Offset(point.x * size.width, point.y * size.height),
          6,
          paint,
        );
      }
    }

    // Here you would implement the logic to draw connections between pose points
    // This is where the ML model would provide the skeletal structure
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
