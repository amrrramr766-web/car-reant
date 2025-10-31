import 'package:car_rent/view/widget/common/title_section.dart';
import 'package:car_rent/view/widget/user/account_section.dart';
import 'package:car_rent/view/widget/user/logout_button.dart';
import 'package:car_rent/view/widget/user/preferences_section.dart';
import 'package:car_rent/view/widget/user/support_section.dart';
import 'package:car_rent/view/widget/user/user_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  bool pushNotifications = true;
  bool emailOffers = false;

  String? userName;
  String? userEmail;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("name");
      userEmail = prefs.getString("email");
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile & Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          UserProfileHeader(
            userName: userName ?? 'Guest User',
            userEmail: userEmail ?? 'guest@example.com',
          ),
          const SizedBox(height: 24),
          const SectionTitle(title: "ACCOUNT"),
          const SizedBox(height: 8),
          const AccountSection(),
          const SizedBox(height: 24),
          const SectionTitle(title: "PREFERENCES"),
          const SizedBox(height: 8),
          PreferencesSection(
            pushNotifications: pushNotifications,
            emailOffers: emailOffers,
            onPushChanged: (val) {
              setState(() => pushNotifications = val);
            },
            onEmailChanged: (val) {
              setState(() => emailOffers = val);
            },
          ),
          const SizedBox(height: 24),
          const SectionTitle(title: "SUPPORT & LEGAL"),
          const SizedBox(height: 8),
          const SupportSection(),
          const SizedBox(height: 24),
          const LogoutButton(),
        ],
      ),
    );
  }
}
