import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  int _selectedTab = 0;
  final List<String> tabs = ['Global', 'Friends', 'Local'];
  
  // Mock leaderboard data
  final List<LeaderboardEntry> globalLeaderboard = [
    LeaderboardEntry(rank: 1, name: 'Thunder Strike', level: 25, xp: 15420, avatar: '⚡', title: 'Champion'),
    LeaderboardEntry(rank: 2, name: 'Iron Phoenix', level: 24, xp: 14890, avatar: '🔥', title: 'Gladiator'),
    LeaderboardEntry(rank: 3, name: 'Storm Breaker', level: 23, xp: 14260, avatar: '⛈️', title: 'Warrior'),
    LeaderboardEntry(rank: 4, name: 'Shadow Wolf', level: 22, xp: 13780, avatar: '🐺', title: 'Fighter'),
    LeaderboardEntry(rank: 5, name: 'Frost Titan', level: 21, xp: 13240, avatar: '❄️', title: 'Challenger'),
    // Current user
    LeaderboardEntry(rank: 247, name: 'Alex Thunder Johnson', level: 12, xp: 2850, avatar: '👤', title: 'Elite Athlete', isCurrentUser: true),
  ];

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
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.amber, Colors.orange],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.leaderboard,
                color: Colors.black,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Leaderboard',
              style: TextStyle(
                color: AthleticTheme.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh,
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
                // Season Info Banner
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.withOpacity(0.3),
                        Colors.pink.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.purple.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.pink],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.emoji_events,
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
                              'Season 3: Thunder Championship',
                              style: TextStyle(
                                color: AthleticTheme.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Ends in 12 days • Rank #247',
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
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber),
                        ),
                        child: const Text(
                          '1,200 XP',
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Tab Navigation
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AthleticTheme.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: tabs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final tab = entry.value;
                      final isSelected = _selectedTab == index;
                      
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? AthleticTheme.primary 
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tab,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected 
                                    ? Colors.black 
                                    : AthleticTheme.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Top 3 Podium
                _buildPodium(),
                
                const SizedBox(height: 24),
                
                // Leaderboard List
                Expanded(
                  child: _buildLeaderboardList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPodium() {
    final top3 = globalLeaderboard.take(3).toList();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.amber.withOpacity(0.1),
            AthleticTheme.cardBackground,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd Place
          if (top3.length > 1) _buildPodiumPosition(top3[1], 2, 100),
          // 1st Place
          if (top3.isNotEmpty) _buildPodiumPosition(top3[0], 1, 120),
          // 3rd Place
          if (top3.length > 2) _buildPodiumPosition(top3[2], 3, 80),
        ],
      ),
    );
  }

  Widget _buildPodiumPosition(LeaderboardEntry entry, int position, double height) {
    Color color;
    IconData crownIcon;
    
    switch (position) {
      case 1:
        color = Colors.amber;
        crownIcon = Icons.emoji_events;
        break;
      case 2:
        color = Colors.grey[400]!;
        crownIcon = Icons.military_tech;
        break;
      case 3:
        color = Colors.brown[400]!;
        crownIcon = Icons.workspace_premium;
        break;
      default:
        color = Colors.grey;
        crownIcon = Icons.star;
    }

    return Column(
      children: [
        // Crown/Medal
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(
            crownIcon,
            color: color,
            size: position == 1 ? 24 : 20,
          ),
        ),
        const SizedBox(height: 8),
        
        // Avatar
        Container(
          width: position == 1 ? 60 : 50,
          height: position == 1 ? 60 : 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              entry.avatar,
              style: TextStyle(
                fontSize: position == 1 ? 24 : 20,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        
        // Name
        Text(
          entry.name.split(' ').first,
          style: TextStyle(
            color: AthleticTheme.textPrimary,
            fontSize: position == 1 ? 14 : 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        
        // Level & XP
        Text(
          'Lv.${entry.level}',
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '${entry.xp} XP',
          style: TextStyle(
            color: AthleticTheme.textSecondary,
            fontSize: 9,
          ),
        ),
        const SizedBox(height: 8),
        
        // Podium Base
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color.withOpacity(0.3),
                color.withOpacity(0.1),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Center(
            child: Text(
              '#$position',
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardList() {
    // Show ranks 4+ and current user
    final remainingEntries = globalLeaderboard.skip(3).toList();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AthleticTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: remainingEntries.length,
        itemBuilder: (context, index) {
          final entry = remainingEntries[index];
          return _buildLeaderboardItem(entry, index + 4);
        },
      ),
    );
  }

  Widget _buildLeaderboardItem(LeaderboardEntry entry, int displayRank) {
    final isCurrentUser = entry.isCurrentUser;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrentUser 
            ? AthleticTheme.primary.withOpacity(0.1) 
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isCurrentUser 
            ? Border.all(color: AthleticTheme.primary, width: 2)
            : null,
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCurrentUser 
                  ? AthleticTheme.primary.withOpacity(0.2)
                  : Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '#${entry.rank}',
                style: TextStyle(
                  color: isCurrentUser 
                      ? AthleticTheme.primary 
                      : AthleticTheme.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isCurrentUser 
                    ? [AthleticTheme.primary, AthleticTheme.primary.withOpacity(0.7)]
                    : [Colors.grey[700]!, Colors.grey[600]!],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                entry.avatar,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Name and Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: TextStyle(
                    color: AthleticTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    entry.title,
                    style: TextStyle(
                      color: AthleticTheme.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Level and XP
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isCurrentUser 
                      ? AthleticTheme.primary.withOpacity(0.2)
                      : Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Lv.${entry.level}',
                  style: TextStyle(
                    color: isCurrentUser 
                        ? AthleticTheme.primary 
                        : AthleticTheme.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${entry.xp} XP',
                style: TextStyle(
                  color: AthleticTheme.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          
          if (isCurrentUser) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.star,
              color: AthleticTheme.primary,
              size: 20,
            ),
          ],
        ],
      ),
    );
  }
}

class LeaderboardEntry {
  final int rank;
  final String name;
  final int level;
  final int xp;
  final String avatar;
  final String title;
  final bool isCurrentUser;

  LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.level,
    required this.xp,
    required this.avatar,
    required this.title,
    this.isCurrentUser = false,
  });
}
