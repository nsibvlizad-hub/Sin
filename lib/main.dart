import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsHome(),
    );
  }
}

class SettingsHome extends StatelessWidget {
  final List<Map<String, dynamic>> settings = [
    // Grup 1
    {'title': 'HiCloud', 'icon': Icons.cloud, 'intent': 'android.settings.CLOUD_SETTINGS'},
    {'title': 'Telefonum', 'icon': Icons.phone_android, 'fake': true},

    // Grup 2
    {'title': 'SIM ve Ağ Ayarları', 'icon': Icons.sim_card, 'intent': 'android.settings.DATA_ROAMING_SETTINGS'},
    {'title': 'Wi-Fi', 'icon': Icons.wifi, 'intent': 'android.settings.WIFI_SETTINGS'},
    {'title': 'Bluetooth', 'icon': Icons.bluetooth, 'intent': 'android.settings.BLUETOOTH_SETTINGS'},
    {'title': 'Erişim Noktası ve İnternet Paylaşımı', 'icon': Icons.wifi_tethering, 'intent': 'android.settings.TETHER_SETTINGS'},
    {'title': 'Daha Fazla Bağlantı', 'icon': Icons.settings_input_component, 'intent': 'android.settings.AIRPLANE_MODE_SETTINGS'},

    // Grup 3
    {'title': 'Kişiselleştirme', 'icon': Icons.brush, 'intent': 'android.settings.HOME_SETTINGS'},
    {'title': 'Ekran ve Parlaklık', 'icon': Icons.brightness_6, 'intent': 'android.settings.DISPLAY_SETTINGS'},
    {'title': 'Ses ve Titreşim', 'icon': Icons.volume_up, 'intent': 'android.settings.SOUND_SETTINGS'},
    {'title': 'Bildirim Paneli', 'icon': Icons.notifications, 'intent': 'android.settings.NOTIFICATION_SETTINGS'},

    // Grup 4
    {'title': 'Parola ve Güvenlik', 'icon': Icons.lock, 'intent': 'android.settings.SECURITY_SETTINGS'},
    {'title': 'Gizlilik', 'icon': Icons.privacy_tip, 'intent': 'android.settings.PRIVACY_SETTINGS'},
    {'title': 'Depolama', 'icon': Icons.sd_storage, 'intent': 'android.settings.INTERNAL_STORAGE_SETTINGS'},

    // Grup 5
    {'title': 'Uygulama Yönetimi', 'icon': Icons.apps, 'intent': 'android.settings.APPLICATION_SETTINGS'},
    {'title': 'Konum', 'icon': Icons.location_on, 'intent': 'android.settings.LOCATION_SOURCE_SETTINGS'},

    // Grup 6
    {'title': 'Batarya Laboratuvarı', 'icon': Icons.battery_full, 'intent': 'android.settings.BATTERY_SAVER_SETTINGS'},
    {'title': 'Dijital Denge ve Ebeveyn Denetimleri', 'icon': Icons.access_time, 'intent': 'android.settings.DIGITAL_WELLBEING_SETTINGS'},
    {'title': 'Ekstra Özellikler', 'icon': Icons.extension, 'intent': 'android.settings.SETTINGS'},

    // Grup 7
    {'title': 'Kullanıcılar ve Hesaplar', 'icon': Icons.people, 'intent': 'android.settings.USER_SETTINGS'},
    {'title': 'Güvenlik ve Acil Durum', 'icon': Icons.security, 'intent': 'android.settings.EMERGENCY_SETTINGS'},
    {'title': 'Google', 'icon': Icons.g_mobiledata, 'intent': 'com.google.android.gms.settings.ADVANCED_SETTINGS_ACTIVITY'},

    // Grup 8
    {'title': 'Sistem', 'icon': Icons.settings, 'intent': 'android.settings.SETTINGS'},
  ];

  SettingsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: settings.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = settings[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(item['icon'], color: Colors.blue),
              title: Text(item['title']),
              onTap: () {
                if (item.containsKey('fake')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PhoneInfoPage()),
                  );
                } else {
                  LaunchApp.openApp(
                    androidPackageName: "",
                    appStoreLink: "",
                    iosUrlScheme: "",
                    openStore: false,
                    androidIntent: item['intent'],
                  );
                }
              },
            ),
          );
        },
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Android Sürümü: 16", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("HiOS Versiyonu: 16", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Model: TECNO Spark Go 2024", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("RAM: 8 GB", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Knox: 3.9", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
