import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

void main() {
  runApp(const SettingsApp());
}

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayarlar',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
  String query = "";

  final Map<String, List<Map<String, dynamic>>> categories = {
    "Kablosuz ve Ağlar": [
      {"title": "Wi-Fi", "intent": "android.settings.WIFI_SETTINGS"},
      {"title": "Bluetooth", "intent": "android.settings.BLUETOOTH_SETTINGS"},
      {"title": "Mobil Ağlar", "intent": "android.settings.DATA_ROAMING_SETTINGS"},
      {"title": "Hotspot", "intent": "android.settings.TETHER_SETTINGS"},
    ],
    "Cihaz Bağlantısı": [
      {"title": "NFC", "intent": "android.settings.NFC_SETTINGS"},
      {"title": "Ekran Yansıtma", "intent": "android.settings.CAST_SETTINGS"},
    ],
    "Kişiselleştirme": [
      {"title": "Duvar Kağıdı", "intent": "android.settings.WALLPAPER_SETTINGS"},
      {"title": "Temalar", "intent": "android.settings.HOME_SETTINGS"},
      {"title": "Kilit Ekranı", "intent": "android.settings.DISPLAY_SETTINGS"},
    ],
    "Uygulamalar": [
      {"title": "Tüm Uygulamalar", "intent": "android.settings.APPLICATION_SETTINGS"},
      {"title": "Varsayılan Uygulamalar", "intent": "android.settings.MANAGE_DEFAULT_APPS_SETTINGS"},
    ],
    "Depolama ve Bellek": [
      {"title": "Depolama", "intent": "android.settings.INTERNAL_STORAGE_SETTINGS"},
      {"title": "Bellek", "intent": "android.settings.MEMORY_CARD_SETTINGS"},
    ],
    "Güvenlik ve Gizlilik": [
      {"title": "Ekran Kilidi", "intent": "android.settings.SECURITY_SETTINGS"},
      {"title": "Konum", "intent": "android.settings.LOCATION_SOURCE_SETTINGS"},
      {"title": "Şifreler", "intent": "android.settings.PRIVACY_SETTINGS"},
    ],
    "Sistem": [
      {"title": "Dil ve Giriş", "intent": "android.settings.INPUT_METHOD_SETTINGS"},
      {"title": "Tarih ve Saat", "intent": "android.settings.DATE_SETTINGS"},
      {"title": "Yedekleme", "intent": "android.settings.BACKUP_AND_RESET_SETTINGS"},
      {"title": "Telefon Hakkında", "about": true},
    ],
  };

  void _openIntent(String action) {
    final intent = AndroidIntent(
      action: action,
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Ara...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  query = val.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: ListView(
        children: categories.entries.map((entry) {
          final groupTitle = entry.key;
          final items = entry.value.where((item) {
            final title = item["title"].toString().toLowerCase();
            return title.contains(query);
          }).toList();

          if (items.isEmpty) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(groupTitle,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(height: 1),
                  ...items.map((item) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(item["title"]),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            if (item["about"] == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AboutPhonePage()),
                              );
                            } else {
                              _openIntent(item["intent"]);
                            }
                          },
                        ),
                        if (item != items.last) const Divider(height: 1),
                      ],
                    );
                  }),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AboutPhonePage extends StatelessWidget {
  const AboutPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final fakeInfo = {
      "Android sürümü": "16",
      "HiOS sürümü": "16",
      "Model": "TECNO Spark Go 2024",
      "RAM": "4 GB",
      "Depolama": "128 GB",
      "İşlemci": "MediaTek Helio A22",
      "Knox sürümü": "3.10",
      "Yapım numarası": "HIOS16.0.0.123 (Fake)",
      "Güvenlik düzeltme eki": "1 Ağustos 2025",
    };

    return Scaffold(
      appBar: AppBar(title: const Text("Telefon Hakkında")),
      body: ListView(
        children: fakeInfo.entries.map((e) {
          return Column(
            children: [
              ListTile(
                title: Text(e.key),
                subtitle: Text(e.value),
              ),
              const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }
}
