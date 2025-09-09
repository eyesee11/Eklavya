import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedCategoryIndex = 0;
  
  final List<String> categories = [
    'All',
    'Strength',
    'Cardio',
    'Flexibility',
    'Sports Specific',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AthleticTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AthleticTheme.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.fitness_center,
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
                          'TRAINING',
                          style: TextStyle(
                            color: AthleticTheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          'Your Workout Hub',
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
                      Icons.search,
                      color: AthleticTheme.textPrimary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            
            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AthleticTheme.cardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AthleticTheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: AthleticTheme.textSecondary,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                tabs: const [
                  Tab(text: 'Workouts'),
                  Tab(text: 'Programs'),
                  Tab(text: 'Challenges'),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildWorkoutsTab(),
                  _buildProgramsTab(),
                  _buildChallengesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategoryIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? AthleticTheme.primary 
                          : AthleticTheme.cardBackground,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      categories[index],
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
          
          const SizedBox(height: 24),
          
          // Featured Workout
          Text(
            'Featured Today',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildFeaturedWorkout(),
          
          const SizedBox(height: 32),
          
          // Quick Workouts
          Text(
            'Quick Workouts',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
              final aspectRatio = constraints.maxWidth > 600 ? 1.0 : 0.9;
              
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: aspectRatio,
                children: [
                  _buildWorkoutCard('HIIT Blast', '20 min', 'High Intensity', Icons.flash_on, Colors.red),
                  _buildWorkoutCard('Core Power', '15 min', 'Core Training', Icons.center_focus_strong, Colors.blue),
                  _buildWorkoutCard('Cardio Burn', '30 min', 'Cardiovascular', Icons.favorite, Colors.pink),
                  _buildWorkoutCard('Flexibility', '25 min', 'Stretching', Icons.self_improvement, Colors.green),
                ],
              );
            },
          ),
          
          const SizedBox(height: 32),
          
          // Popular Workouts
          Text(
            'Popular This Week',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          ...List.generate(3, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildWorkoutListItem(
              'Full Body Strength ${index + 1}',
              '45 min • Intermediate',
              '4.8 ⭐',
              Icons.fitness_center,
              Colors.orange,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildProgramsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Training Programs',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildProgramCard(
            '30-Day Transformation',
            'Complete body transformation program',
            '30 days • All levels',
            Colors.purple,
            0.7,
          ),
          const SizedBox(height: 16),
          
          _buildProgramCard(
            'Marathon Prep',
            'Get ready for your first marathon',
            '16 weeks • Intermediate',
            Colors.blue,
            0.3,
          ),
          const SizedBox(height: 16),
          
          _buildProgramCard(
            'Strength Builder',
            'Build muscle and increase strength',
            '12 weeks • Beginner',
            Colors.red,
            0.5,
          ),
        ],
      ),
    );
  }

  Widget _buildChallengesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Challenges',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildChallengeCard(
            '7-Day Plank Challenge',
            'Hold your plank longer each day',
            'Day 3 of 7',
            Icons.timer,
            Colors.orange,
            0.43,
          ),
          const SizedBox(height: 16),
          
          _buildChallengeCard(
            '1000 Push-ups Challenge',
            'Complete 1000 push-ups this month',
            '340 / 1000',
            Icons.fitness_center,
            Colors.green,
            0.34,
          ),
          const SizedBox(height: 16),
          
          _buildChallengeCard(
            '10K Steps Daily',
            'Walk 10,000 steps every day',
            '5 day streak',
            Icons.directions_walk,
            Colors.blue,
            0.8,
          ),
          
          const SizedBox(height: 32),
          
          Text(
            'Join New Challenge',
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildNewChallengeCard('Burpee Master', 'Complete 500 burpees this week', Icons.sports_gymnastics, Colors.red),
          const SizedBox(height: 12),
          _buildNewChallengeCard('Flexibility Flow', '15 minutes of stretching daily', Icons.self_improvement, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildFeaturedWorkout() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AthleticTheme.primary.withOpacity(0.8),
            AthleticTheme.primary.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'FEATURED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: Text(
                'Ultimate\nFull Body Blast',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width > 400 ? 28 : 24,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                '45 minutes • High Intensity • Equipment Free',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width > 400 ? 14 : 12,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'START WORKOUT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(String title, String duration, String category, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container with fixed size
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            
            // Title with constrained height
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(
                  color: AthleticTheme.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            // Duration
            Text(
              duration,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            
            // Category with constrained height
            Expanded(
              flex: 1,
              child: Text(
                category,
                style: TextStyle(
                  color: AthleticTheme.textSecondary,
                  fontSize: 9,
                  height: 1.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutListItem(String title, String details, String rating, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
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
                Text(
                  details,
                  style: TextStyle(
                    color: AthleticTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            rating,
            style: TextStyle(
              color: AthleticTheme.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramCard(String title, String description, String duration, Color color, double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.fitness_center,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AthleticTheme.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(
                        color: AthleticTheme.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            duration,
            style: TextStyle(
              color: AthleticTheme.textSecondary,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${(progress * 100).round()}% Complete',
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(String title, String description, String progress, IconData icon, Color color, double progressValue) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AthleticTheme.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(
                        color: AthleticTheme.textSecondary,
                        fontSize: 11,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                progress,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewChallengeCard(String title, String description, IconData icon, Color color) {
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
                  title,
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
          TextButton(
            onPressed: () {},
            child: Text(
              'JOIN',
              style: TextStyle(
                color: color,
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
