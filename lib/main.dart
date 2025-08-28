import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

void main() {
  runApp(const FakeSettingsApp());
}

class FakeSettingsApp extends StatelessWidget {
  const FakeSettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ayarlar",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const SettingsHome(),
    );
  }
}

class SettingsHome extends StatefulWidget {
  const SettingsHome({super.key});

  @override
  State<SettingsHome> createState() => _SettingsHomeState();
}

class _SettingsHomeState extends State<SettingsHome> {
  String searchQuery = "";

  final List<Map<String, dynamic>> settingsItems = [
    {"title": "Wi-Fi", "icon": Icons.wifi, "action": "android.settings.WIFI_SETTINGS"},
    {"title": "Bluetooth", "icon": Icons.bluetooth, "action": "android.settings.BLUETOOTH_SETTINGS"},
    {"title": "Mobil Veri", "icon": Icons.network_cell, "action": "android.settings.DATA_ROAMING_SETTINGS"},
    {"title": "Ekran", "icon": Icons.display_settings, "action": "android.settings.DISPLAY_SETTINGS"},
    {"title": "Ses", "icon": Icons.volume_up, "action": "android.settings.SOUND_SETTINGS"},
    {"title": "Bildirimler", "icon": Icons.notifications, "action": "android.settings.NOTIFICATION_SETTINGS"},
    {"title": "Pil", "icon": Icons.battery_full, "action": "android.settings.BATTERY_SAVER_SETTINGS"},
    {"title": "Uygulamalar", "icon": Icons.apps, "action": "android.settings.APPLICATION_SETTINGS"},
    {"title": "Depolama", "icon": Icons.sd_storage, "action": "android.settings.INTERNAL_STORAGE_SETTINGS"},
    {"title": "Güvenlik", "icon": Icons.lock, "action": "android.settings.SECURITY_SETTINGS"},
    {"title": "Gizlilik", "icon": Icons.privacy_tip, "action": "android.settings.PRIVACY_SETTINGS"},
    {"title": "Hesaplar", "icon": Icons.person, "action": "android.settings.SYNC_SETTINGS"},
    {"title": "Dil ve Giriş", "icon": Icons.language, "action": "android.settings.LOCALE_SETTINGS"},
    {"title": "Yedekleme", "icon": Icons.backup, "action": "android.settings.BACKUP_AND_RESET_SETTINGS"},
    {"title": "Telefon Hakkında", "icon": Icons.info, "custom": true},
  ];

  void openSystemSettings(String action) {
    final intent = AndroidIntent(
      action: action,
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = settingsItems
        .where((item) =>
            item["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Ayarları ara...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  searchQuery = val;
                });
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(item["icon"], color: Colors.blue),
                ),
                title: Text(
                  item["title"],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  if (item.containsKey("custom")) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhoneInfoScreen()),
                    );
                  } else {
                    openSystemSettings(item["action"]);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class PhoneInfoScreen extends StatelessWidget {
  const PhoneInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Telefon Hakkında")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoTile("Cihaz Adı", "TECNO SPARK GO 2024"),
            infoTile("Model", "BG6"),
            infoTile("Android Sürümü", "16 (HiOS 16)"),
            infoTile("Güvenlik Yaması", "5 Ağustos 2025"),
          ],
        ),
      ),
    );
  }

  Widget infoTile(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
      ),
    );
  }
}
