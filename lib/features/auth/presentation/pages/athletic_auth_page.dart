import 'package:flutter/material.dart';
import '../../../../shared/theme/athletic_theme.dart';
import '../widgets/athletic_button.dart';
import '../widgets/athletic_text_field.dart';

class AthleticAuthPage extends StatefulWidget {
  const AthleticAuthPage({super.key});

  @override
  State<AthleticAuthPage> createState() => _AthleticAuthPageState();
}

class _AthleticAuthPageState extends State<AthleticAuthPage> with TickerProviderStateMixin {
  bool isLogin = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AthleticTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AthleticTheme.primary.withOpacity(0.1),
                  AthleticTheme.background,
                  Colors.black,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(flex: 1),
                  
                  // Logo and Title
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AthleticTheme.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: AthleticTheme.primary,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            Icons.psychology,
                            size: 60,
                            color: AthleticTheme.primary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'ATHLETE AI',
                          style: TextStyle(
                            color: AthleticTheme.textPrimary,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Unlock Your Potential',
                          style: TextStyle(
                            color: AthleticTheme.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const Spacer(flex: 2),
                  
                  // Auth Toggle
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AthleticTheme.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isLogin = true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    color: isLogin ? AthleticTheme.primary : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'LOGIN',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isLogin ? Colors.black : AthleticTheme.textSecondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isLogin = false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    color: !isLogin ? AthleticTheme.primary : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'SIGN UP',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: !isLogin ? Colors.black : AthleticTheme.textSecondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Form Fields
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          if (!isLogin)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AthleticTextField(
                                controller: _nameController,
                                hintText: 'Full Name',
                                prefixIcon: Icons.person_outline,
                              ),
                            ),
                          
                          AthleticTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          AthleticTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                          ),
                          
                          const SizedBox(height: 24),
                          
                          AthleticButton(
                            text: isLogin ? 'LOGIN' : 'CREATE ACCOUNT',
                            onPressed: () {
                              // TODO: Implement authentication logic
                              Navigator.of(context).pop();
                            },
                            isFullWidth: true,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          if (isLogin)
                            TextButton(
                              onPressed: () {
                                // TODO: Implement forgot password
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: AthleticTheme.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  const Spacer(flex: 1),
                  
                  // Social Login
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(child: Divider(color: Colors.grey)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    color: AthleticTheme.textSecondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Expanded(child: Divider(color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          
                          Row(
                            children: [
                              Expanded(
                                child: _buildSocialButton(
                                  icon: Icons.g_mobiledata,
                                  label: 'Google',
                                  onPressed: () {
                                    // TODO: Implement Google Sign-In
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildSocialButton(
                                  icon: Icons.facebook,
                                  label: 'Facebook',
                                  onPressed: () {
                                    // TODO: Implement Facebook Sign-In
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: AthleticTheme.textSecondary.withOpacity(0.3)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AthleticTheme.textSecondary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: AthleticTheme.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
