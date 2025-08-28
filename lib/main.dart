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
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> settings = [
    {"title": "HiCloud", "intent": AndroidIntent(action: 'android.settings.SETTINGS')},
    {"title": "Telefonum", "fake": true},
    {"title": "SIM ve Ağ Ayarları", "intent": AndroidIntent(action: 'android.settings.DATA_ROAMING_SETTINGS')},
    {"title": "Wi-Fi", "intent": AndroidIntent(action: 'android.settings.WIFI_SETTINGS')},
    {"title": "Bluetooth", "intent": AndroidIntent(action: 'android.settings.BLUETOOTH_SETTINGS')},
    {"title": "Erişim Noktası ve İnternet Paylaşımı", "intent": AndroidIntent(action: 'android.settings.TETHER_SETTINGS')},
    {"title": "Daha Fazla Bağlantı", "intent": AndroidIntent(action: 'android.settings.AIRPLANE_MODE_SETTINGS')},
    {"title": "Kişiselleştirme", "intent": AndroidIntent(action: 'android.settings.HOME_SETTINGS')},
    {"title": "Ekran ve Parlaklık", "intent": AndroidIntent(action: 'android.settings.DISPLAY_SETTINGS')},
    {"title": "Ses ve Titreşim", "intent": AndroidIntent(action: 'android.settings.SOUND_SETTINGS')},
    {"title": "Bildirim Paneli", "intent": AndroidIntent(action: 'android.settings.NOTIFICATION_SETTINGS')},
    {"title": "Parola ve Güvenlik", "intent": AndroidIntent(action: 'android.settings.SECURITY_SETTINGS')},
    {"title": "Gizlilik", "intent": AndroidIntent(action: 'android.settings.PRIVACY_SETTINGS')},
    {"title": "Depolama", "intent": AndroidIntent(action: 'android.settings.INTERNAL_STORAGE_SETTINGS')},
    {"title": "Uygulama Yönetimi", "intent": AndroidIntent(action: 'android.settings.MANAGE_APPLICATIONS_SETTINGS')},
    {"title": "Konum", "intent": AndroidIntent(action: 'android.settings.LOCATION_SOURCE_SETTINGS')},
    {"title": "Batarya Labaratuvarı", "intent": AndroidIntent(action: 'android.settings.BATTERY_SAVER_SETTINGS')},
    {"title": "Dijital Denge ve Ebeveyn Denetimleri", "intent": AndroidIntent(action: 'android.settings.DIGITAL_WELLBEING_SETTINGS')},
    {"title": "Ekstra Özellikler", "intent": AndroidIntent(action: 'android.settings.ACCESSIBILITY_SETTINGS')},
    {"title": "Kullanıcılar ve Hesaplar", "intent": AndroidIntent(action: 'android.settings.SYNC_SETTINGS')},
    {"title": "Güvenlik ve Acil Durum", "intent": AndroidIntent(action: 'android.settings.ALL_APPS_SETTINGS')},
    {"title": "Google", "intent": AndroidIntent(action: 'android.settings.APPLICATION_DETAILS_SETTINGS', data: "package:com.google.android.gms")},
    {"title": "Sistem", "intent": AndroidIntent(action: 'android.settings.SETTINGS')},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ayarlar")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Ayarları ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: settings.length,
              itemBuilder: (context, index) {
                final item = settings[index];
                if (_searchController.text.isNotEmpty &&
                    !item["title"].toString().toLowerCase().contains(_searchController.text.toLowerCase())) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Text(item["title"]),
                      onTap: () {
                        if (item.containsKey("fake") && item["fake"] == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PhoneInfoPage()),
                          );
                        } else if (item["intent"] != null) {
                          item["intent"].launch();
                        }
                      },
                    ),
                  ),
                );
              },
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
      body: ListView(
        children: const [
          ListTile(title: Text("Android Sürümü"), subtitle: Text("16")),
          ListTile(title: Text("HiOS Sürümü"), subtitle: Text("HiOS 16")),
          ListTile(title: Text("Model"), subtitle: Text("TECNO Spark Go 2024")),
          ListTile(title: Text("RAM"), subtitle: Text("4 GB")),
          ListTile(title: Text("Dahili Depolama"), subtitle: Text("128 GB")),
          ListTile(title: Text("Knox"), subtitle: Text("Aktif")),
          ListTile(title: Text("Yapım Numarası"), subtitle: Text("QP1A.190711.020")),
          ListTile(title: Text("Android Güvenlik Yaması"), subtitle: Text("1 Ağustos 2025")),
          ListTile(title: Text("Çekirdek Sürümü"), subtitle: Text("5.10.149-g3f8a0a1-dirty (gcc 9.3.0)")),
          ListTile(title: Text("Baseband Sürümü"), subtitle: Text("MOLY.LR12A.R3.MP.V110.2.P21")),
          ListTile(title: Text("CPU"), subtitle: Text("MediaTek Helio A22 (Quad-core 2.0 GHz)")),
          ListTile(title: Text("IMEI (Slot 1)"), subtitle: Text("356789123456789")),
          ListTile(title: Text("IMEI (Slot 2)"), subtitle: Text("356789123456780")),
        ],
      ),
    );
  }
}
