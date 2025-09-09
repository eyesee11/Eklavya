import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';
import '../../../../features/auth/presentation/widgets/athletic_button.dart';
import 'camera_assessment_page.dart';

class AIAssessmentPage extends StatefulWidget {
  const AIAssessmentPage({super.key});

  @override
  State<AIAssessmentPage> createState() => _AIAssessmentPageState();
}

class _AIAssessmentPageState extends State<AIAssessmentPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  String? selectedSport;
  String? selectedLevel;
  String? selectedAssessment;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AthleticTheme.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AthleticTheme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.psychology,
                        color: AthleticTheme.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI ASSESSMENT',
                            style: TextStyle(
                              color: AthleticTheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            'Analyze Your Performance',
                            style: TextStyle(
                              color: AthleticTheme.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // AI Features Showcase
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AthleticTheme.primary.withOpacity(0.1),
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
                        'POWERED BY AI',
                        style: TextStyle(
                          color: AthleticTheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: _buildFeatureItem(Icons.video_camera_back, 'Motion\nCapture')),
                          Expanded(child: _buildFeatureItem(Icons.analytics, 'Real-time\nAnalysis')),
                          Expanded(child: _buildFeatureItem(Icons.insights, 'Performance\nInsights')),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Camera Access Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AthleticTheme.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AthleticTheme.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AthleticTheme.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.videocam,
                              color: AthleticTheme.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Motion Capture & Pose Analysis',
                                  style: TextStyle(
                                    color: AthleticTheme.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'AI-powered real-time analysis of your movements',
                                  style: TextStyle(
                                    color: AthleticTheme.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCameraFeature(
                              Icons.accessibility_new,
                              'Pose Detection',
                              'Track body movements',
                            ),
                          ),
                          Expanded(
                            child: _buildCameraFeature(
                              Icons.timeline,
                              'Form Analysis',
                              'Analyze technique',
                            ),
                          ),
                          Expanded(
                            child: _buildCameraFeature(
                              Icons.insights,
                              'Real-time Tips',
                              'Instant feedback',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Sport Selection
                Text(
                  'Select Sport',
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  children: [
                    _buildSportCard('Football', Icons.sports_soccer, Colors.green),
                    _buildSportCard('Basketball', Icons.sports_basketball, Colors.orange),
                    _buildSportCard('Running', Icons.directions_run, Colors.blue),
                    _buildSportCard('Swimming', Icons.pool, Colors.cyan),
                    _buildSportCard('Tennis', Icons.sports_tennis, Colors.yellow),
                    _buildSportCard('Gymnastics', Icons.sports_gymnastics, Colors.purple),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Experience Level
                Text(
                  'Experience Level',
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(child: _buildLevelCard('Beginner', Icons.sports, Colors.green)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildLevelCard('Intermediate', Icons.sports_handball, Colors.orange)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildLevelCard('Advanced', Icons.emoji_events, Colors.red)),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Assessment Type
                Text(
                  'Assessment Type',
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildAssessmentCard(
                  'Form Analysis',
                  'Analyze your technique and form for optimal performance',
                  Icons.center_focus_strong,
                  Colors.blue,
                ),
                const SizedBox(height: 12),
                _buildAssessmentCard(
                  'Speed Assessment',
                  'Measure your speed, acceleration, and movement efficiency',
                  Icons.speed,
                  Colors.green,
                ),
                const SizedBox(height: 12),
                _buildAssessmentCard(
                  'Endurance Test',
                  'Evaluate your stamina and cardiovascular performance',
                  Icons.favorite,
                  Colors.red,
                ),
                const SizedBox(height: 12),
                _buildAssessmentCard(
                  'Full Assessment',
                  'Comprehensive analysis covering all performance aspects',
                  Icons.analytics,
                  AthleticTheme.primary,
                ),
                
                const SizedBox(height: 40),
                
                // Start Assessment Button
                SizedBox(
                  width: double.infinity,
                  child: AthleticButton(
                    text: 'START AI ASSESSMENT',
                    icon: Icons.play_arrow,
                    isFullWidth: true,
                    onPressed: _canStartAssessment() ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CameraAssessmentPage(
                            sport: selectedSport!,
                            level: selectedLevel!,
                            assessmentType: selectedAssessment!,
                          ),
                        ),
                      );
                    } : null,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Info Text
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AthleticTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AthleticTheme.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AthleticTheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Assessment Requirements',
                            style: TextStyle(
                              color: AthleticTheme.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• Camera access required for motion analysis\n'
                        '• Ensure good lighting and 2m space around you\n'
                        '• Assessment duration: 2-5 minutes\n'
                        '• Stand facing the camera throughout',
                        style: TextStyle(
                          color: AthleticTheme.textSecondary,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
          color: AthleticTheme.primary,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AthleticTheme.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSportCard(String sport, IconData icon, Color color) {
    final isSelected = selectedSport == sport;
    
    return GestureDetector(
      onTap: () => setState(() => selectedSport = sport),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? color.withOpacity(0.2) 
              : AthleticTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? color : AthleticTheme.textSecondary,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sport,
                style: TextStyle(
                  color: isSelected 
                      ? AthleticTheme.textPrimary 
                      : AthleticTheme.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard(String level, IconData icon, Color color) {
    final isSelected = selectedLevel == level;
    
    return GestureDetector(
      onTap: () => setState(() => selectedLevel = level),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? color.withOpacity(0.2) 
              : AthleticTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? color : AthleticTheme.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              level,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected 
                    ? AthleticTheme.textPrimary 
                    : AthleticTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentCard(String title, String description, IconData icon, Color color) {
    final isSelected = selectedAssessment == title;
    
    return GestureDetector(
      onTap: () => setState(() => selectedAssessment = title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? color.withOpacity(0.1) 
              : AthleticTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
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
                      fontWeight: FontWeight.bold,
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
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraFeature(IconData icon, String title, String description) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AthleticTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AthleticTheme.primary,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AthleticTheme.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AthleticTheme.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  bool _canStartAssessment() {
    return selectedSport != null && 
           selectedLevel != null && 
           selectedAssessment != null;
  }
}
