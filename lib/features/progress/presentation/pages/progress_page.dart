import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  
  int _selectedPeriod = 0;
  final List<String> periods = ['Week', 'Month', '3 Months', 'Year'];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AthleticTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                        gradient: LinearGradient(
                          colors: [
                            AthleticTheme.primary,
                            AthleticTheme.primary.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.trending_up,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PROGRESS',
                            style: TextStyle(
                              color: AthleticTheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            'Your Journey',
                            style: TextStyle(
                              color: AthleticTheme.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.calendar_today,
                        color: AthleticTheme.textPrimary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Period Selector
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: periods.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedPeriod == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedPeriod = index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AthleticTheme.primary 
                                : AthleticTheme.cardBackground,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            periods[index],
                            style: TextStyle(
                              color: isSelected 
                                  ? Colors.black 
                                  : AthleticTheme.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Weekly Stats
                Text(
                  'This Week\'s Performance',
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(child: _buildStatCard('Workouts', '12', '↗ +3', Colors.green)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatCard('Hours', '8.5', '↗ +1.2', Colors.blue)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildStatCard('Calories', '2.4K', '↗ +240', Colors.red)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatCard('Streak', '15 days', '🔥', Colors.orange)),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Progress Chart
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Weekly Activity',
                            style: TextStyle(
                              color: AthleticTheme.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Avg: 1.2h/day',
                            style: TextStyle(
                              color: AthleticTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildActivityChart(),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Achievements
                Text(
                  'Recent Achievements',
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildAchievementCard(
                  '🏆 Consistency Master',
                  'Completed workouts 7 days in a row',
                  'Unlocked 2 days ago',
                  Colors.yellow,
                ),
                const SizedBox(height: 12),
                _buildAchievementCard(
                  '💪 Strength Builder',
                  'Increased bench press by 20lbs',
                  'Unlocked 5 days ago',
                  Colors.red,
                ),
                const SizedBox(height: 12),
                _buildAchievementCard(
                  '🏃‍♂️ Speed Demon',
                  'Ran 5K under 25 minutes',
                  'Unlocked 1 week ago',
                  Colors.blue,
                ),
                
                const SizedBox(height: 32),
                
                // Progress Rings
                Text(
                  'Today\'s Goals',
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AthleticTheme.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildProgressRing('Move', 0.75, Colors.red, '450/600 cal'),
                      _buildProgressRing('Exercise', 0.5, Colors.green, '15/30 min'),
                      _buildProgressRing('Stand', 0.9, Colors.blue, '9/10 hrs'),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Body Measurements
                Text(
                  'Body Progress',
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AthleticTheme.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildMeasurementRow('Weight', '72.5 kg', '↓ -1.2 kg', Colors.green),
                      const Divider(color: Colors.grey, height: 32),
                      _buildMeasurementRow('Body Fat', '15.8%', '↓ -2.1%', Colors.green),
                      const Divider(color: Colors.grey, height: 32),
                      _buildMeasurementRow('Muscle Mass', '58.2 kg', '↗ +0.8 kg', Colors.blue),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Personal Records
                Text(
                  'Personal Records',
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                
                _buildPRCard('Bench Press', '85 kg', '+5 kg this month', Icons.fitness_center, Colors.red),
                const SizedBox(height: 12),
                _buildPRCard('5K Run', '23:45', '-30s this month', Icons.directions_run, Colors.blue),
                const SizedBox(height: 12),
                _buildPRCard('Plank Hold', '3:15', '+45s this month', Icons.timer, Colors.green),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String change, Color color) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AthleticTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  color: AthleticTheme.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
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
        );
      },
    );
  }

  Widget _buildActivityChart() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final values = [0.8, 1.2, 0.6, 1.5, 1.1, 2.0, 1.3];
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    
    return Container(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Container(
                    width: 24,
                    height: (values[index] / maxValue) * 80 * _progressAnimation.value,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AthleticTheme.primary,
                          AthleticTheme.primary.withOpacity(0.6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                days[index],
                style: TextStyle(
                  color: AthleticTheme.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildAchievementCard(String title, String description, String date, Color color) {
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
            child: Icon(
              Icons.emoji_events,
              color: color,
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
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: AthleticTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRing(        String title, double progress, Color color, String subtitle) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return CircularProgressIndicator(
                value: progress * _progressAnimation.value,
                strokeWidth: 6,
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: AthleticTheme.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: AthleticTheme.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildMeasurementRow(String title, String value, String change, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
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
    );
  }

  Widget _buildPRCard(String exercise, String record, String improvement, IconData icon, Color color) {
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
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise,
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  improvement,
                  style: TextStyle(
                    color: AthleticTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            record,
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
}
