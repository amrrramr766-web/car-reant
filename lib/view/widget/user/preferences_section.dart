import 'package:flutter/material.dart';

class PreferencesSection extends StatelessWidget {
  final bool pushNotifications;
  final bool emailOffers;
  final ValueChanged<bool> onPushChanged;
  final ValueChanged<bool> onEmailChanged;

  const PreferencesSection({
    super.key,
    required this.pushNotifications,
    required this.emailOffers,
    required this.onPushChanged,
    required this.onEmailChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          SwitchListTile(
            value: pushNotifications,
            onChanged: onPushChanged,
            title: const Text("Push Notifications"),
            secondary: const Icon(Icons.notifications),
          ),
          const Divider(height: 0),
          SwitchListTile(
            value: emailOffers,
            onChanged: onEmailChanged,
            title: const Text("Email Offers & Updates"),
            secondary: const Icon(Icons.mail),
          ),
        ],
      ),
    );
  }
}
