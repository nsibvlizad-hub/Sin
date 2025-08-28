import 'package:flutter/material.dart';

void main() {
  runApp(const FakeSettingsApp());
}

class FakeSettingsApp extends StatelessWidget {
  const FakeSettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ayarlar',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const SettingsHomePage(),
    );
  }
}

class SettingsHomePage extends StatefulWidget {
  const SettingsHomePage({super.key});

  @override
  State<SettingsHomePage> createState() => _SettingsHomePageState();
}

class _SettingsHomePageState extends State<SettingsHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<SettingsCategory> categories = [
    SettingsCategory(
      title: "Bağlantılar",
      icon: Icons.wifi,
      page: const WifiPage(),
    ),
    SettingsCategory(
      title: "Ses ve titreşim",
      icon: Icons.volume_up,
      page: const SoundPage(),
    ),
    SettingsCategory(
      title: "Bildirimler",
      icon: Icons.notifications,
      page: const NotificationPage(),
    ),
    SettingsCategory(
      title: "Ekran",
      icon: Icons.phone_android,
      page: const DisplayPage(),
    ),
    SettingsCategory(
      title: "Duvar kağıdı ve stil",
      icon: Icons.wallpaper,
      page: const WallpaperPage(),
    ),
    SettingsCategory(
      title: "Temalar",
      icon: Icons.color_lens,
      page: const ThemePage(),
    ),
    SettingsCategory(
      title: "Ana ekran",
      icon: Icons.home,
      page: const HomeScreenPage(),
    ),
    SettingsCategory(
      title: "Kilit ekranı",
      icon: Icons.lock,
      page: const LockScreenPage(),
    ),
    SettingsCategory(
      title: "Biyometri ve güvenlik",
      icon: Icons.fingerprint,
      page: const SecurityPage(),
    ),
    SettingsCategory(
      title: "Gizlilik",
      icon: Icons.privacy_tip,
      page: const PrivacyPage(),
    ),
    SettingsCategory(
      title: "Konum",
      icon: Icons.location_on,
      page: const LocationPage(),
    ),
    SettingsCategory(
      title: "Google",
      icon: Icons.account_circle,
      page: const GooglePage(),
    ),
    SettingsCategory(
      title: "Hesaplar ve yedekleme",
      icon: Icons.cloud,
      page: const AccountsPage(),
    ),
    SettingsCategory(
      title: "Gelişmiş özellikler",
      icon: Icons.star,
      page: const AdvancedFeaturesPage(),
    ),
    SettingsCategory(
      title: "Dijital sağlık ve ebeveyn denetimleri",
      icon: Icons.health_and_safety,
      page: const DigitalWellbeingPage(),
    ),
    SettingsCategory(
      title: "Genel yönetim",
      icon: Icons.settings_applications,
      page: const GeneralManagementPage(),
    ),
    SettingsCategory(
      title: "Erişilebilirlik",
      icon: Icons.accessibility,
      page: const AccessibilityPage(),
    ),
    SettingsCategory(
      title: "Yazılım güncelleme",
      icon: Icons.system_update,
      page: const SoftwareUpdatePage(),
    ),
    SettingsCategory(
      title: "Telefon hakkında",
      icon: Icons.info,
      page: const AboutPhonePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCategories = categories
        .where((cat) =>
            cat.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Ara...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredCategories.length,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final cat = filteredCategories[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    leading: Icon(cat.icon, color: Colors.blue),
                    title: Text(cat.title),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => cat.page),
                      );
                    },
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

class SettingsCategory {
  final String title;
  final IconData icon;
  final Widget page;

  SettingsCategory({required this.title, required this.icon, required this.page});
}

/// SAHTE SAYFALAR BAŞLANGIÇ

class WifiPage extends StatefulWidget {
  const WifiPage({super.key});

  @override
  State<WifiPage> createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  bool wifi = true;
  bool bluetooth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bağlantılar")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Wi-Fi"),
            value: wifi,
            onChanged: (val) {
              setState(() {
                wifi = val;
              });
            },
          ),
          SwitchListTile(
            title: const Text("Bluetooth"),
            value: bluetooth,
            onChanged: (val) {
              setState(() {
                bluetooth = val;
              });
            },
          ),
        ],
      ),
    );
  }
}

class SoundPage extends StatelessWidget {
  const SoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    double volume = 50;
    return Scaffold(
      appBar: AppBar(title: const Text("Ses ve titreşim")),
      body: ListView(
        children: [
          ListTile(title: const Text("Zil sesi"), subtitle: const Text("Default")),
          ListTile(title: const Text("Titreşim modu"), subtitle: const Text("Açık")),
        ],
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bildirimler")),
      body: ListView(
        children: const [
          ListTile(title: Text("Uygulama bildirimleri")),
          ListTile(title: Text("Rahatsız etmeyin")),
        ],
      ),
    );
  }
}

class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ekran")),
      body: ListView(
        children: const [
          ListTile(title: Text("Parlaklık")),
          ListTile(title: Text("Karanlık mod")),
        ],
      ),
    );
  }
}

class WallpaperPage extends StatelessWidget {
  const WallpaperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Duvar kağıdı ve stil")),
      body: const Center(child: Text("Sahte duvar kağıdı ayarları")),
    );
  }
}

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Temalar")),
      body: const Center(child: Text("Sahte tema ayarları")),
    );
  }
}

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ana ekran")),
      body: const Center(child: Text("Ana ekran ayarları")),
    );
  }
}

class LockScreenPage extends StatelessWidget {
  const LockScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kilit ekranı")),
      body: const Center(child: Text("Kilit ekranı ayarları")),
    );
  }
}

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biyometri ve güvenlik")),
      body: const Center(child: Text("Parmak izi, yüz tanıma sahte ayarları")),
    );
  }
}

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gizlilik")),
      body: const Center(child: Text("Gizlilik ayarları")),
    );
  }
}

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konum")),
      body: const Center(child: Text("Konum ayarları")),
    );
  }
}

class GooglePage extends StatelessWidget {
  const GooglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google")),
      body: const Center(child: Text("Google servisleri")),
    );
  }
}

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hesaplar ve yedekleme")),
      body: const Center(child: Text("Samsung hesabı, Google hesabı, Yedekleme")),
    );
  }
}

class AdvancedFeaturesPage extends StatelessWidget {
  const AdvancedFeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gelişmiş özellikler")),
      body: const Center(child: Text("Çoklu görev, hareketler")),
    );
  }
}

class DigitalWellbeingPage extends StatelessWidget {
  const DigitalWellbeingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dijital sağlık ve ebeveyn denetimleri")),
      body: const Center(child: Text("Ekran süresi, uygulama sınırları")),
    );
  }
}

class GeneralManagementPage extends StatelessWidget {
  const GeneralManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Genel yönetim")),
      body: const Center(child: Text("Dil ve klavye, sıfırlama")),
    );
  }
}

class AccessibilityPage extends StatelessWidget {
  const AccessibilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Erişilebilirlik")),
      body: const Center(child: Text("Görme, işitme, etkileşim ayarları")),
    );
  }
}

class SoftwareUpdatePage extends StatelessWidget {
  const SoftwareUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yazılım güncelleme")),
      body: const Center(child: Text("Son sürüm: Android 16 / OneUI 8")),
    );
  }
}

class AboutPhonePage extends StatelessWidget {
  const AboutPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Telefon hakkında")),
      body: ListView(
        children: const [
          ListTile(title: Text("Cihaz adı"), subtitle: Text("Galaxy S25 Ultra")),
          ListTile(title: Text("Model numarası"), subtitle: Text("SM-S928B")),
          ListTile(title: Text("Seri numarası"), subtitle: Text("R58M12345YZ")),
          ListTile(title: Text("Android sürümü"), subtitle: Text("16")),
          ListTile(title: Text("OneUI sürümü"), subtitle: Text("8.0")),
          ListTile(title: Text("Knox sürümü"), subtitle: Text("3.10")),
        ],
      ),
    );
  }
}
