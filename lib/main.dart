import 'package:flutter/material.dart';

void main() {
  runApp(const SyrianBaccalaureateApp());
}

class SyrianBaccalaureateApp extends StatelessWidget {
  const SyrianBaccalaureateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق البكالوريا السورية',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تطبيق البكالوريا السورية - الفرع العلمي'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'مرحباً بك يا بطل!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'تطبيقك الخيري المجاني لدعم طلاب البكالوريا العلمية في سوريا - دراسة بدون إنترنت، جداول، وشروحات.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.book),
              label: const Text('المواد الدراسية والمنهاج'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.schedule),
              label: const Text('جداول الدراسة'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.person, color: Colors.blue),
            title: Text('المطور'),
            subtitle: Text('أب عُدي'),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info, color: Colors.blue),
            title: Text('عن التطبيق'),
            subtitle: Text('تطبيق مجاني لخدمة طلاب البكالوريا السورية العلمية'),
          ),
        ],
      ),
    );
  }
}
