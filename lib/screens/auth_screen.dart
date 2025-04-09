import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'home_screen.dart';
import 'package:rentronix/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isGoogleSigningIn = false;

  // Create an instance of AuthService
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _switchAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _showErrorMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF8E24AA),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Handle authentication based on mode
        if (_isLogin) {
          // Login logic
          await _authService.signInWithEmailAndPassword(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );

          // Navigate to home screen after successful login
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
        } else {
          // Signup logic
          await _authService.registerWithEmailAndPassword(
            _emailController.text.trim(),
            _passwordController.text.trim(),
            _nameController.text.trim(),
            _phoneController.text.trim(),
          );

          // Show success snackbar
          _showSuccessMessage('Account created successfully! Please sign in.');

          // Clear form fields
          _nameController.clear();
          _phoneController.clear();
          _emailController.clear();
          _passwordController.clear();

          // Switch to login mode
          setState(() {
            _isLogin = true;
          });
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred, please try again.';

        if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Email already in use.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Please enter a valid email address.';
        } else if (e.code == 'popup-closed-by-user') {
          errorMessage = 'Sign-in popup was closed before completing the process.';
        } else if (e.code == 'network-request-failed') {
          errorMessage = 'Network error. Please check your internet connection.';
        } else if (e.code == 'operation-not-allowed') {
          errorMessage = 'This sign-in method is not enabled. Please contact support.';
        }

        _showErrorMessage(errorMessage);
      } catch (e) {
        _showErrorMessage('An error occurred: ${e.toString()}');
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isGoogleSigningIn = true;
    });

    try {
      // This will handle both web and Android platforms
      final userCredential = await _authService.signInWithGoogle();

      if (userCredential != null && mounted) {
        _showSuccessMessage('Google sign-in successful!');

        // Navigate to home screen after successful login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else if (mounted) {
        // This happens when the user cancels the Google sign-in flow
        _showErrorMessage('Google sign-in was cancelled');
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      String errorMessage = 'Google sign-in failed';

      if (e.code == 'account-exists-with-different-credential') {
        errorMessage = 'An account already exists with the same email address but different sign-in credentials.';
      } else if (e.code == 'popup-blocked') {
        errorMessage = 'The popup was blocked by your browser. Please allow popups for this site.';
      } else if (e.code == 'popup-closed-by-user') {
        errorMessage = 'The sign-in popup was closed before completing the process.';
      } else {
        errorMessage = 'Google sign-in failed: ${e.message}';
      }

      _showErrorMessage(errorMessage);
    } catch (e) {
      if (mounted) {
        _showErrorMessage('Google sign-in failed: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleSigningIn = false;
        });
      }
    }
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      _showErrorMessage('Please enter your email to reset your password');
      return;
    }

    try {
      await _authService.resetPassword(_emailController.text.trim());
      _showSuccessMessage('Password reset email sent. Check your inbox.');
    } catch (e) {
      _showErrorMessage('Failed to send password reset email: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and App Name
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF8E24AA),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.devices,
                      size: 40,
                      color: Color(0xFF8E24AA),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'RENTRONIX',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Rent Electronics',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                // Auth Form
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFF8E24AA),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8E24AA),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _isLogin ? 'SIGN IN' : 'SIGN UP',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        if (!_isLogin) ...[
                          // Name Field (Sign Up only)
                          TextFormField(
                            controller: _nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Full Name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF8E24AA),
                              ),
                              labelText: 'Full Name',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Phone Field (Sign Up only)
                          TextFormField(
                            controller: _phoneController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color(0xFF8E24AA),
                              ),
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              // Simple phone validation
                              if (value.length < 10) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color(0xFF8E24AA),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password Field
                        TextFormField(
                          controller: _passwordController,
                          style: const TextStyle(color: Colors.white),
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFF8E24AA),
                            ),
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF8E24AA),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (!_isLogin && value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        if (_isLogin) ...[
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _resetPassword,
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color(0xFF8E24AA),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],

                        const SizedBox(height: 24),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8E24AA),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                              _isLogin ? 'SIGN IN' : 'SIGN UP',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Toggle between Sign In and Sign Up
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isLogin
                                  ? 'Don\'t have an account?'
                                  : 'Already have an account?',
                              style: const TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: _switchAuthMode,
                              child: Text(
                                _isLogin ? 'SIGN UP' : 'SIGN IN',
                                style: const TextStyle(
                                  color: Color(0xFF8E24AA),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Social Sign-in Options
                const Text(
                  'Or sign in with',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(
                      Icons.g_mobiledata,
                      'Google',
                      _isGoogleSigningIn,
                      _signInWithGoogle,
                    ),
                    const SizedBox(width: 20),
                    _socialButton(
                      Icons.facebook,
                      'Facebook',
                      false,
                          () {
                        // TODO: Implement Facebook sign-in when needed
                        _showErrorMessage('Facebook sign-in not implemented yet');
                      },
                    ),
                  ],
                ),

                // Added platform indicator for debugging
                if (kIsWeb) ...[
                  const SizedBox(height: 20),
                  const Text(
                    'Platform: Web',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ] else ...[
                  const SizedBox(height: 20),
                  const Text(
                    'Platform: Android/iOS',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, String label, bool isLoading, VoidCallback onTap) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF8E24AA),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            isLoading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}