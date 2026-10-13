
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const red = Color(0xFFB5122A);
const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseKey = String.fromEnvironment('SUPABASE_ANON_KEY');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (supabaseUrl.isNotEmpty && supabaseKey.isNotEmpty) {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );
  }

  runApp(const ClubAfricainApp());
}

class ClubAfricainApp extends StatelessWidget {
  const ClubAfricainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'النادي الإفريقي',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: red,
          primary: red,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: red,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = const [
    NewsPage(),
    MatchesPage(),
    PredictionsPage(),
    SocialPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'النادي الإفريقي ❤️🤍',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() => index = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.newspaper),
            label: 'الأخبار',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'المباريات',
          ),
          NavigationDestination(
            icon: Icon(Icons.how_to_vote),
            label: 'التوقعات',
          ),
          NavigationDestination(
            icon: Icon(Icons.share),
            label: 'حساباتنا',
          ),
        ],
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const BannerCard(),
        const SectionTitle('📰 آخر الأخبار'),
        if (supabaseUrl.isEmpty || supabaseKey.isEmpty)
          const InfoCard(
            title: 'قاعدة البيانات غير مربوطة',
            description:
                'أضف إعدادات Supabase لعرض الأخبار الحقيقية.',
          )
        else
          FutureBuilder(
            future: Supabase.instance.client
                .from('news')
                .select(
                  'title,summary,source_name,source_url,published_at',
                )
                .eq('published', true)
                .order('published_at', ascending: false)
                .limit(30),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return const InfoCard(
                  title: 'تعذر تحميل الأخبار',
                  description:
                      'تحقق من الاتصال وإعدادات قاعدة البيانات.',
                );
              }

              final news = snapshot.data;

              if (news == null || news.isEmpty) {
                return const InfoCard(
                  title: 'لا توجد أخبار منشورة',
                  description:
                      'ستظهر الأخبار هنا بعد نشرها من لوحة الإدارة.',
                );
              }

              return Column(
                children: news.map<Widget>((item) {
                  final date = DateTime.tryParse(
                    '${item['published_at'] ?? ''}',
                  );

                  return Card(
                    child: ListTile(
                      title: Text('${item['title']}'),
                      subtitle: Text(
                        '${item['summary'] ?? ''}\n'
                        'المصدر: ${item['source_name'] ?? ''}\n'
                        'التاريخ: ${date == null ? 'غير محدد' : '${date.day}/${date.month}/${date.year}'}',
                      ),
                      isThreeLine: true,
                      trailing: const Icon(
                        Icons.open_in_new,
                        color: red,
                      ),
                      onTap: () => openUrl(
                        '${item['source_url'] ?? ''}',
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        const SectionTitle('مصادر موثوقة'),
        SourceButton(
          title: 'الاتحاد الإفريقي لكرة القدم',
          url: 'https://www.cafonline.com/',
        ),
        SourceButton(
          title: 'الموقع الرسمي للنادي الإفريقي',
          url: 'https://clubafricain.com/',
        ),
        SourceButton(
          title: 'La Presse de Tunisie',
          url: 'https://www.lapresse.tn/',
        ),
      ],
    );
  }
}

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (supabaseUrl.isEmpty || supabaseKey.isEmpty) {
      return const InfoCard(
        title: 'مواعيد ونتائج المباريات',
        description:
            'اربط Supabase لإظهار المواعيد والنتائج المؤكدة.',
      );
    }

    return FutureBuilder(
      future: Supabase.instance.client
          .from('matches')
          .select()
          .order('kickoff_at', ascending: false)
          .limit(50),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const InfoCard(
            title: 'تعذر تحميل المباريات',
            description: 'تحقق من إعدادات قاعدة البيانات.',
          );
        }

        final matches = snapshot.data;

        if (matches == null || matches.isEmpty) {
          return const InfoCard(
            title: 'لا توجد مباريات مدخلة',
            description:
                'أضف المباريات من لوحة الإدارة لعرضها هنا.',
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: matches.map<Widget>((match) {
            final played = match['status'] == 'played';
            final date = DateTime.tryParse(
              '${match['kickoff_at'] ?? ''}',
            );

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '${match['competition'] ?? 'مباراة'}',
                      style: const TextStyle(color: red),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${match['home_team']}  '
                      '${played ? '${match['home_score']} - ${match['away_score']}' : 'VS'}  '
                      '${match['away_team']}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      date == null
                          ? 'الموعد غير محدد'
                          : '${date.day}/${date.month}/${date.year} '
                              '${date.hour.toString().padLeft(2, '0')}:'
                              '${date.minute.toString().padLeft(2, '0')}',
                    ),
                    if (match['source_url'] != null)
                      TextButton(
                        onPressed: () =>
                            openUrl('${match['source_url']}'),
                        child: const Text('مصدر المباراة'),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class PredictionsPage extends StatelessWidget {
  const PredictionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: InfoCard(
        title: '🗳️ توقعات الجماهير',
        description:
            'المرحلة التالية هي إضافة تسجيل الدخول، واختيار المباراة، '
            'وحفظ التوقعات في Supabase لمنع التصويت المكرر.',
      ),
    );
  }
}

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const BannerCard(),
        const SectionTitle('تابع حساباتنا الرسمية'),
        SourceButton(
          title: '🎵 TikTok — @club_africain1920tunis',
          url: 'https://www.tiktok.com/@club_africain1920tunis',
        ),
        SourceButton(
          title: '📸 Instagram — النادي الإفريقي',
          url: 'https://instagram.com/club_africain1920tunis?xtok=MXhoYWliZzZhd3k0ZA%3D%3D',
        ),
      ],
    );
  }
}

class BannerCard extends StatelessWidget {
  const BannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7D0B1B), red],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'نادي الشعب 🦅',
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 8),
          Text(
            'ديما الإفريقي ❤️🤍',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'الأخبار • النتائج • صوت الجماهير',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 8),
    child: Text(
      title,
      style: const TextStyle(
        color: red,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class InfoCard extends StatelessWidget {
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(description),
        ],
      ),
    ),
  );
}

class SourceButton extends StatelessWidget {
  final String title;
  final String url;

  const SourceButton({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      title: Text(title),
      trailing: const Icon(Icons.open_in_new, color: red),
      onTap: () => openUrl(url),
    ),
  );
}

Future<void> openUrl(String value) async {
  final uri = Uri.tryParse(value);
  if (uri != null && uri.hasScheme) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}
