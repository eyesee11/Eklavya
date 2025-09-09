import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';

class AIResultsPage extends StatefulWidget {
  const AIResultsPage({super.key});

  @override
  State<AIResultsPage> createState() => _AIResultsPageState();
}

class _AIResultsPageState extends State<AIResultsPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  int _selectedTab = 0;
  final List<String> tabs = ['Overview', 'Form Analysis', 'Performance', 'Recommendations'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AthleticTheme.background,
      appBar: AppBar(
        backgroundColor: AthleticTheme.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: AthleticTheme.textPrimary,
          ),
        ),
        title: Text(
          'AI Analysis Results',
          style: TextStyle(
            color: AthleticTheme.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: AthleticTheme.textPrimary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Success Header
                Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.withOpacity(0.2),
                        Colors.green.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.green.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Analysis Complete!',
                              style: TextStyle(
                                color: AthleticTheme.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Your performance has been analyzed using advanced AI technology',
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
                ),
                
                // Tab Navigation
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: tabs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tab = entry.value;
                        final isSelected = _selectedTab == index;
                        
                        return GestureDetector(
                          onTap: () => setState(() => _selectedTab = index),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? AthleticTheme.primary 
                                  : AthleticTheme.cardBackground,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tab,
                              style: TextStyle(
                                color: isSelected 
                                    ? Colors.black 
                                    : AthleticTheme.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                Expanded(
                  child: _buildTabContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildFormAnalysisTab();
      case 2:
        return _buildPerformanceTab();
      case 3:
        return _buildRecommendationsTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall Score
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AthleticTheme.primary.withOpacity(0.2),
                  AthleticTheme.primary.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  'Overall Performance Score',
                  style: TextStyle(
                    color: AthleticTheme.textSecondary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: 0.85,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation<Color>(AthleticTheme.primary),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '85',
                          style: TextStyle(
                            color: AthleticTheme.textPrimary,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'EXCELLENT',
                          style: TextStyle(
                            color: AthleticTheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'You\'re performing at an elite level with room for targeted improvements',
                  style: TextStyle(
                    color: AthleticTheme.textSecondary,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Key Metrics
          Text(
            'Key Performance Metrics',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(child: _buildScoreCard('Technique', 92, Colors.green)),
              const SizedBox(width: 12),
              Expanded(child: _buildScoreCard('Power', 78, Colors.orange)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildScoreCard('Endurance', 85, Colors.blue)),
              const SizedBox(width: 12),
              Expanded(child: _buildScoreCard('Speed', 73, Colors.red)),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Strengths and Weaknesses
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildStrengthsWeaknesses(
                  'Strengths',
                  [
                    'Excellent form consistency',
                    'Strong core stability',
                    'Great balance control',
                  ],
                  Colors.green,
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStrengthsWeaknesses(
                  'Areas to Improve',
                  [
                    'Explosive power output',
                    'Recovery time',
                    'Flexibility range',
                  ],
                  Colors.orange,
                  Icons.trending_down,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormAnalysisTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Movement Analysis',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildAnalysisCard(
            'Body Alignment',
            'Excellent posture maintenance throughout the movement',
            96,
            Colors.green,
            Icons.straighten,
          ),
          const SizedBox(height: 12),
          
          _buildAnalysisCard(
            'Joint Mobility',
            'Good range of motion with minor limitations in ankles',
            82,
            Colors.blue,
            Icons.accessibility,
          ),
          const SizedBox(height: 12),
          
          _buildAnalysisCard(
            'Movement Symmetry',
            'Slight imbalance detected on the left side',
            74,
            Colors.orange,
            Icons.balance,
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Technical Breakdown',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildTechnicalPoint('Phase 1: Setup', 'Perfect stance positioning', Colors.green),
          _buildTechnicalPoint('Phase 2: Execution', 'Minor timing adjustment needed', Colors.orange),
          _buildTechnicalPoint('Phase 3: Follow-through', 'Excellent completion form', Colors.green),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Metrics',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildPerformanceMetric('Peak Force', '856 N', '↗ +12%', Colors.red),
          _buildPerformanceMetric('Average Power', '445 W', '↗ +8%', Colors.blue),
          _buildPerformanceMetric('Speed Index', '24.3 m/s', '↗ +5%', Colors.green),
          _buildPerformanceMetric('Efficiency', '87%', '↗ +3%', Colors.purple),
          
          const SizedBox(height: 24),
          
          Text(
            'Comparison to Elite Athletes',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildComparisonCard('You are in the top 15% of athletes in your category'),
        ],
      ),
    );
  }

  Widget _buildRecommendationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personalized Training Plan',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildRecommendationCard(
            'Power Development',
            'Focus on explosive movements and plyometric training',
            'High Priority',
            Colors.red,
            Icons.flash_on,
          ),
          const SizedBox(height: 12),
          
          _buildRecommendationCard(
            'Flexibility Training',
            'Daily stretching routine for ankle mobility',
            'Medium Priority',
            Colors.orange,
            Icons.self_improvement,
          ),
          const SizedBox(height: 12),
          
          _buildRecommendationCard(
            'Balance Correction',
            'Unilateral exercises to address left-side weakness',
            'Medium Priority',
            Colors.blue,
            Icons.balance,
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Suggested Workouts',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildWorkoutSuggestion('Explosive Power Circuit', '25 min', 'Plyometrics'),
          _buildWorkoutSuggestion('Mobility Flow', '15 min', 'Flexibility'),
          _buildWorkoutSuggestion('Balance & Stability', '20 min', 'Corrective'),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String title, int score, Color color) {
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
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: AthleticTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$score',
            style: TextStyle(
              color: color,
              fontSize: 32,
              fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildStrengthsWeaknesses(String title, List<String> items, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: AthleticTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      color: AthleticTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalysisCard(String title, String description, int score, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
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

  Widget _buildTechnicalPoint(String phase, String feedback, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phase,
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feedback,
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

  Widget _buildPerformanceMetric(String metric, String value, String change, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            metric,
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: AthleticTheme.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                change,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AthleticTheme.primary.withOpacity(0.2),
            AthleticTheme.primary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.emoji_events,
            color: AthleticTheme.primary,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AthleticTheme.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String description, String priority, Color color, IconData icon) {
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AthleticTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        priority,
                        style: TextStyle(
                          color: color,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildWorkoutSuggestion(String title, String duration, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AthleticTheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.fitness_center,
              color: AthleticTheme.primary,
              size: 20,
            ),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$duration • $type',
                  style: TextStyle(
                    color: AthleticTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'START',
              style: TextStyle(
                color: AthleticTheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
