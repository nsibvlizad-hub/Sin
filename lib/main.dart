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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _searchController = TextEditingController();

  // Tüm kategoriler
  final List<List<Map<String, dynamic>>> groupedCategories = [
    [
      {"title": "HiCloud", "icon": Icons.cloud, "action": "android.settings.CLOUD_SETTINGS"},
      {"title": "Telefonum", "icon": Icons.phone_android, "action": "custom_phone"},
    ],
    [
      {"title": "SIM ve Ağ Ayarları", "icon": Icons.sim_card, "action": "android.settings.NETWORK_OPERATOR_SETTINGS"},
      {"title": "Wi-Fi", "icon": Icons.wifi, "action": "android.settings.WIFI_SETTINGS"},
      {"title": "Bluetooth", "icon": Icons.bluetooth, "action": "android.settings.BLUETOOTH_SETTINGS"},
      {"title": "Erişim Noktası ve Paylaşım", "icon": Icons.share, "action": "android.settings.TETHER_SETTINGS"},
      {"title": "Daha Fazla Bağlantı", "icon": Icons.more_horiz, "action": "android.settings.DATA_ROAMING_SETTINGS"},
    ],
    [
      {"title": "Kişiselleştirme", "icon": Icons.palette, "action": "android.settings.HOME_SETTINGS"},
      {"title": "Ekran ve Parlaklık", "icon": Icons.brightness_6, "action": "android.settings.DISPLAY_SETTINGS"},
      {"title": "Ses ve Titreşim", "icon": Icons.volume_up, "action": "android.settings.SOUND_SETTINGS"},
      {"title": "Bildirim Paneli", "icon": Icons.notifications, "action": "android.settings.NOTIFICATION_SETTINGS"},
    ],
    [
      {"title": "Parola ve Güvenlik", "icon": Icons.lock, "action": "android.settings.SECURITY_SETTINGS"},
      {"title": "Gizlilik", "icon": Icons.privacy_tip, "action": "android.settings.PRIVACY_SETTINGS"},
      {"title": "Depolama", "icon": Icons.sd_storage, "action": "android.settings.INTERNAL_STORAGE_SETTINGS"},
      {"title": "Uygulama Yönetimi", "icon": Icons.apps, "action": "android.settings.APPLICATION_SETTINGS"},
      {"title": "Konum", "icon": Icons.location_on, "action": "android.settings.LOCATION_SOURCE_SETTINGS"},
    ],
    [
      {"title": "Batarya Laboratuvarı", "icon": Icons.battery_full, "action": "android.settings.BATTERY_SAVER_SETTINGS"},
      {"title": "Dijital Denge", "icon": Icons.timelapse, "action": "android.settings.DIGITAL_WELLBEING_SETTINGS"},
      {"title": "Ekstra Özellikler", "icon": Icons.extension, "action": "android.settings.MANAGE_DEFAULT_APPS_SETTINGS"},
    ],
    [
      {"title": "Kullanıcılar ve Hesaplar", "icon": Icons.people, "action": "android.settings.SYNC_SETTINGS"},
      {"title": "Güvenlik ve Acil Durum", "icon": Icons.warning, "action": "android.settings.SETTINGS"},
      {"title": "Google", "icon": Icons.g_mobiledata, "action": "android.settings.GOOGLE_SETTINGS"},
    ],
    [
      {"title": "Sistem", "icon": Icons.system_update, "action": "android.settings.SETTINGS"},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              "Ayarlar",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Ayarları ara",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: groupedCategories.length,
                itemBuilder: (context, groupIndex) {
                  final group = groupedCategories[groupIndex]
                      .where((item) => item["title"]
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()))
                      .toList();

                  if (group.isEmpty) return const SizedBox.shrink();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black12,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      children: group.map((item) {
                        return ListTile(
                          leading: Icon(item["icon"], color: Colors.blue),
                          title: Text(item["title"]),
                          onTap: () {
                            if (item["action"] == "custom_phone") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PhoneInfoPage(),
                                ),
                              );
                            } else {
                              final intent = AndroidIntent(
                                action: item["action"],
                              );
                              intent.launch();
                            }
                          },
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

class PhoneInfoPage extends StatefulWidget {
  const PhoneInfoPage({super.key});

  @override
  State<PhoneInfoPage> createState() => _PhoneInfoPageState();
}

class _PhoneInfoPageState extends State<PhoneInfoPage> {
  int _tapCount = 0; // kaç kez tıklandığını sayıyoruz

  void _handleAndroidVersionTap() {
    setState(() {
      _tapCount++;
      if (_tapCount >= 7) {
        _tapCount = 0; // sıfırla
        final intent = AndroidIntent(
          action: "android.intent.action.MAIN",
          package: "com.dede.android_eggs",
        );
        intent.launch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Telefonum")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GestureDetector(
            onTap: _handleAndroidVersionTap,
            child: const InfoTile(title: "Android Sürümü", value: "16"),
          ),
          const InfoTile(title: "HiOS Sürümü", value: "16.0"),
          const InfoTile(title: "Cihaz Modeli", value: "TECNO Spark Go 2024"),
          const InfoTile(title: "RAM", value: "6 GB"),
          const InfoTile(title: "Dahili Depolama", value: "128 GB"),
          const InfoTile(title: "Knox", value: "Aktif"),
          const InfoTile(title: "Yapı Numarası", value: "SPARK_GO_16.0_STABLE"),
          const InfoTile(title: "Güvenlik Yaması", value: "1 Ağustos 2025"),
          const InfoTile(title: "Çekirdek Sürümü", value: "5.15.89"),
          const InfoTile(title: "Baseband", value: "MOLY.LR12.W22"),
          const InfoTile(title: "CPU", value: "Octa-Core 2.0GHz"),
          const InfoTile(title: "IMEI", value: "352345678901234"),
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;
  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
