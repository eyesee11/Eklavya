import 'package:flutter/material.dart';
import '../../shared/theme/athletic_theme.dart';
import '../home/presentation/pages/athletic_home_page.dart';
import '../training/presentation/pages/training_page.dart';
import '../ai_analysis/presentation/pages/ai_assessment_page.dart';
import '../progress/presentation/pages/progress_page.dart';
import '../profile/presentation/pages/profile_page_gamified.dart';

class MainNavigationContainer extends StatefulWidget {
  const MainNavigationContainer({super.key});

  @override
  State<MainNavigationContainer> createState() => _MainNavigationContainerState();
}

class _MainNavigationContainerState extends State<MainNavigationContainer> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = [
    const AthleticHomePage(showBottomNav: false), // Pass parameter to hide bottom nav
    const TrainingPage(),
    const AIAssessmentPage(),
    const ProgressPage(),
    const ProfilePage(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_filled,
      label: 'Home',
    ),
    NavigationItem(
      icon: Icons.fitness_center,
      label: 'Train',
    ),
    NavigationItem(
      icon: Icons.psychology,
      label: 'AI Assess',
    ),
    NavigationItem(
      icon: Icons.bar_chart,
      label: 'Progress',
    ),
    NavigationItem(
      icon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AthleticTheme.background,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages, // Show all 5 pages including profile
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
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
            children: _navigationItems.asMap().entries.map((entry) {
              int index = entry.key;
              NavigationItem item = entry.value;
              
              return _buildNavItem(
                item.icon,
                item.label,
                index,
                _currentIndex == index,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AthleticTheme.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                color: isSelected ? AthleticTheme.primary : AthleticTheme.textSecondary,
                size: isSelected ? 26 : 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: isSelected ? AthleticTheme.primary : AthleticTheme.textSecondary,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.label,
  });
}
