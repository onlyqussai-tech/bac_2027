import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    QuizEngineView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'أكاديمية البكالوريا السورية - العلمي',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
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
            label: 'الامتحان',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 1. الواجهة الرئيسية مع تأثيرات 3D Perspective مجسمة
// ---------------------------------------------------------
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // بطاقة رئيسية بتأثير 3D عميق
          Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(0.03)
              ..rotateY(-0.03),
            alignment: FractionalOffset.center,
            child: Container(
              padding: const EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1976D2), Color(0xFF42A5F5)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(Icons.military_tech, size: 55, color: Colors.amberAccent),
                  SizedBox(height: 12),
                  Text(
                    'طريقك نحو التفوق والقبول الجامعي',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'تطبيق ذكي متكامل يعمل بدون إنترنت لإدارة دراسة البكالوريا العلمية بدقة عالية.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'البطاقات التفاعلية ثلاثية الأبعاد',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
            children: [
              _build3DCard(
                context,
                title: 'منهاج العلمي',
                subtitle: 'شروحات وقوانين',
                icon: Icons.science,
                color: Colors.deepOrange,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SubjectsViewPage()));
                },
              ),
              _build3DCard(
                context,
                title: 'جداول الدراسة',
                subtitle: 'إدارة الوقت اليومي',
                icon: Icons.timer,
                color: Colors.green.shade700,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SchedulesPage()));
                },
              ),
              _build3DCard(
                context,
                title: 'بنك الاختبارات',
                subtitle: 'تدرب وصحح أخطاءك',
                icon: Icons.rule,
                color: Colors.purple.shade700,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizEngineView()));
                },
              ),
              _build3DCard(
                context,
                title: 'المطور والداعم',
                subtitle: 'إهداء من أب عُدي',
                icon: Icons.code,
                color: Colors.indigo,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // مكوّن البطاقة ثلاثية الأبعاد (3D Tilt & Elevation effect)
  Widget _build3DCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(0.04)
        ..rotateY(0.04),
      alignment: FractionalOffset.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(4, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.15),
                    radius: 22,
                    child: Icon(icon, color: color, size: 26),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. قسم المواد الدراسية مع تفاصيل علمية وإجراءات حقيقية
// ---------------------------------------------------------
class SubjectsView extends StatelessWidget {
  const SubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SubjectsViewPage();
  }
}

class SubjectsViewPage extends StatelessWidget {
  const SubjectsViewPage({super.key});

  final List<Map<String, dynamic>> subjectsData = const [
    {
      'name': 'الرياضيات المتقدمة',
      'detail': 'متتاليات، عقدية، تفاضل، هندسة فراغية',
      'content': 'تتضمن دراسة المتتاليات المتقاربة، حساب النهايات، الجداء السلمي والناظمي في الفراغ، ودراسة التابع الأسي واللوغاريتمي.',
      'icon': Icons.calculate,
      'color': Colors.blue,
    },
    {
      'name': 'الفيزياء والكهرباء',
      'detail': 'النواس المرن، المغناطيسية، والأمواج',
      'content': 'دراسة معادلة الحركة الجيبية الدورانية، النواس الفتل، تحريض فاراداي، الدائرية المتجانسة وتطبيقات التيار المتناوب.',
      'icon': Icons.bolt,
      'color': Colors.deepOrange,
    },
    {
      'name': 'الكيمياء العامة',
      'detail': 'الحركية، التوازن الكيميائي، والنووية',
      'content': 'دراسة سرعة التفاعل، ثابت التوازن Kc و Kp، الحموض وفق برونستد لوري، والتفاعلات النووية وتغيرات الكتلة والطاقة.',
      'icon': Icons.science,
      'color': Colors.teal,
    },
    {
      'name': 'العلوم (علم الأحياء)',
      'detail': 'التنسيق العصبي، المستقبلات، والتكاثر',
      'content': 'آلية نقل السيالة العصبية في المشابك، البنية الوظيفية للعين والأذن، الهرمونات البشرية ومراحل الإلقاح والتطور الجنيني.',
      'icon': Icons.biotech,
      'color': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مقرر المواد العلمية'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subjectsData.length,
        itemBuilder: (context, index) {
          final item = subjectsData[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: CircleAvatar(
                backgroundColor: item['color'].withOpacity(0.2),
                radius: 26,
                child: Icon(item['icon'], color: item['color'], size: 28),
              ),
              title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(item['detail'], style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(item['name']),
                    content: Text(item['content'], style: const TextStyle(fontSize: 15, height: 1.4)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('إغلاق'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------
// 3. قسم جداول الدراسة مع حفظ حالة الإنجاز (Shared Preferences)
// ---------------------------------------------------------
class SchedulesView extends StatelessWidget {
  const SchedulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SchedulesPage();
  }
}

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  List<bool> taskStatus = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      taskStatus[0] = prefs.getBool('task_0') ?? false;
      taskStatus[1] = prefs.getBool('task_1') ?? false;
      taskStatus[2] = prefs.getBool('task_2') ?? false;
      taskStatus[3] = prefs.getBool('task_3') ?? false;
    });
  }

  _saveProgress(int index, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      taskStatus[index] = value;
      prefs.setBool('task_$index', value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> schedules = [
      {'day': 'السبت والأحد', 'task': 'حل 50 مسألة رياضيات (متتاليات وعقدية)'},
      {'day': 'الإثنين والثلاثاء', 'task': 'مراجعة وحدات الفيزياء (النواس والأمواج)'},
      {'day': 'الأربعاء والخميس', 'task': 'حفظ الدورات الامتِحانية للعلوم والكيمياء'},
      {'day': 'الجمعة', 'task': 'اختبار تجريبي شامل ومراجعة أخطاء الأسبوع'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('جداول المهام والتدريب'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: CheckboxListTile(
              title: Text(schedules[index]['day']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(schedules[index]['task']!),
              value: taskStatus[index],
              onChanged: (val) {
                if (val != null) _saveProgress(index, val);
              },
              secondary: Icon(
                taskStatus[index] ? Icons.check_circle : Icons.radio_button_unchecked,
                color: taskStatus[index] ? Colors.green : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------
// 4. محرك اختبارات تفاعلي حقيقي بالكامل (Quiz Engine)
// ---------------------------------------------------------
class QuizEngineView extends StatefulWidget {
  const QuizEngineView({super.key});

  @override
  State<QuizEngineView> createState() => _QuizEngineViewState();
}

class _QuizEngineViewState extends State<QuizEngineView> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool answered = false;
  int selectedOption = -1;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'في الرياضيات: متتالية هندسية حدها الأول 2 وأساسها 3، ما هو حدها الثالث؟',
      'options': ['6', '18', '54', '9'],
      'correct': 1, // 18
    },
    {
      'question': 'في الفيزياء: النواس المرن، دور الاهتزاز الخاص يتناسب طرداً مع:',
      'options': ['الجذر التربيعي للكتلة m', 'ثابت المرونة k', 'السعة العظمى للمطال', 'طول النواس'],
      'correct': 0,
    },
    {
      'question': 'في الكيمياء: الحركية الكيميائية، سرعة التفاعل تعتمد أساساً على:',
      'options': ['حجم وعاء التفاعل', 'تراكيز المواد المتفاعلة', 'الضغط الجوي العام', 'لون المحلول'],
      'correct': 1,
    },
  ];

  void checkAnswer(int selected) {
    if (answered) return;
    setState(() {
      answered = true;
      selectedOption = selected;
      if (selected == questions[currentQuestionIndex]['correct']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      answered = false;
      selectedOption = -1;
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        currentQuestionIndex = -1; // End of quiz
      }
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      answered = false;
      selectedOption = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex == -1) {
      return Scaffold(
        appBar: AppBar(title: const Text('نتيجة الامتحان'), centerTitle: true),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
                const SizedBox(height: 16),
                const Text('أحسنت يا بطل!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('لقد أحرزت $score من ${questions.length}', style: const TextStyle(fontSize: 18, color: Colors.grey)),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: resetQuiz,
                  icon: const Icon(Icons.refresh),
                  label: const Text('إعادة الاختبار'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final q = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('السؤال ${currentQuestionIndex + 1} من ${questions.length}'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(value: (currentQuestionIndex + 1) / questions.length),
            const SizedBox(height: 24),
            Text(
              q['question'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 24),
            ...List.generate(q['options'].length, (index) {
              Color btnColor = Colors.white;
              Color textColor = Colors.black85;

              if (answered) {
                if (index == q['correct']) {
                  btnColor = Colors.green.shade100;
                  textColor = Colors.green.shade900;
                } else if (index == selectedOption) {
                  btnColor = Colors.red.shade100;
                  textColor = Colors.red.shade900;
                }
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    foregroundColor: textColor,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    alignment: Alignment.centerRight,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => checkAnswer(index),
                  child: Text(q['options'][index], style: const TextStyle(fontSize: 15)),
                ),
              );
            }),
            const Spacer(),
            if (answered)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: nextQuestion,
                child: const Text('السؤال التالي', style: TextStyle(fontSize: 16)),
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 5. شاشة المطور (About Screen)
// ---------------------------------------------------------
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عن التطبيق'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Color(0xFF1976D2), child: Icon(Icons.code, size: 50, color: Colors.white)),
            const SizedBox(height: 16),
            const Text('إشراف وتطوير: أب عُدي', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('تطبيق خيري متقدم لطلاب البكالوريا السورية العلمية', style: TextStyle(color: Colors.grey, fontSize: 13), textAlign: TextAlign.center),
            const Divider(height: 40),
            const ListTile(
              leading: Icon(Icons.offline_bolt, color: Colors.green),
              title: Text('يعمل بدون إنترنت 100%'),
              subtitle: Text('قواعد البيانات والمحتوى مخزنة محلياً بالكامل.'),
            ),
            const ListTile(
              leading: Icon(Icons.layers, color: Colors.blue),
              title: Text('تصميم مجسم (3D Perspective)'),
              subtitle: Text('واجهات عصرية تفاعلية مدعومة بماتريكس التحويل.'),
            ),
          ],
        ),
      ),
    );
  }
}
