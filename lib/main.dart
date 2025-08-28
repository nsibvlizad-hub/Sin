import 'package:flutter/material.dart'; import 'package:android_intent_plus/android_intent.dart';

void main() { runApp(const SettingsApp()); }

class SettingsApp extends StatelessWidget { const SettingsApp({super.key});

@override Widget build(BuildContext context) { return MaterialApp( debugShowCheckedModeBanner: false, title: 'HiOS 16 Settings', theme: ThemeData( primarySwatch: Colors.blue, ), home: const SettingsHome(), ); } }

class SettingsHome extends StatefulWidget { const SettingsHome({super.key});

@override State<SettingsHome> createState() => _SettingsHomeState(); }

class _SettingsHomeState extends State<SettingsHome> { final TextEditingController _searchController = TextEditingController();

void openSystemSettings(String action) { final intent = AndroidIntent(action: action); intent.launch(); }

@override Widget build(BuildContext context) { return Scaffold( appBar: AppBar( title: const Text('Ayarlar'), centerTitle: true, ), body: ListView( children: [ Padding( padding: const EdgeInsets.all(12), child: TextField( controller: _searchController, decoration: InputDecoration( hintText: 'Ayarları Ara', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder( borderRadius: BorderRadius.circular(30), ), ), ), ),

// 1. Grup Profil + Telefonum
      settingsGroup("📱 Profil & Telefon", [
        settingsTile("Profil", () {
          // Sahte profil
        }),
        settingsTile("Telefonum", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PhoneInfoPage()),
          );
        }),
      ]),

      // 2. Grup Bağlantılar
      settingsGroup("🌐 Bağlantılar", [
        settingsTile("SIM ve Ağ Ayarları", () => openSystemSettings('android.settings.NETWORK_OPERATOR_SETTINGS')),
        settingsTile("Wi-Fi", () => openSystemSettings('android.settings.WIFI_SETTINGS')),
        settingsTile("Bluetooth", () => openSystemSettings('android.settings.BLUETOOTH_SETTINGS')),
        settingsTile("Erişim Noktası ve İnternet Paylaşımı", () => openSystemSettings('android.settings.WIRELESS_SETTINGS')),
        settingsTile("Daha Fazla Bağlantı", () => openSystemSettings('android.settings.AIRPLANE_MODE_SETTINGS')),
      ]),

      // 3. Grup Kişiselleştirme
      settingsGroup("🎨 Kişiselleştirme", [
        settingsTile("Kişiselleştirme", () {}),
        settingsTile("Ekran ve Parlaklık", () => openSystemSettings('android.settings.DISPLAY_SETTINGS')),
        settingsTile("Ses ve Titreşim", () => openSystemSettings('android.settings.SOUND_SETTINGS')),
        settingsTile("Bildirim Paneli", () => openSystemSettings('android.settings.NOTIFICATION_SETTINGS')),
      ]),

      // 4. Grup Güvenlik
      settingsGroup("🔒 Güvenlik & Gizlilik", [
        settingsTile("Parola ve Güvenlik", () => openSystemSettings('android.settings.SECURITY_SETTINGS')),
        settingsTile("Gizlilik", () => openSystemSettings('android.settings.PRIVACY_SETTINGS')),
        settingsTile("Depolama", () => openSystemSettings('android.settings.INTERNAL_STORAGE_SETTINGS')),
      ]),

      // 5. Grup Uygulamalar
      settingsGroup("⚙️ Uygulamalar & Konum", [
        settingsTile("Uygulama Yönetimi", () => openSystemSettings('android.settings.APPLICATION_SETTINGS')),
        settingsTile("Konum", () => openSystemSettings('android.settings.LOCATION_SOURCE_SETTINGS')),
      ]),

      // 6. Grup Batarya
      settingsGroup("🔋 Batarya & Dijital Sağlık", [
        settingsTile("Batarya Laboratuvarı", () => openSystemSettings('android.settings.BATTERY_SAVER_SETTINGS')),
        settingsTile("Dijital Denge ve Ebeveyn Denetimleri", () => openSystemSettings('android.settings.DIGITAL_WELLBEING_SETTINGS')),
        settingsTile("Ekstra Özellikler", () {}),
      ]),

      // 7. Grup Hesaplar
      settingsGroup("👥 Hesaplar & Güvenlik", [
        settingsTile("Kullanıcılar ve Hesaplar", () => openSystemSettings('android.settings.ADD_ACCOUNT_SETTINGS')),
        settingsTile("Güvenlik ve Acil Durum", () => openSystemSettings('android.settings.SAFETY_CENTER')),
        settingsTile("Google", () => openSystemSettings('android.settings.GOOGLE_SETTINGS')),
      ]),

      // 8. Grup Sistem
      settingsGroup("⚙️ Sistem", [
        settingsTile("Sistem", () => openSystemSettings('android.settings.SETTINGS')),
      ]),
    ],
  ),
);

}

Widget settingsGroup(String title, List<Widget> children) { return Padding( padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Padding( padding: const EdgeInsets.all(8.0), child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), ), Card( shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), child: Column( children: List.generate(children.length * 2 - 1, (index) { if (index.isEven) { return children[index ~/ 2]; } else { return const Divider(height: 1); } }), ), ) ], ), ); }

Widget settingsTile(String title, VoidCallback onTap) { return ListTile( title: Text(title), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: onTap, ); } }

class PhoneInfoPage extends StatelessWidget { const PhoneInfoPage({super.key});

@override Widget build(BuildContext context) { return Scaffold( appBar: AppBar(title: const Text("Telefonum")), body: Padding( padding: const EdgeInsets.all(16.0), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: const [ Text("Android Sürümü: 16", style: TextStyle(fontSize: 18)), SizedBox(height: 8), Text("HiOS Sürümü: 16", style: TextStyle(fontSize: 18)), SizedBox(height: 8), Text("Model: Tecno Spark Go 2024", style: TextStyle(fontSize: 18)), SizedBox(height: 8), Text("RAM: 4 GB", style: TextStyle(fontSize: 18)), SizedBox(height: 8), Text("Knox: Güvenlik aktif (sahte)", style: TextStyle(fontSize: 18)), ], ), ), ); } }

