import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
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

  final Map<String, List<Map<String, dynamic>>> settings = {
    "Bağlantılar": [
      {"title": "Wi-Fi", "icon": Icons.wifi},
      {"title": "Bluetooth", "icon": Icons.bluetooth},
      {"title": "Mobil Veri", "icon": Icons.network_cell},
      {"title": "Uçak Modu", "icon": Icons.airplanemode_active},
    ],
    "Cihaz": [
      {"title": "Ses", "icon": Icons.volume_up},
      {"title": "Ekran", "icon": Icons.phone_android},
      {"title": "Bildirimler", "icon": Icons.notifications},
      {"title": "Pil", "icon": Icons.battery_full},
    ],
    "Kişisel": [
      {"title": "Güvenlik", "icon": Icons.lock},
      {"title": "Konum", "icon": Icons.location_on},
      {"title": "Hesaplar", "icon": Icons.person},
      {"title": "Google", "icon": Icons.android},
    ],
    "Sistem": [
      {"title": "Dil ve Giriş", "icon": Icons.language},
      {"title": "Yedekleme", "icon": Icons.backup},
      {"title": "Geliştirici Seçenekleri", "icon": Icons.developer_mode},
      {"title": "Telefonum", "icon": Icons.phone_iphone, "page": PhoneInfoPage()},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // 🔍 Arama Çubuğu
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Ayarlar içinde ara...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  query = value.toLowerCase();
                });
              },
            ),
          ),
          // 📋 Liste
          Expanded(
            child: ListView(
              children: settings.entries.map((entry) {
                final group = entry.value
                    .where((item) =>
                        item["title"].toLowerCase().contains(query))
                    .toList();

                if (group.isEmpty) return const SizedBox.shrink();

                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: group.map((item) {
                      return ListTile(
                        leading: Icon(item["icon"]),
                        title: Text(item["title"]),
                        onTap: () {
                          if (item["page"] != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => item["page"]),
                            );
                          }
                        },
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

  Widget buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Text(value, style: const TextStyle(fontSize: 15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Telefonum"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          buildInfoTile("RAM", "4 GB"),
          buildInfoTile("Dahili Depolama", "128 GB"),
          buildInfoTile("Knox", "Aktif"),
          buildInfoTile("Yapım Numarası", "QP1A.190711.020"),
          buildInfoTile("Android Güvenlik Yaması", "1 Ağustos 2025"),
          buildInfoTile("Çekirdek Sürümü",
              "5.10.149-g3f8a0a1-dirty (gcc 9.3.0)"),
          buildInfoTile("Baseband Sürümü", "MOLY.LR12A.R3.MP.V110.2.P21"),
          buildInfoTile("CPU", "MediaTek Helio A22 (Quad-core 2.0 GHz)"),
          buildInfoTile("IMEI (Slot 1)", "356789123456789"),
          buildInfoTile("IMEI (Slot 2)", "356789123456780"),
        ],
      ),
    );
  }
}
