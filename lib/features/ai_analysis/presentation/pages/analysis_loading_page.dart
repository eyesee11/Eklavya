import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';
import 'ai_results_page.dart';

class AnalysisLoadingPage extends StatefulWidget {
  const AnalysisLoadingPage({super.key});

  @override
  State<AnalysisLoadingPage> createState() => _AnalysisLoadingPageState();
}

class _AnalysisLoadingPageState extends State<AnalysisLoadingPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  
  int _currentStep = 0;
  final List<String> _steps = [
    'Initializing AI Models...',
    'Processing Video Feed...',
    'Analyzing Body Movement...',
    'Calculating Performance Metrics...',
    'Generating Insights...',
    'Finalizing Report...',
  ];

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_rotationController);
    
    _pulseController.repeat(reverse: true);
    _rotationController.repeat();
    
    _simulateAnalysis();
  }

  void _simulateAnalysis() {
    for (int i = 0; i < _steps.length; i++) {
      Future.delayed(Duration(seconds: i * 2), () {
        if (mounted) {
          setState(() {
            _currentStep = i;
          });
        }
        
        if (i == _steps.length - 1) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AIResultsPage(),
                ),
              );
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AthleticTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: AthleticTheme.textPrimary,
                    ),
                  ),
                  Text(
                    'AI Analysis',
                    style: TextStyle(
                      color: AthleticTheme.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // AI Brain Animation
              AnimatedBuilder(
                animation: Listenable.merge([_pulseAnimation, _rotationAnimation]),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value * 2 * 3.14159,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AthleticTheme.primary.withOpacity(0.8),
                              AthleticTheme.primary.withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                          border: Border.all(
                            color: AthleticTheme.primary,
                            width: 3,
                          ),
                        ),
                        child: Icon(
                          Icons.psychology,
                          size: 80,
                          color: AthleticTheme.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 40),
              
              // Progress Text
              Text(
                'AI PROCESSING',
                style: TextStyle(
                  color: AthleticTheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Analyzing your athletic performance\nwith advanced AI technology',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AthleticTheme.textSecondary,
                  fontSize: 16,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Progress Steps
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AthleticTheme.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: (_currentStep + 1) / _steps.length,
                      backgroundColor: Colors.grey[800],
                      valueColor: AlwaysStoppedAnimation<Color>(AthleticTheme.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${((_currentStep + 1) / _steps.length * 100).round()}%',
                      style: TextStyle(
                        color: AthleticTheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentStep < _steps.length ? _steps[_currentStep] : 'Complete!',
                      style: TextStyle(
                        color: AthleticTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Processing Steps List
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AthleticTheme.cardBackground.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Processing Steps:',
                      style: TextStyle(
                        color: AthleticTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(_steps.length, (index) {
                      final isCompleted = index < _currentStep;
                      final isCurrent = index == _currentStep;
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted
                                    ? AthleticTheme.primary
                                    : isCurrent
                                        ? AthleticTheme.primary.withOpacity(0.5)
                                        : Colors.grey[700],
                              ),
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.black,
                                    )
                                  : isCurrent
                                      ? SizedBox(
                                          width: 12,
                                          height: 12,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              AthleticTheme.primary,
                                            ),
                                          ),
                                        )
                                      : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _steps[index],
                                style: TextStyle(
                                  color: isCompleted || isCurrent
                                      ? AthleticTheme.textPrimary
                                      : AthleticTheme.textSecondary,
                                  fontSize: 14,
                                  fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnalysisResultsPage extends StatelessWidget {
  const AnalysisResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AthleticTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: AthleticTheme.textPrimary,
                    ),
                  ),
                  Text(
                    'Analysis Results',
                    style: TextStyle(
                      color: AthleticTheme.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Overall Score
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AthleticTheme.primary.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AthleticTheme.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'OVERALL PERFORMANCE',
                      style: TextStyle(
                        color: AthleticTheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '8.7',
                      style: TextStyle(
                        color: AthleticTheme.textPrimary,
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'out of 10',
                      style: TextStyle(
                        color: AthleticTheme.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Excellent Form',
                      style: TextStyle(
                        color: AthleticTheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Detailed Metrics
              Text(
                'Detailed Analysis',
                style: TextStyle(
                  color: AthleticTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 16),
              
              _buildMetricCard('Form Accuracy', 92, Icons.center_focus_strong, Colors.green),
              const SizedBox(height: 12),
              _buildMetricCard('Balance & Stability', 88, Icons.balance, Colors.blue),
              const SizedBox(height: 12),
              _buildMetricCard('Movement Efficiency', 85, Icons.speed, Colors.orange),
              const SizedBox(height: 12),
              _buildMetricCard('Technique Consistency', 90, Icons.trending_up, Colors.purple),
              
              const SizedBox(height: 24),
              
              // Recommendations
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AthleticTheme.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: AthleticTheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'AI Recommendations',
                          style: TextStyle(
                            color: AthleticTheme.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildRecommendation(
                      'Improve Core Stability',
                      'Focus on planks and stability exercises to enhance balance during movements.',
                      Icons.fitness_center,
                    ),
                    _buildRecommendation(
                      'Work on Landing Technique',
                      'Practice soft landings to reduce impact and improve efficiency.',
                      Icons.sports_gymnastics,
                    ),
                    _buildRecommendation(
                      'Increase Flexibility',
                      'Add dynamic stretching to your warm-up routine for better range of motion.',
                      Icons.self_improvement,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AthleticTheme.primary,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Results',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AthleticTheme.primary),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Share Results',
                        style: TextStyle(
                          color: AthleticTheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, int score, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: score / 100,
                  backgroundColor: Colors.grey[800],
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '$score%',
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendation(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AthleticTheme.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: AthleticTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
