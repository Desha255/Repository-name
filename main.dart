import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  عدّل بياناتك هنا بس (الاسم، الأرقام، المواعيد، الإعلانات)
// ============================================================
const String teacherName = 'مستر يحيي يونس';
const String centerName = 'سنتر مستر يحيي يونس';
const String tagline = 'الفهم أولاً، والدرجات بتيجي لوحدها';
const String aboutText =
    'اكتب هنا نبذة قصيرة عن المدرس وطريقة الشرح والمادة اللي بيدرّسها.';

const String phone = '01000000000';
const String whatsapp = '01000000000';
const String address = 'اكتب عنوان السنتر هنا';

class GroupItem {
  final String grade;
  final String days;
  final String time;
  const GroupItem(this.grade, this.days, this.time);
}

class NewsItem {
  final String title;
  final String body;
  final String date;
  const NewsItem(this.title, this.body, this.date);
}

// المواعيد (أمثلة، غيّرها براحتك)
const List<GroupItem> groups = [
  GroupItem('الصف الأول الثانوي', 'السبت والثلاثاء', '4:00 م'),
  GroupItem('الصف الثاني الثانوي', 'الأحد والأربعاء', '5:30 م'),
  GroupItem('الصف الثالث الثانوي', 'الاثنين والخميس', '7:00 م'),
];

// الإعلانات (أمثلة، غيّرها براحتك)
const List<NewsItem> news = [
  NewsItem('بدء الحجز للمجموعات الجديدة',
      'باب الحجز مفتوح دلوقتي. تواصل معانا على واتساب لتأكيد مكانك.', 'هذا الأسبوع'),
  NewsItem('امتحان شهري',
      'الامتحان الشهري الأسبوع الجاي في نفس ميعاد الحصة. المطلوب المراجعة على آخر منهج.', 'الأسبوع القادم'),
  NewsItem('تنبيه للطلاب',
      'الالتزام بمواعيد الحصص، والحضور قبل الميعاد بعشر دقائق.', 'دائم'),
];
// ============================================================

// ألوان السبورة: أخضر غامق + طباشير أصفر
const Color board = Color(0xFF1E3D33);
const Color chalk = Color(0xFFF2C14E);
const Color paper = Color(0xFFF4F6F3);
const Color ink = Color(0xFF1B2B25);

void main() => runApp(const CenterApp());

class CenterApp extends StatelessWidget {
  const CenterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: centerName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: board,
          primary: board,
          secondary: chalk,
        ),
      ),
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(onGo: (i) => setState(() => _index = i)),
      const SchedulePage(),
      const NewsPage(),
      const ContactPage(),
    ];
    const titles = ['الرئيسية', 'المواعيد', 'الإعلانات', 'تواصل معنا'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_index],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: board,
        foregroundColor: Colors.white,
      ),
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: Colors.white,
        indicatorColor: chalk,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'الرئيسية'),
          NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month),
              label: 'المواعيد'),
          NavigationDestination(
              icon: Icon(Icons.campaign_outlined),
              selectedIcon: Icon(Icons.campaign),
              label: 'الإعلانات'),
          NavigationDestination(
              icon: Icon(Icons.call_outlined),
              selectedIcon: Icon(Icons.call),
              label: 'تواصل'),
        ],
      ),
    );
  }
}

// ------------------------- الرئيسية -------------------------
class HomePage extends StatelessWidget {
  final void Function(int) onGo;
  const HomePage({super.key, required this.onGo});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
          decoration: BoxDecoration(
            color: board,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                'أهلاً بيك عند',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                teacherName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              Container(width: 70, height: 4, color: chalk),
              const SizedBox(height: 14),
              Text(
                tagline,
                textAlign: TextAlign.center,
                style: const TextStyle(color: chalk, fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _QuickTile(
                  icon: Icons.calendar_month,
                  label: 'مواعيد الحصص',
                  onTap: () => onGo(1)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickTile(
                  icon: Icons.campaign,
                  label: 'آخر الإعلانات',
                  onTap: () => onGo(2)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _QuickTile(
            icon: Icons.call,
            label: 'احجز وتواصل معانا',
            onTap: () => onGo(3)),
        const SizedBox(height: 16),
        _Box(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('عن المدرس',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: ink)),
              const SizedBox(height: 8),
              Text(aboutText,
                  style: const TextStyle(fontSize: 15, height: 1.7, color: ink)),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickTile(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFD5DDD8)),
          ),
          child: Column(
            children: [
              Icon(icon, size: 30, color: board),
              const SizedBox(height: 8),
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15, color: ink)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final Widget child;
  const _Box({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD5DDD8)),
      ),
      child: child,
    );
  }
}

// ------------------------- المواعيد -------------------------
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: groups.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final g = groups[i];
        return _Box(
          child: Row(
            children: [
              Container(
                width: 6,
                height: 64,
                decoration: BoxDecoration(
                  color: chalk,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(g.grade,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: ink)),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Icon(Icons.event, size: 18, color: board),
                      const SizedBox(width: 6),
                      Text(g.days, style: const TextStyle(color: ink)),
                    ]),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.schedule, size: 18, color: board),
                      const SizedBox(width: 6),
                      Text(g.time, style: const TextStyle(color: ink)),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ------------------------- الإعلانات -------------------------
class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (news.isEmpty) {
      return const Center(child: Text('مفيش إعلانات دلوقتي'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: news.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final n = news[i];
        return _Box(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(n.title,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: ink)),
                  ),
                  Text(n.date,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Text(n.body,
                  style: const TextStyle(fontSize: 15, height: 1.7, color: ink)),
            ],
          ),
        );
      },
    );
  }
}

// ------------------------- تواصل -------------------------
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _ContactTile(icon: Icons.call, title: 'اتصال', value: phone),
        SizedBox(height: 12),
        _ContactTile(icon: Icons.chat, title: 'واتساب', value: whatsapp),
        SizedBox(height: 12),
        _ContactTile(
            icon: Icons.location_on, title: 'عنوان السنتر', value: address),
        SizedBox(height: 16),
        Center(
          child: Text('اضغط على أيقونة النسخ وابعت على واتساب',
              style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _ContactTile(
      {required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return _Box(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: board,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: ink)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: ink, height: 1.4)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, color: board),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم النسخ')),
              );
            },
          ),
        ],
      ),
    );
  }
}
