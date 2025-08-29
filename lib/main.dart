import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayarlar',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void openSystemSetting(String action) {
    final intent = AndroidIntent(
      action: action,
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    final List<List<Map<String, dynamic>>> groups = [
      // Grup 1 (2 kategori)
      [
        {'title': 'HiCloud', 'action': 'android.settings.CLOUD_SETTINGS'},
        {'title': 'Telefonum', 'page': const TelefonumPage()},
      ],

      // Grup 2 (5 kategori)
      [
        {'title': 'SIM ve Ağ Ayarları', 'action': 'android.settings.NETWORK_OPERATOR_SETTINGS'},
        {'title': 'Wi-Fi', 'action': 'android.settings.WIFI_SETTINGS'},
        {'title': 'Bluetooth', 'action': 'android.settings.BLUETOOTH_SETTINGS'},
        {'title': 'Erişim Noktası ve Paylaşım', 'action': 'android.settings.TETHER_SETTINGS'},
        {'title': 'Daha Fazla Bağlantı', 'action': 'android.settings.AIRPLANE_MODE_SETTINGS'},
      ],

      // Grup 3 (4 kategori)
      [
        {'title': 'Kişiselleştirme', 'action': 'android.settings.HOME_SETTINGS'},
        {'title': 'Ekran ve Parlaklık', 'action': 'android.settings.DISPLAY_SETTINGS'},
        {'title': 'Ses ve Titreşim', 'action': 'android.settings.SOUND_SETTINGS'},
        {'title': 'Bildirim Paneli', 'action': 'android.settings.NOTIFICATION_SETTINGS'},
      ],

      // Grup 4 (5 kategori)
      [
        {'title': 'Parola ve Güvenlik', 'action': 'android.settings.SECURITY_SETTINGS'},
        {'title': 'Gizlilik', 'action': 'android.settings.PRIVACY_SETTINGS'},
        {'title': 'Depolama', 'action': 'android.settings.INTERNAL_STORAGE_SETTINGS'},
        {'title': 'Uygulama Yönetimi', 'action': 'android.settings.MANAGE_APPLICATIONS_SETTINGS'},
        {'title': 'Konum', 'action': 'android.settings.LOCATION_SOURCE_SETTINGS'},
      ],

      // Grup 5 (3 kategori)
      [
        {'title': 'Batarya Laboratuvarı', 'action': 'android.settings.BATTERY_SAVER_SETTINGS'},
        {'title': 'Dijital Denge ve Ebeveyn', 'action': 'android.settings.DIGITAL_DEVICE_CONTROLS_SETTINGS'},
        {'title': 'Ekstra Özellikler', 'action': 'android.settings.ACCESSIBILITY_SETTINGS'},
      ],

      // Grup 6 (3 kategori)
      [
        {'title': 'Kullanıcılar ve Hesaplar', 'action': 'android.settings.ADD_ACCOUNT_SETTINGS'},
        {'title': 'Güvenlik ve Acil Durum', 'action': 'android.settings.SECURITY_SETTINGS'},
        {'title': 'Google', 'action': 'android.settings.GOOGLE_SETTINGS'},
      ],

      // Grup 7 (1 kategori)
      [
        {'title': 'Sistem', 'action': 'android.settings.SETTINGS'},
      ],
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              "Ayarlar",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Ayarları ara",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, groupIndex) {
                  final group = groups[groupIndex];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Column(
                      children: group.map((item) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Text(item['title']),
                            onTap: () {
                              if (item.containsKey('page')) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => item['page']),
                                );
                              } else {
                                openSystemSetting(item['action']);
                              }
                            },
                          ),
                        );
                      }).toList(),
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

class TelefonumPage extends StatelessWidget {
  const TelefonumPage({super.key});

  final List<Map<String, String>> infos = const [
    {"title": "Android Sürümü", "value": "16"},
    {"title": "HiOS Sürümü", "value": "HiOS 16"},
    {"title": "Model", "value": "TECNO Spark Go 2024"},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Telefonum"),
      ),
      body: ListView.separated(
        itemCount: infos.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = infos[index];
          return ListTile(
            title: Text(item["title"]!),
            trailing: Text(item["value"]!),
          );
        },
      ),
    );
  }
}
