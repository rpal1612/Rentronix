import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rentronix/screens/change_pass_screen.dart';
import 'package:rentronix/screens/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Rentronix";
  String userEmail = "rentronix@example.com";
  String userPhone = "+1 (555) 123-4567";
  String? avatarPath;
  bool notificationsEnabled = true;
  String currentLanguage = "English";
  int savedPaymentMethods = 2;
  bool isVerified = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      // Load data from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        userName = prefs.getString('userName') ?? "Rentronix";
        userEmail = prefs.getString('userEmail') ?? "rentronix@example.com";
        userPhone = prefs.getString('userPhone') ?? "+1 (555) 123-4567";
        avatarPath = prefs.getString('avatarPath');
        notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
        currentLanguage = prefs.getString('currentLanguage') ?? "English";
        savedPaymentMethods = prefs.getInt('savedPaymentMethods') ?? 2;
        isVerified = prefs.getBool('isVerified') ?? false;
      });
    } catch (e) {
      debugPrint('Error loading user profile: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // Save image to app directory
        final directory = await getApplicationDocumentsDirectory();
        final imageName =
            'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final imagePath = '${directory.path}/$imageName';

        // Copy picked image to app directory
        final File newImage = File(imagePath);
        await newImage.writeAsBytes(await File(image.path).readAsBytes());

        // Save path to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('avatarPath', imagePath);

        setState(() {
          avatarPath = imagePath;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _signOut() async {
    try {
      // Clear all local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Navigate to login screen and remove all previous routes
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login', // Replace with your actual login route name
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error signing out: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _toggleVerification() async {
    try {
      setState(() {
        isVerified = !isVerified;
      });

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isVerified', isVerified);

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isVerified
                ? 'Verification completed!'
                : 'Verification removed.'),
            backgroundColor: isVerified ? Colors.green : Colors.orange,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error toggling verification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF8E24AA), // Purple navbar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // White arrow for visibility
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Profile & Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header with updated image handling
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[800],
                            child: _buildProfileImage(),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF8E24AA),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userPhone,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Profile Management Section
              _buildSectionHeader('Profile Management'),
              _buildSettingItem(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () async {
                  // Navigate to edit profile page
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const EditProfilePage()),
                  );
                  // If profile was updated, refresh the current page
                  if (result == true) {
                    _loadUserProfile();
                  }
                },
              ),
              _buildSettingItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  // Navigate to change password page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordPage()),
                  );
                },
              ),
              const SizedBox(height: 16),

              // App Settings Section
              _buildSectionHeader('App Settings'),
              _buildSettingItem(
                icon: Icons.payment_outlined,
                title: 'Payment Methods',
                subtitle: '$savedPaymentMethods methods saved',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.grey[900],
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => _buildPaymentMethodsSheet(),
                  );
                },
              ),
              _buildToggleItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                value: notificationsEnabled,
                onChanged: (value) async {
                  setState(() {
                    notificationsEnabled = value;
                  });
                  // Update notification settings in SharedPreferences
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('notificationsEnabled', value);
                },
              ),
              _buildSettingItem(
                icon: Icons.language_outlined,
                title: 'Language Preferences',
                subtitle: 'Current: $currentLanguage',
                onTap: () {
                  // Navigate to language settings page
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.grey[900],
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => _buildLanguageSelectionSheet(),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Verification Section
              _buildSectionHeader('Verification'),
              _buildVerificationItem(
                icon: Icons.verified_user_outlined,
                title: 'KYC / ID Verification',
                subtitle: isVerified ? 'Verified' : 'Not verified',
                verified: isVerified,
                onTap: _toggleVerification,
              ),
              const SizedBox(height: 16),

              // Account Section
              _buildSectionHeader('Account'),
              _buildLogoutButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelectionSheet() {
    final languages = [
      'English',
      'Spanish',
      'French',
      'German',
      'Chinese',
      'Arabic',
    ];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Language',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return _buildLanguageItem(languages[index]);
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

// Helper method for language selection item
  Widget _buildLanguageItem(String language) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          language,
          style: TextStyle(
            color: language == currentLanguage
                ? const Color(0xFF8E24AA)
                : Colors.white,
          ),
        ),
        trailing: language == currentLanguage
            ? const Icon(Icons.check, color: Color(0xFF8E24AA))
            : null,
        onTap: () async {
          // Update language in SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('currentLanguage', language);

          setState(() {
            currentLanguage = language;
          });

          Navigator.of(context).pop();
        },
      ),
    );
  }

  // New method to build Payment Methods Bottom Sheet
  Widget _buildPaymentMethodsSheet() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Payment Methods',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildPaymentMethodItem(
            icon: Icons.credit_card,
            title: 'Credit Card',
            subtitle: '**** **** **** 1234',
          ),
          _buildPaymentMethodItem(
            icon: Icons.paypal,
            title: 'PayPal',
            subtitle: 'example@email.com',
          ),
          ElevatedButton(
            onPressed: () {
              // Add new payment method
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add Payment Method coming soon')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8E24AA),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Add New Payment Method'),
          ),
        ],
      ),
    );
  }

// Helper method for payment method item
  Widget _buildPaymentMethodItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8E24AA)),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey[400]),
        ),
        trailing: const Icon(Icons.more_vert, color: Colors.grey),
      ),
    );
  }

  Widget _buildProfileImage() {
    if (avatarPath != null) {
      // Show user-selected image
      return ClipOval(
        child: Image.file(
          File(avatarPath!),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Error loading profile image: $error');
            // If file loading fails, show default avatar
            return Image.asset(
              'assets/images/profile_image.png', // Updated path to match your pubspec.yaml
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to icon if asset also fails
                return const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white70,
                );
              },
            );
          },
        ),
      );
    } else {
      // Show default avatar from assets
      return ClipOval(
        child: Image.asset(
          'assets/images/profile_image.png', // Updated path to match your pubspec.yaml
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Error loading default avatar: $error');
            // Fallback to icon if asset fails
            return const Icon(
              Icons.person,
              size: 60,
              color: Colors.white70,
            );
          },
        ),
      );
    }
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8E24AA),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8E24AA)),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              )
            : null,
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xfffcfafd)),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF8E24AA),
          activeTrackColor: const Color(0xFF8E24AA).withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildVerificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool verified,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF8E24AA)),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
        trailing: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 80,
            height: 32,
            decoration: BoxDecoration(
              color: verified ? const Color(0xFF8E24AA) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF8E24AA),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                verified ? 'Verified' : 'Verify',
                style: TextStyle(
                  color: verified ? Colors.white : const Color(0xFF8E24AA),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text(
          'Log Out',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.grey[900],
                title: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white),
                ),
                content: const Text(
                  'Are you sure you want to log out?',
                  style: TextStyle(color: Colors.white70),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Color(0xFF8E24AA)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Close the dialog first
                      Navigator.of(context).pop();
                      // Then perform sign out
                      _signOut();
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
