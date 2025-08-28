import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ayarlar Klonu',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const SettingsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _openSystemSetting(String action) {
    final intent = AndroidIntent(action: action);
    intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ayarlar")),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // 📌 Grup 1
          _buildCard(context, [
            _buildTile(context, Icons.info, "Telefonum", onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TelefonumPage()),
              );
            }),
            _buildTile(context, Icons.wifi, "Wi-Fi",
                onTap: () => _openSystemSetting("android.settings.WIFI_SETTINGS")),
          ]),
          const SizedBox(height: 12),

          // 📌 Grup 2
          _buildCard(context, [
            _buildTile(context, Icons.bluetooth, "Bluetooth",
                onTap: () => _openSystemSetting("android.settings.BLUETOOTH_SETTINGS")),
            _buildTile(context, Icons.language, "Dil ve Girdi",
                onTap: () => _openSystemSetting("android.settings.LOCALE_SETTINGS")),
            _buildTile(context, Icons.lock, "Güvenlik",
                onTap: () => _openSystemSetting("android.settings.SECURITY_SETTINGS")),
          ]),
          const SizedBox(height: 12),

          // 📌 Grup 3
          _buildCard(context, [
            _buildTile(context, Icons.battery_full, "Pil",
                onTap: () => _openSystemSetting("android.settings.BATTERY_SAVER_SETTINGS")),
            _buildTile(context, Icons.storage, "Depolama",
                onTap: () => _openSystemSetting("android.settings.INTERNAL_STORAGE_SETTINGS")),
          ]),
          const SizedBox(height: 12),

          // 📌 Grup 4
          _buildCard(context, [
            _buildTile(context, Icons.volume_up, "Ses",
                onTap: () => _openSystemSetting("android.settings.SOUND_SETTINGS")),
            _buildTile(context, Icons.display_settings, "Ekran",
                onTap: () => _openSystemSetting("android.settings.DISPLAY_SETTINGS")),
            _buildTile(context, Icons.notifications, "Bildirimler",
                onTap: () => _openSystemSetting("android.settings.NOTIFICATION_SETTINGS")),
          ]),
          const SizedBox(height: 12),

          // 📌 Grup 5
          _buildCard(context, [
            _buildTile(context, Icons.apps, "Uygulamalar",
                onTap: () => _openSystemSetting("android.settings.APPLICATION_SETTINGS")),
            _buildTile(context, Icons.update, "Sistem Güncelleme",
                onTap: () => _openSystemSetting("android.settings.SYSTEM_UPDATE_SETTINGS")),
          ]),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(children: children),
    );
  }

  Widget _buildTile(BuildContext context, IconData icon, String title,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: onTap,
    );
  }
}

class TelefonumPage extends StatelessWidget {
  const TelefonumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bilgiler = [
      {"title": "RAM", "value": "4 GB"},
      {"title": "Dahili Depolama", "value": "128 GB"},
      {"title": "Knox", "value": "Aktif"},
      {"title": "Yapım Numarası", "value": "QP1A.190711.020"},
      {"title": "Android Güvenlik Yaması", "value": "1 Ağustos 2025"},
      {"title": "Çekirdek Sürümü", "value": "5.10.149-g3f8a0a1-dirty (gcc 9.3.0)"},
      {"title": "Baseband Sürümü", "value": "MOLY.LR12A.R3.MP.V110.2.P21"},
      {"title": "CPU", "value": "MediaTek Helio A22 (Quad-core 2.0 GHz)"},
      {"title": "IMEI (Slot 1)", "value": "356789123456789"},
      {"title": "IMEI (Slot 2)", "value": "356789123456780"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Telefonum")),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: bilgiler.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = bilgiler[index];
          return ListTile(
            title: Text(item["title"]!),
            subtitle: Text(item["value"]!),
          );
        },
      ),
    );
  }
}
