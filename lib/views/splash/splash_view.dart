import 'package:flutter/material.dart';
import 'styles/splash_styles.dart';
import '../../routes/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: SplashStyles.animationDuration,
      vsync: this,
    );

    _scaleAnimation = SplashStyles.createScaleAnimation(_controller);
    _opacityAnimation = SplashStyles.createOpacityAnimation(_controller);
    _slideAnimation = SplashStyles.createSlideAnimation(_controller);

    _controller.forward().whenComplete(() async {
      await Future.delayed(SplashStyles.delayDuration);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteNames.login);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6D05E8),
              Color(0xFFC012FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stack que combina la imagen y el icono encima
            FadeTransition(
              opacity: _opacityAnimation,
              child: SizedBox(
                height: screenHeight * 0.4,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    // Ícono circular encima
                    SlideTransition(
                      position: _slideAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                            border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.terrain,
                              size: 100,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.purpleAccent,
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Texto de bienvenida
            FadeTransition(
              opacity: _opacityAnimation,
              child: Column(
                children: [
                  Text(
                    'Bienvenido',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
