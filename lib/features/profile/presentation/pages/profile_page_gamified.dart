import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';
import 'leaderboard_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _xpAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _xpAnimation;
  
  // Game-like stats
  final int currentLevel = 12;
  final int currentXP = 2850;
  final int nextLevelXP = 3200;
  final int leaderboardRank = 247;
  final String playerTitle = "Elite Athlete";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _xpAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _xpAnimation = Tween<double>(
      begin: 0.0,
      end: currentXP / nextLevelXP,
    ).animate(CurvedAnimation(
      parent: _xpAnimationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
    _xpAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _xpAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AthleticTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Header with Profile Info
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AthleticTheme.primary.withOpacity(0.1),
                        AthleticTheme.background,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      // Gamified Profile Picture with Level Badge
                      Stack(
                        children: [
                          // Main Avatar with Glow Effect
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  AthleticTheme.primary,
                                  Colors.amber,
                                  AthleticTheme.primary,
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AthleticTheme.primary.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AthleticTheme.cardBackground,
                              ),
                              child: Icon(
                                Icons.person,
                                size: 70,
                                color: AthleticTheme.primary,
                              ),
                            ),
                          ),
                          // Level Badge
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.amber, Colors.orange],
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AthleticTheme.background,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber.withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'LVL',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$currentLevel',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Rank Badge
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LeaderboardPage()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.purple, Colors.pink],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AthleticTheme.background,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.leaderboard,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '#$leaderboardRank',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Player Name and Title
                      Text(
                        'Alex "Thunder" Johnson',
                        style: TextStyle(
                          color: AthleticTheme.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AthleticTheme.primary.withOpacity(0.3),
                              Colors.amber.withOpacity(0.3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AthleticTheme.primary,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.emoji_events,
                              size: 16,
                              color: AthleticTheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              playerTitle,
                              style: TextStyle(
                                color: AthleticTheme.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // XP Progress Bar
                      _buildXPProgressBar(),
                      
                      const SizedBox(height: 24),
                      
                      // Gamified Stats Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildGameStatColumn('128', 'Battles Won', Icons.fitness_center, Colors.green),
                          _buildGameStatColumn('42', 'Trophies', Icons.emoji_events, Colors.amber),
                          _buildGameStatColumn('15', 'Fire Streak', Icons.local_fire_department, Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Game-like Achievement Showcase
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trophy Collection',
                            style: TextStyle(
                              color: AthleticTheme.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.amber, width: 1),
                            ),
                            child: Text(
                              '42/100',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      SizedBox(
                        height: 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildGameAchievementBadge('🏆', 'Champion\nWarrior', 'Legendary', Colors.yellow, true),
                            _buildGameAchievementBadge('💪', 'Iron\nGiant', 'Epic', Colors.red, true),
                            _buildGameAchievementBadge('🏃‍♂️', 'Lightning\nBolt', 'Rare', Colors.blue, true),
                            _buildGameAchievementBadge('🔥', 'Inferno\nMaster', 'Epic', Colors.orange, true),
                            _buildGameAchievementBadge('⭐', 'Stellar\nLegend', 'Mythic', Colors.purple, true),
                            _buildGameAchievementBadge('🎯', 'Precision\nSniper', 'Common', Colors.grey, false),
                            _buildGameAchievementBadge('🛡️', 'Endurance\nTank', 'Rare', Colors.green, false),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Battle Stats
                      Text(
                        'Battle Statistics',
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
                          border: Border.all(
                            color: AthleticTheme.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildBattleStat('128', 'Victories', Icons.emoji_events, Colors.green),
                                _buildBattleStat('23', 'Defeats', Icons.sentiment_dissatisfied, Colors.red),
                                _buildBattleStat('84.7%', 'Win Rate', Icons.trending_up, Colors.amber),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purple.withOpacity(0.2),
                                    Colors.pink.withOpacity(0.2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Current Win Streak: 15 battles',
                                    style: TextStyle(
                                      color: AthleticTheme.textPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Guild/Team Section
                      Text(
                        'Guild & Friends',
                        style: TextStyle(
                          color: AthleticTheme.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AthleticTheme.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.purple.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.purple, Colors.pink],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.groups,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Thunder Warriors',
                                    style: TextStyle(
                                      color: AthleticTheme.textPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Guild Rank: Captain • 47 members',
                                    style: TextStyle(
                                      color: AthleticTheme.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Active',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Logout Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.withOpacity(0.2),
                            foregroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.red.withOpacity(0.3)),
                            ),
                          ),
                          child: const Text(
                            'Sign Out',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // App Version
                      Center(
                        child: Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            color: AthleticTheme.textSecondary,
                            fontSize: 12,
                          ),
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

  Widget _buildXPProgressBar() {
    return Container(
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Experience Points',
                style: TextStyle(
                  color: AthleticTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$currentXP / $nextLevelXP XP',
                style: TextStyle(
                  color: AthleticTheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(6),
            ),
            child: AnimatedBuilder(
              animation: _xpAnimation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _xpAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.amber,
                          Colors.orange,
                          Colors.red,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.5),
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
          const SizedBox(height: 8),
          Text(
            '${nextLevelXP - currentXP} XP to Level ${currentLevel + 1}',
            style: TextStyle(
              color: AthleticTheme.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameStatColumn(String value, String label, IconData icon, Color color) {
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: AthleticTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AthleticTheme.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBattleStat(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: AthleticTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AthleticTheme.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildGameAchievementBadge(String emoji, String title, String rarity, Color color, bool unlocked) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: unlocked ? AthleticTheme.cardBackground : Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: unlocked ? color : Colors.grey[700]!,
          width: unlocked ? 2 : 1,
        ),
        boxShadow: unlocked ? [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ] : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            emoji,
            style: TextStyle(
              fontSize: 28,
              color: unlocked ? null : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: unlocked ? AthleticTheme.textPrimary : Colors.grey[600],
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: unlocked ? color.withOpacity(0.2) : Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              rarity,
              style: TextStyle(
                color: unlocked ? color : Colors.grey[600],
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
