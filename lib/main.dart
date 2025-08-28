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
      debugShowCheckedModeBanner: false,
      title: "Ayarlar",
      theme: ThemeData.dark(),
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
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<Map<String, dynamic>>> groupedSettings = {
    "Bağlantılar": [
      {"title": "SIM ve Ağ", "intent": "android.settings.DATA_ROAMING_SETTINGS", "icon": Icons.sim_card},
      {"title": "Wi-Fi", "intent": "android.settings.WIFI_SETTINGS", "icon": Icons.wifi},
      {"title": "Bluetooth", "intent": "android.settings.BLUETOOTH_SETTINGS", "icon": Icons.bluetooth},
      {"title": "Hotspot", "intent": "android.settings.WIRELESS_SETTINGS", "icon": Icons.share},
    ],
    "Kişiselleştirme": [
      {"title": "Telefonum", "intent": "custom", "icon": Icons.phone_android},
      {"title": "Duvar Kağıdı", "intent": "android.settings.HOME_SETTINGS", "icon": Icons.brush},
      {"title": "Ekran & Parlaklık", "intent": "android.settings.DISPLAY_SETTINGS", "icon": Icons.brightness_6},
      {"title": "Ses & Titreşim", "intent": "android.settings.SOUND_SETTINGS", "icon": Icons.volume_up},
    ],
    "Gizlilik & Güvenlik": [
      {"title": "Bildirimler", "intent": "android.settings.NOTIFICATION_SETTINGS", "icon": Icons.notifications},
      {"title": "Parola & Güvenlik", "intent": "android.settings.SECURITY_SETTINGS", "icon": Icons.lock},
      {"title": "Gizlilik", "intent": "android.settings.PRIVACY_SETTINGS", "icon": Icons.privacy_tip},
      {"title": "Konum", "intent": "android.settings.LOCATION_SOURCE_SETTINGS", "icon": Icons.location_on},
    ],
    "Sistem": [
      {"title": "Depolama", "intent": "android.settings.INTERNAL_STORAGE_SETTINGS", "icon": Icons.sd_storage},
      {"title": "Uygulamalar", "intent": "android.settings.APPLICATION_SETTINGS", "icon": Icons.apps},
      {"title": "Batarya", "intent": "android.settings.BATTERY_SAVER_SETTINGS", "icon": Icons.battery_full},
      {"title": "Google", "intent": "android.settings.GOOGLE_SETTINGS", "icon": Icons.account_circle},
      {"title": "Sistem", "intent": "android.settings.SETTINGS", "icon": Icons.settings},
    ]
  };

  void openIntent(String action) {
    if (action == "custom") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PhoneInfoPage()),
      );
    } else {
      final intent = AndroidIntent(action: action);
      intent.launch();
    }
  }

  @override
  Widget build(BuildContext context) {
    String query = _searchController.text.toLowerCase();

    // Filtreleme
    Map<String, List<Map<String, dynamic>>> filteredGroups = {};
    groupedSettings.forEach((group, items) {
      var filtered = items.where((i) => i["title"].toLowerCase().contains(query)).toList();
      if (filtered.isNotEmpty) {
        filteredGroups[group] = filtered;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Ayarlar"), centerTitle: true),
      body: Column(
        children: [
          // 🔍 Arama Çubuğu
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() {}),
              decoration: InputDecoration(
                hintText: "Ayarları ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),

          // 📌 Gruplar
          Expanded(
            child: ListView(
              children: filteredGroups.entries.map((entry) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20), // 🔵 Oval köşeler
                  ),
                  child: Column(
                    children: entry.value.map((item) {
                      return ListTile(
                        leading: Icon(item["icon"], color: Colors.blueAccent),
                        title: Text(item["title"]),
                        onTap: () => openIntent(item["intent"]),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneInfoPage extends StatelessWidget {
  const PhoneInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Telefonum")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            InfoTile("Cihaz adı", "TECNO SPARK GO 2024"),
            InfoTile("Model", "TECNO BG6"),
            InfoTile("Android versiyonu", "16"),
            InfoTile("CPU", "UMS9230 (T606)"),
            InfoTile("Ön kamera", "8 MP"),
            InfoTile("Arka Kamera", "13 MP Dual"),
            InfoTile("RAM", "4 GB (+2 GB Genişletilebilir)"),
            InfoTile("ROM", "128 GB"),
            InfoTile("Pil", "5000 mAh"),
            InfoTile("Ekran", "720 x 1612"),
            InfoTile("HiOS Sürümü", "HiOS 16.0"),
            InfoTile("Derleme Numarası", "BG6-FAKE-ANDROID16"),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.blueAccent)),
        ],
      ),
    );
  }
}
