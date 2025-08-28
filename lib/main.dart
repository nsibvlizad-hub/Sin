import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

void main() => runApp(SettingsClone());

class SettingsClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Settings',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Color(0xFFF6F6F6),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: SettingsHome(),
    );
  }
}

class SettingsHome extends StatelessWidget {
  final List<Map<String, dynamic>> settings = [
    {"icon": LucideIcons.wifi, "title": "Connections", "subtitle": "Wi-Fi • Mobile network • Hotspot"},
    {"icon": LucideIcons.bluetooth, "title": "Connected devices", "subtitle": "Bluetooth • Pairing"},
    {"icon": LucideIcons.volume2, "title": "Sound and vibration", "subtitle": "Volume • Haptics • Ringtone"},
    {"icon": LucideIcons.bell, "title": "Notifications", "subtitle": "Status bar • Do not disturb"},
    {"icon": LucideIcons.monitor, "title": "Display", "subtitle": "Brightness • Dark mode • Font size"},
    {"icon": LucideIcons.battery, "title": "Battery", "subtitle": "Power saving • Charging"},
    {"icon": LucideIcons.image, "title": "Wallpaper and style", "subtitle": "Wallpapers • Colour palette"},
    {"icon": LucideIcons.layoutGrid, "title": "Home screen", "subtitle": "Layout • Icon badges"},
    {"icon": LucideIcons.shield, "title": "Security", "subtitle": "Screen lock • Find my device"},
    {"icon": LucideIcons.lock, "title": "Privacy", "subtitle": "Permissions • Ads • Personal data"},
    {"icon": LucideIcons.mapPin, "title": "Location", "subtitle": "GPS • App location requests"},
    {"icon": LucideIcons.user, "title": "Accounts and backup", "subtitle": "Manage accounts • Data sync"},
    {"icon": LucideIcons.settings, "title": "Advanced features", "subtitle": "Labs • Tools"},
    {"icon": LucideIcons.activity, "title": "Digital wellbeing", "subtitle": "Screen time • App timers"},
    {"icon": LucideIcons.hardDrive, "title": "Device care", "subtitle": "Storage • Memory • Security"},
    {"icon": LucideIcons.appWindow, "title": "Apps", "subtitle": "Default apps • App settings"},
    {"icon": LucideIcons.globe, "title": "General management", "subtitle": "Language • Date and time"},
    {"icon": LucideIcons.accessibility, "title": "Accessibility", "subtitle": "Display • Interaction • Audio"},
    {"icon": LucideIcons.info, "title": "About phone", "subtitle": "Status • Legal information • Phone name"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔍 Arama Çubuğu
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search settings",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // 📋 Ayarlar Listesi
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(12),
                itemCount: settings.length,
                separatorBuilder: (_, __) => SizedBox(height: 8),
                itemBuilder: (context, index) {
                  var item = settings[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 1,
                    child: ListTile(
                      leading: Icon(item['icon'], color: Colors.blue, size: 28),
                      title: Text(item['title'], style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(item['subtitle']),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FakeCategoryPage(title: item['title']),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FakeCategoryPage extends StatelessWidget {
  final String title;
  FakeCategoryPage({required this.title});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> content = [];

    switch (title) {
      case "Connections":
        content = [
          {"title": "Wi-Fi", "subtitle": "Off"},
          {"title": "Mobile networks", "subtitle": "4G"},
          {"title": "Hotspot & Tethering", "subtitle": "Off"},
          {"title": "Airplane mode", "subtitle": "Off"},
        ];
        break;
      case "Display":
        content = [
          {"title": "Brightness", "subtitle": "50%"},
          {"title": "Dark mode", "subtitle": "Enabled"},
          {"title": "Font size", "subtitle": "Medium"},
        ];
        break;
      case "Battery":
        content = [
          {"title": "Battery usage", "subtitle": "12h 30m left"},
          {"title": "Power saving mode", "subtitle": "Off"},
          {"title": "Charging", "subtitle": "Fast charging"},
        ];
        break;
      case "Device care":
        content = [
          {"title": "Storage", "subtitle": "64 GB used of 128 GB"},
          {"title": "Memory", "subtitle": "3.2 GB used of 8 GB"},
          {"title": "Security", "subtitle": "No threats found"},
        ];
        break;
      case "About phone":
        content = [
          {"title": "Model name", "subtitle": "Galaxy S25 Ultra"},
          {"title": "Android version", "subtitle": "16"},
          {"title": "One UI version", "subtitle": "8.0"},
          {"title": "Knox version", "subtitle": "4.2"},
          {"title": "Build number", "subtitle": "QPR1.250822.001"},
          {"title": "Baseband version", "subtitle": "S25UXXU1AVH7"},
          {"title": "Kernel version", "subtitle": "5.15.0-android16"},
        ];
        break;
      default:
        content = [
          {"title": "Option 1", "subtitle": "Fake setting"},
          {"title": "Option 2", "subtitle": "Fake setting"},
        ];
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: content.length,
        separatorBuilder: (_, __) => SizedBox(height: 8),
        itemBuilder: (context, index) {
          var e = content[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 1,
            child: ListTile(
              title: Text(e['title']!),
              subtitle: Text(e['subtitle']!),
            ),
          );
        },
      ),
    );
  }
}
