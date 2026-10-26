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
      title: 'البكالوريا السورية العلمية',
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
        ),
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardView(),
    SubjectsView(),
    SchedulesView(),
    QuizView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تطبيق البكالوريا السورية - العلمي',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'حول التطبيق',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'المواد',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'الجداول',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: 'اختبارات',
          ),
        ],
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              children: [
                Icon(Icons.school, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'أهلاً بك يا بطل البكالوريا!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'تطبيق تعليمي مجاني يعمل بدون إنترنت لدعم طلاب الفرع العلمي في سوريا.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'الأقسام السريعة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildFeatureCard(
                context,
                title: 'منهاج العلمي',
                subtitle: 'شروحات وملخصات المواد',
                icon: Icons.auto_stories,
                color: Colors.orange.shade700,
                onTap: () {},
              ),
              _buildFeatureCard(
                context,
                title: 'جداول الدراسة',
                subtitle: 'خريطة تنظيم الوقت',
                icon: Icons.access_time_filled,
                color: Colors.green.shade700,
                onTap: () {},
              ),
              _buildFeatureCard(
                context,
                title: 'اختبارات سريعة',
                subtitle: 'تثبيت ومراجعة الأفكار',
                icon: Icons.assignment_turned_in,
                color: Colors.purple.shade700,
                onTap: () {},
              ),
              _buildFeatureCard(
                context,
                title: 'المطور والداعم',
                subtitle: 'إهداء من أب عُدي',
                icon: Icons.favorite,
                color: Colors.red.shade600,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                radius: 26,
                child: Icon(icon, color: color, size: 30),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectsView extends StatelessWidget {
  const SubjectsView({super.key});

  final List<Map<String, dynamic>> subjects = const [
    {'name': 'الرياضيات', 'detail': 'التحليل، الهندسة، المتتاليات، والاحتمالات', 'icon': Icons.calculate, 'color': Colors.blue},
    {'name': 'الفيزياء', 'detail': 'النواس، الحركة الدائرية، والكهرباء', 'icon': Icons.bolt, 'color': Colors.deepOrange},
    {'name': 'الكيمياء', 'detail': 'النووية، الحركية، التوازن، والحموض', 'icon': Icons.science, 'color': Colors.teal},
    {'name': 'العلوم العامة', 'detail': 'التنسيق عصبي، المستقبلات، والتكاثر', 'icon': Icons.biotech, 'color': Colors.green},
    {'name': 'اللغة العربية', 'detail': 'القواعد، الإعراب، والنصوص الشعريّة', 'icon': Icons.menu_book, 'color': Colors.amber},
    {'name': 'اللغة الإنكليزية', 'detail': 'القواعد الأساسية، النصوص والمفردات', 'icon': Icons.language, 'color': Colors.indigo},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final item = subjects[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: item['color'].withOpacity(0.2),
              child: Icon(item['icon'], color: item['color']),
            ),
            title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['detail']),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('مادة ${item['name']} (تعمل أوفلاين)'), duration: const Duration(seconds: 1)),
              );
            },
          ),
        );
      },
    );
  }
}

class SchedulesView extends StatelessWidget {
  const SchedulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('خطة الدراسة التكتيكية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('توزيع روتيني متوازن لمراجعة المواد العلمية.', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildScheduleItem('السبت والأحد', 'تركيز كامل على الرياضيات والفيزياء.'),
        _buildScheduleItem('الإثنين والثلاثاء', 'علوم أحياء + كيمياء حركية وتوازن.'),
        _buildScheduleItem('الأربعاء والخميس', 'اللغة العربية واللغات الأجنبية.'),
        _buildScheduleItem('الجمعة', 'مراجعة عامة شاملة واستراحة.'),
      ],
    );
  }

  Widget _buildScheduleItem(String days, String task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline, color: Colors.blue),
        title: Text(days, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(task),
      ),
    );
  }
}

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.quiz, size: 70, color: Color(0xFF1E88E5)),
          const SizedBox(height: 16),
          const Text('اختبارات تثبيت المعلومات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('بنك أسئلة تفاعلي يعمل بدون إنترنت للتدرب على النماذج الامتحانية.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('بدء بنك الأسئلة...')));
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('ابدأ الاختبار الآن'),
          ),
        ],
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عن التطبيق والمطور'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 45, backgroundColor: Color(0xFF1976D2), child: Icon(Icons.person, size: 50, color: Colors.white)),
            const SizedBox(height: 16),
            const Text('إشراف وتطوير: أب عُدي', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('مشروع تعليمي خيري مفتوح المصدر', style: TextStyle(color: Colors.grey, fontSize: 14)),
            const Divider(height: 40),
            const ListTile(leading: Icon(Icons.check_circle, color: Colors.green), title: Text('يعمل 100% بدون إنترنت')),
            const ListTile(leading: Icon(Icons.stars, color: Colors.amber), title: Text('مخصص لطلاب البكالوريا السورية العلمية')),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('العودة للتطبيق')),
          ],
        ),
      ),
    );
  }
}
