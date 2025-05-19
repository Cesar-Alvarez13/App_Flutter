import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import '../register/register_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();

  bool _isLoading = false;
  String? _errorMessage;

  bool _canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics = [];

  @override
  void initState() {
    super.initState();
    _checkBiometricsSupport();
  }

  Future<void> _checkBiometricsSupport() async {
    try {
      final canCheck = await auth.canCheckBiometrics;
      final biometrics = await auth.getAvailableBiometrics();
      if (!mounted) return;
      setState(() {
        _canCheckBiometrics = canCheck;
        _availableBiometrics = biometrics;
      });
    } catch (e) {
      // Ignorar error si no se soporta
    }
  }

 Future<void> _login() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      '/template',
      arguments: {
        'email': _emailController.text.trim(),
        'isBiometric': false,
      },
    );
  } on FirebaseAuthException catch (e) {
    setState(() {
      _errorMessage = e.message;
    });
  } catch (e) {
    setState(() {
      _errorMessage = 'Error desconocido';
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  Future<void> _authenticateWithBiometrics() async {
    try {
      final isDeviceSupported = await auth.isDeviceSupported();
      if (!_canCheckBiometrics && !isDeviceSupported) {
        setState(() {
          _errorMessage =
              'Este dispositivo no soporta autenticación biométrica';
        });
        return;
      }

      final didAuthenticate = await auth.authenticate(
        localizedReason: 'Por favor autentícate para ingresar',
        options:
            const AuthenticationOptions(biometricOnly: true, stickyAuth: true),
      );

      if (didAuthenticate) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(
          context,
          '/template',
          arguments: {'email': '', 'isBiometric': true},
        );
      } else {
        setState(() {
          _errorMessage = 'Autenticación biométrica fallida';
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _errorMessage = 'Error en autenticación biométrica: ${e.message}';
      });
    }
  }

  Route _createRouteToRegister() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RegisterScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.05,
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
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (_errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Correo electrónico',
                              prefixIcon: Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu correo';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Ingresa un correo válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu contraseña';
                              }
                              if (value.length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 28),
                          LoginButton(
                            isLoading: _isLoading,
                            onPressed: _login,
                          ),
                          const SizedBox(height: 12),

                          // Mostrar botón biométrico solo si el dispositivo lo soporta
                          if (_canCheckBiometrics &&
                              _availableBiometrics.isNotEmpty)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _isLoading
                                    ? null
                                    : () async {
                                        await _authenticateWithBiometrics();
                                      },
                                icon: const Icon(Icons.fingerprint,
                                    color: Colors.white), // Icono blanco
                                label: Text(
                                  _availableBiometrics
                                          .contains(BiometricType.face)
                                      ? 'Ingresar con Face ID'
                                      : 'Ingresar con biometría',
                                  style: const TextStyle(
                                      color: Colors.white), // Texto blanco
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  backgroundColor: const Color.fromARGB(
                                      255, 96, 7, 179), // Color botón
                                ),
                              ),
                            ),

                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '¿No tienes cuenta? ',
                                style: TextStyle(fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(_createRouteToRegister());
                                },
                                child: const Text(
                                  'Regístrate',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 96, 7, 179),
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: const Color(0xFF6D05E8),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Ingresar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
