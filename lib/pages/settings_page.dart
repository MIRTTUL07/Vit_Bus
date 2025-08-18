import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeChanged;

  SettingsPage({required this.isDarkMode, required this.onDarkModeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: isDarkMode,
            onChanged: onDarkModeChanged,
            secondary: Icon(Icons.dark_mode),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About App'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
