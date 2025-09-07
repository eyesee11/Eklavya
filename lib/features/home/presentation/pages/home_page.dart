import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

/// Home page - main dashboard for the sports talent assessment app
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const _DashboardTab(),
    const _TestsTab(), 
    const _ProfileTab(),
    const _SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // TODO: Navigate to help
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_outlined),
            activeIcon: Icon(Icons.sports),
            label: 'Tests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UIConstants.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(UIConstants.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Sports Assessment',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: UIConstants.spacingSmall),
                  Text(
                    'Discover your athletic potential with AI-powered assessments',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: UIConstants.spacingMedium),
          
          // Quick Actions
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: UIConstants.spacingSmall),
          
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: UIConstants.spacingMedium,
              mainAxisSpacing: UIConstants.spacingMedium,
              children: [
                _QuickActionCard(
                  icon: Icons.play_circle_outline,
                  title: 'Start Assessment',
                  subtitle: 'Begin a new sports test',
                  onTap: () {
                    // TODO: Navigate to test selection
                  },
                ),
                _QuickActionCard(
                  icon: Icons.history,
                  title: 'View Results',
                  subtitle: 'See your past results',
                  onTap: () {
                    // TODO: Navigate to results
                  },
                ),
                _QuickActionCard(
                  icon: Icons.video_library_outlined,
                  title: 'Practice Videos',
                  subtitle: 'Learn proper techniques',
                  onTap: () {
                    // TODO: Navigate to videos
                  },
                ),
                _QuickActionCard(
                  icon: Icons.leaderboard_outlined,
                  title: 'Leaderboard',
                  subtitle: 'Compare with others',
                  onTap: () {
                    // TODO: Navigate to leaderboard
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(UIConstants.spacingMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: UIConstants.spacingSmall),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: UIConstants.spacingXSmall),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestsTab extends StatelessWidget {
  const _TestsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports, size: 64, color: Colors.grey),
          SizedBox(height: UIConstants.spacingMedium),
          Text('Sports Tests'),
          SizedBox(height: UIConstants.spacingSmall),
          Text('Coming Soon...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 64, color: Colors.grey),
          SizedBox(height: UIConstants.spacingMedium),
          Text('User Profile'),
          SizedBox(height: UIConstants.spacingSmall),
          Text('Coming Soon...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 64, color: Colors.grey),
          SizedBox(height: UIConstants.spacingMedium),
          Text('Settings'),
          SizedBox(height: UIConstants.spacingSmall),
          Text('Coming Soon...', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
