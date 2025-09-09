import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';
import '../../../ai_analysis/presentation/pages/ai_assessment_page.dart';

class AthleticHomePage extends StatefulWidget {
  final bool showBottomNav;
  
  const AthleticHomePage({super.key, this.showBottomNav = true});

  @override
  State<AthleticHomePage> createState() => _AthleticHomePageState();
}

class _AthleticHomePageState extends State<AthleticHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AthleticTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Section with Gradient
              const _HeroSection(),
              
              // Quick Stats
              const _QuickStatsSection(),
              
              // Featured Workouts
              const _FeaturedWorkoutsSection(),
              
              // AI Assessment Preview
              const _AIAssessmentSection(),
              
              // Today's Challenge
              const _TodaysChallengeSection(),
              
              // Training Categories
              const _TrainingCategoriesSection(),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.showBottomNav ? _buildBottomNav() : null,
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_filled, 'Home', 0, true),
              _buildNavItem(Icons.fitness_center, 'Train', 1, false),
              _buildNavItem(Icons.psychology, 'AI Assess', 2, false),
              _buildNavItem(Icons.bar_chart, 'Progress', 3, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Navigation handled by parent container
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AthleticTheme.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AthleticTheme.primary : AthleticTheme.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AthleticTheme.primary : AthleticTheme.textSecondary,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AthleticTheme.primary.withOpacity(0.9),
            AthleticTheme.primary.withOpacity(0.7),
            Colors.black.withOpacity(0.8),
          ],
        ),
        // Background would go here when images are added
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              // Header without profile icon
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning',
                    style: TextStyle(
                      color: AthleticTheme.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Champion',
                    style: TextStyle(
                      color: AthleticTheme.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),            const Spacer(),
            
            // Motivational content
            Text(
              'PUSH YOUR LIMITS',
              style: TextStyle(
                color: AthleticTheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Unlock Your Athletic\nPotential with AI',
              style: TextStyle(
                color: AthleticTheme.textPrimary,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            
            // CTA Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AIAssessmentPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AthleticTheme.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 8,
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
          ],
        ),
      ),
    );
  }
}

class _QuickStatsSection extends StatelessWidget {
  const _QuickStatsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: _buildStatCard('Today\'s Score', '92', Icons.trending_up, Colors.green)),
          const SizedBox(width: 12),
          Expanded(child: _buildStatCard('Streak', '7 Days', Icons.local_fire_department, AthleticTheme.primary)),
          const SizedBox(width: 12),
          Expanded(child: _buildStatCard('Rank', '#1,247', Icons.emoji_events, Colors.amber)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: AthleticTheme.textSecondary,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FeaturedWorkoutsSection extends StatelessWidget {
  const _FeaturedWorkoutsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Featured Training',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildWorkoutCard(
                'Speed & Agility',
                '45 min • High Intensity',
                'assets/images/speed_training.jpg',
                Colors.red,
              ),
              _buildWorkoutCard(
                'Strength Builder',
                '30 min • Moderate',
                'assets/images/strength_training.jpg',
                Colors.blue,
              ),
              _buildWorkoutCard(
                'Endurance Pro',
                '60 min • Cardio Focus',
                'assets/images/endurance_training.jpg',
                Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutCard(String title, String subtitle, String imagePath, Color accentColor) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            accentColor.withOpacity(0.1),
            Colors.black.withOpacity(0.8),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor, width: 1),
              ),
              child: Text(
                'FEATURED',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: AthleticTheme.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: AthleticTheme.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AIAssessmentSection extends StatelessWidget {
  const _AIAssessmentSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AthleticTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AthleticTheme.primary.withOpacity(0.1),
              Colors.transparent,
            ],
          ),
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
                    Icons.psychology,
                    color: AthleticTheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Sports Assessment',
                        style: TextStyle(
                          color: AthleticTheme.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Analyze your form with computer vision',
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
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildAssessmentMetric('Accuracy', '94%', Icons.center_focus_strong),
                ),
                Expanded(
                  child: _buildAssessmentMetric('Form Score', '8.7/10', Icons.grade),
                ),
                Expanded(
                  child: _buildAssessmentMetric('Improvement', '+12%', Icons.trending_up),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AIAssessmentPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AthleticTheme.primary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Start AI Assessment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentMetric(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AthleticTheme.primary, size: 20),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: AthleticTheme.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: AthleticTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _TodaysChallengeSection extends StatelessWidget {
  const _TodaysChallengeSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AthleticTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.amber.withOpacity(0.1),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.flash_on,
                color: Colors.amber,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s Challenge',
                    style: TextStyle(
                      color: AthleticTheme.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Complete 50 burpees in under 5 minutes',
                    style: TextStyle(
                      color: AthleticTheme.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.grey[800],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ],
              ),
            ),
            Text(
              '60%',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrainingCategoriesSection extends StatelessWidget {
  const _TrainingCategoriesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            'Training Categories',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildCategoryCard('Football', Icons.sports_soccer, Colors.green),
              _buildCategoryCard('Basketball', Icons.sports_basketball, Colors.orange),
              _buildCategoryCard('Running', Icons.directions_run, Colors.blue),
              _buildCategoryCard('Swimming', Icons.pool, Colors.cyan),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
