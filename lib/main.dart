import 'package:flutter/material.dart'; import 'package:android_intent_plus/android_intent.dart';

void main() { runApp(const MyApp()); }

class MyApp extends StatelessWidget { const MyApp({super.key});

@override Widget build(BuildContext context) { return MaterialApp( debugShowCheckedModeBanner: false, home: const SettingsHome(), ); } }

class SettingsHome extends StatelessWidget { const SettingsHome({super.key});

@override Widget build(BuildContext context) { return Scaffold( appBar: AppBar( backgroundColor: Colors.white, elevation: 0, title: TextField( decoration: InputDecoration( hintText: "Ayarları ara...", prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.grey.shade200, border: OutlineInputBorder( borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none, ), ), ), ), body: ListView( padding: const EdgeInsets.all(12), children: [ buildGroup([ buildItem(context, "HiCloud", openIntent: 'android.settings.SYNC_SETTINGS'), buildItem(context, "Telefonum", openFake: true), ]),

buildGroup([
        buildItem(context, "SIM ve Ağ Ayarları", openIntent: 'android.settings.DATA_ROAMING_SETTINGS'),
        buildItem(context, "Wi-Fi", openIntent: 'android.settings.WIFI_SETTINGS'),
        buildItem(context, "Bluetooth", openIntent: 'android.settings.BLUETOOTH_SETTINGS'),
        buildItem(context, "Erişim Noktası ve İnternet Paylaşımı", openIntent: 'android.settings.WIRELESS_SETTINGS'),
        buildItem(context, "Daha Fazla Bağlantı", openIntent: 'android.settings.AIRPLANE_MODE_SETTINGS'),
      ]),

      buildGroup([
        buildItem(context, "Kişiselleştirme", openIntent: 'android.settings.HOME_SETTINGS'),
        buildItem(context, "Ekran ve Parlaklık", openIntent: 'android.settings.DISPLAY_SETTINGS'),
        buildItem(context, "Ses ve Titreşim", openIntent: 'android.settings.SOUND_SETTINGS'),
        buildItem(context, "Bildirim Paneli", openIntent: 'android.settings.NOTIFICATION_SETTINGS'),
      ]),

      buildGroup([
        buildItem(context, "Parola ve Güvenlik", openIntent: 'android.settings.SECURITY_SETTINGS'),
        buildItem(context, "Gizlilik", openIntent: 'android.settings.PRIVACY_SETTINGS'),
        buildItem(context, "Depolama", openIntent: 'android.settings.INTERNAL_STORAGE_SETTINGS'),
        buildItem(context, "Uygulama Yönetimi", openIntent: 'android.settings.APPLICATION_SETTINGS'),
        buildItem(context, "Konum", openIntent: 'android.settings.LOCATION_SOURCE_SETTINGS'),
      ]),

      buildGroup([
        buildItem(context, "Batarya Labratüvarı", openIntent: 'android.settings.BATTERY_SAVER_SETTINGS'),
        buildItem(context, "Dijital Denge ve Ebeveyn Denetimleri", openIntent: 'android.settings.DIGITAL_WELLBEING_SETTINGS'),
        buildItem(context, "Ekstra Özellikler", openIntent: 'android.settings.MANAGE_DEFAULT_APPS_SETTINGS'),
      ]),

      buildGroup([
        buildItem(context, "Kullanıcılar ve Hesaplar", openIntent: 'android.settings.SYNC_SETTINGS'),
        buildItem(context, "Güvenlik ve Acil Durum", openIntent: 'android.settings.HARD_KEYBOARD_SETTINGS'),
        buildItem(context, "Google", openIntent: 'android.settings.GOOGLE_SETTINGS'),
      ]),

      buildGroup([
        buildItem(context, "Sistem", openIntent: 'android.settings.SETTINGS'),
      ]),
    ],
  ),
);

}

Widget buildGroup(List<Widget> children) { return Container( margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [ BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)), ], ), child: Column( children: children, ), ); }

Widget buildItem(BuildContext context, String title, {String? openIntent, bool openFake = false}) { return InkWell( onTap: () { if (openFake) { Navigator.push(context, MaterialPageRoute(builder: (_) => const FakePhonePage())); } else if (openIntent != null) { final intent = AndroidIntent(action: openIntent); intent.launch(); } }, child: Container( padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16), decoration: const BoxDecoration( border: Border(bottom: BorderSide(color: Colors.black12)), ), child: Row( children: [ Icon(Icons.settings, color: Colors.blueGrey), const SizedBox(width: 16), Expanded(child: Text(title, style: const TextStyle(fontSize: 16))), const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey), ], ), ), ); } }

class FakePhonePage extends StatelessWidget { const FakePhonePage({super.key});

@override Widget build(BuildContext context) { return Scaffold( appBar: AppBar(title: const Text("Telefonum")), body: ListView( padding: const EdgeInsets.all(16), children: const [ ListTile(title: Text("Android Sürümü"), trailing: Text("16")), ListTile(title: Text("HiOS Sürümü"), trailing: Text("16")), ListTile(title: Text("RAM"), trailing: Text("8 GB")), ListTile(title: Text("Model"), trailing: Text("TECNO Spark Go 2024")), ListTile(title: Text("Knox"), trailing: Text("Aktif")), ListTile(title: Text("Yapım Numarası"), trailing: Text("QP1A.190711.020")), ], ), ); } }

