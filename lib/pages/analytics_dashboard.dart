// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import '../widgets/enhanced_header.dart';

class AnalyticsDashboardPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const AnalyticsDashboardPage({super.key, required this.currentTheme});

  @override
  _AnalyticsDashboardPageState createState() => _AnalyticsDashboardPageState();
}

class _AnalyticsDashboardPageState extends State<AnalyticsDashboardPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;

  final Map<String, dynamic> analyticsData = {
    'totalChatrooms': 847,
    'totalProfiles': 12456,
    'onlineUsers': 3247,
    'totalCountries': 195,
    'bestUser': {
      'name': 'أليكس جونسون',
      'email': 'alex.johnson@example.com',
      'messagesCount': 15420,
      'joinedDate': '2023-05-15',
      'country': 'الولايات المتحدة',
      'status': 'متصل',
    },
    'bestRoom': {
      'name': 'مركز الدردشة العالمي',
      'description': 'أكثر غرف الدردشة نشاطًا على المستوى الدولي',
      'members': 8924,
      'messages': 245678,
      'createdDate': '2022-12-10',
      'category': 'عام',
    },
    'recentActivity': [
      {
        'action': 'تسجيل مستخدم جديد',
        'user': 'سارة ويلسون',
        'time': 'قبل دقيقتين',
        'type': 'user',
      },
      {
        'action': 'تم إنشاء غرفة',
        'room': 'مناقشات تقنية',
        'time': 'قبل 5 دقائق',
        'type': 'room',
      },
      {
        'action': 'تم إرسال رسالة',
        'user': 'مايك تشين',
        'time': 'قبل 7 دقائق',
        'type': 'message',
      },
      {
        'action': 'المستخدم متصل',
        'user': 'إيما ديفيس',
        'time': 'قبل 12 دقيقة',
        'type': 'status',
      },
      {
        'action': 'انضمام لغرفة جديدة',
        'user': 'ديفيد كيم',
        'time': 'قبل 15 دقيقة',
        'type': 'room',
      },
    ],
    'topCountries': [
      {'name': 'الولايات المتحدة', 'users': 2847, 'flag': '🇺🇸'},
      {'name': 'المملكة المتحدة', 'users': 1923, 'flag': '🇬🇧'},
      {'name': 'كندا', 'users': 1456, 'flag': '🇨🇦'},
      {'name': 'أستراليا', 'users': 1247, 'flag': '🇦🇺'},
      {'name': 'ألمانيا', 'users': 1089, 'flag': '🇩🇪'},
    ],
    'roomStats': [
      {
        'name': 'مركز الدردشة العالمي',
        'members': 8924,
        'messages': 245678,
        'status': 'نشط جدًا',
      },
      {
        'name': 'مناقشات تقنية',
        'members': 5647,
        'messages': 189234,
        'status': 'نشط',
      },
      {
        'name': 'ردهة الألعاب',
        'members': 4521,
        'messages': 156789,
        'status': 'نشط',
      },
      {
        'name': 'محبو الموسيقى',
        'members': 3892,
        'messages': 134567,
        'status': 'معتدل',
      },
      {
        'name': 'الطعام والوصفات',
        'members': 3154,
        'messages': 98765,
        'status': 'معتدل',
      },
    ],
    'onlineUsersByHour': [
      {'hour': '00:00', 'users': 1247},
      {'hour': '02:00', 'users': 890},
      {'hour': '04:00', 'users': 645},
      {'hour': '06:00', 'users': 1123},
      {'hour': '08:00', 'users': 2456},
      {'hour': '10:00', 'users': 3247},
      {'hour': '12:00', 'users': 3891},
      {'hour': '14:00', 'users': 4156},
      {'hour': '16:00', 'users': 3947},
      {'hour': '18:00', 'users': 4523},
      {'hour': '20:00', 'users': 4897},
      {'hour': '22:00', 'users': 3654},
    ],
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    String? subtitle,
    bool isPulsing = false,
  }) {
    return AnimatedBuilder(
      animation: isPulsing ? _pulseAnimation : _fadeAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isPulsing ? _pulseAnimation.value : 1.0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: widget.currentTheme['cardBg'],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: widget.currentTheme['shadow'],
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    if (isPulsing)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: widget.currentTheme['textPrimary'],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.currentTheme['textSecondary'],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.currentTheme['textSecondary'],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBestUserCard() {
    final bestUser = analyticsData['bestUser'] as Map<String, dynamic>;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.currentTheme['cardBg'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: widget.currentTheme['shadow'],
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.star, color: Colors.amber, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                'أفضل مستخدم',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.currentTheme['textPrimary'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: widget.currentTheme['accent'],
                child: Text(
                  bestUser['name'].toString()[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bestUser['name'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: widget.currentTheme['textPrimary'],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bestUser['email'].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.currentTheme['textSecondary'],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        bestUser['status'].toString().toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.currentTheme['mainBg'],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        bestUser['messagesCount'].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: widget.currentTheme['textPrimary'],
                        ),
                      ),
                      Text(
                        'الرسائل',
                        style: TextStyle(
                          fontSize: 10,
                          color: widget.currentTheme['textSecondary'],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: widget.currentTheme['textSecondary'].withOpacity(0.3),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        bestUser['country'].toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: widget.currentTheme['textPrimary'],
                        ),
                      ),
                      Text(
                        'الدولة',
                        style: TextStyle(
                          fontSize: 10,
                          color: widget.currentTheme['textSecondary'],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestRoomCard() {
    final bestRoom = analyticsData['bestRoom'] as Map<String, dynamic>;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.currentTheme['cardBg'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: widget.currentTheme['shadow'],
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.purple,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'أفضل غرفة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.currentTheme['textPrimary'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.currentTheme['mainBg'],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: widget.currentTheme['accent'],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bestRoom['name'].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            bestRoom['description'].toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            bestRoom['members'].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'الأعضاء',
                            style: TextStyle(
                              fontSize: 10,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: widget.currentTheme['textSecondary'].withOpacity(
                        0.3,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            bestRoom['messages'].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'الرسائل',
                            style: TextStyle(
                              fontSize: 10,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: widget.currentTheme['textSecondary'].withOpacity(
                        0.3,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            bestRoom['category'].toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'الفئة',
                            style: TextStyle(
                              fontSize: 10,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityCard() {
    final recentActivity = analyticsData['recentActivity'] as List<dynamic>;
    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.currentTheme['cardBg'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: widget.currentTheme['shadow'],
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.timeline, color: Colors.blue, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                'النشاط الأخير',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.currentTheme['textPrimary'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: recentActivity.length,
              itemBuilder: (context, index) {
                final activity = recentActivity[index] as Map<String, dynamic>;
                IconData activityIcon;
                Color activityColor;

                switch (activity['type']) {
                  case 'user':
                    activityIcon = Icons.person_add;
                    activityColor = Colors.green;
                    break;
                  case 'room':
                    activityIcon = Icons.add_box;
                    activityColor = Colors.blue;
                    break;
                  case 'message':
                    activityIcon = Icons.message;
                    activityColor = Colors.orange;
                    break;
                  case 'status':
                    activityIcon = Icons.circle;
                    activityColor = Colors.green;
                    break;
                  default:
                    activityIcon = Icons.info;
                    activityColor = Colors.grey;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.currentTheme['mainBg'],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: activityColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          activityIcon,
                          color: activityColor,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity['action'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: widget.currentTheme['textPrimary'],
                              ),
                            ),
                            Text(
                              (activity['user'] ?? activity['room'] ?? '')
                                  .toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: widget.currentTheme['textSecondary'],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        activity['time'].toString(),
                        style: TextStyle(
                          fontSize: 10,
                          color: widget.currentTheme['textSecondary'],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCountriesCard() {
    final topCountries = analyticsData['topCountries'] as List<dynamic>;
    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.currentTheme['cardBg'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: widget.currentTheme['shadow'],
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.public, color: Colors.red, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                'أعلى الدول',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.currentTheme['textPrimary'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: topCountries.length,
              itemBuilder: (context, index) {
                final country = topCountries[index] as Map<String, dynamic>;
                final int countryUsers = (country['users'] as num).toInt();
                final int maxUsers =
                    (topCountries[0]['users'] as num)
                        .toInt(); // max users first

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                country['flag'].toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                country['name'].toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: widget.currentTheme['textPrimary'],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '$countryUsers مستخدمين',
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: countryUsers / maxUsers,
                        backgroundColor: widget.currentTheme['textSecondary']
                            .withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          index == 0
                              ? Colors.red
                              : widget.currentTheme['accent'],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomStatsCard() {
    final roomStats = analyticsData['roomStats'] as List<dynamic>;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.currentTheme['cardBg'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: widget.currentTheme['shadow'],
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.forum, color: Colors.teal, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                'الغرف الشعبية',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.currentTheme['textPrimary'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...roomStats.map<Widget>((roomData) {
            final room = roomData as Map<String, dynamic>;
            Color statusColor;
            switch (room['status']) {
              case 'نشط جدًا':
                statusColor = Colors.green;
                break;
              case 'نشط':
                statusColor = Colors.orange;
                break;
              default:
                statusColor = Colors.blue;
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.currentTheme['mainBg'],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          room['name'].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: widget.currentTheme['textPrimary'],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          room['status'].toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              room['members'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: widget.currentTheme['textPrimary'],
                              ),
                            ),
                            Text(
                              'الأعضاء',
                              style: TextStyle(
                                fontSize: 10,
                                color: widget.currentTheme['textSecondary'],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: widget.currentTheme['textSecondary'].withOpacity(
                          0.3,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              room['messages'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: widget.currentTheme['textPrimary'],
                              ),
                            ),
                            Text(
                              'الرسائل',
                              style: TextStyle(
                                fontSize: 10,
                                color: widget.currentTheme['textSecondary'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final onlineUsersByHour =
        analyticsData['onlineUsersByHour'] as List<dynamic>;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    // Responsive breakpoints by width
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;

    final double paddingAll = isMobile ? 12 : 20;
    final double gridSpacing = isMobile ? 8 : 16;
    final int gridCrossCount = isMobile ? 1 : (isTablet ? 2 : 4);

    // Adjust childAspectRatio to make stat cards taller to prevent overflow
    final double gridChildAspectRatio = isMobile ? 1.6 : 1.8;

    // Adjust max height for the stats grid to prevent overflow on small heights
    final double maxStatsGridHeight = isMobile ? 350 : 280;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(
        top: paddingAll,
        right: paddingAll,
        bottom: paddingAll,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.currentTheme['mainBg'],
        boxShadow: [
          BoxShadow(
            color: widget.currentTheme['shadow'],
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          EnhancedHeader(
            currentTheme: widget.currentTheme,
            title: 'لوحة تحكم التحليلات',
            subtitle: 'تحليلات المنصة في الوقت الحقيقي',
            description: 'مراقبة أداء المنصة وتفاعل المستخدمين',
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(paddingAll),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Wrap stats GridView inside a ConstrainedBox and SingleChildScrollView vertically to avoid overflow
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: maxStatsGridHeight,
                        ),
                        child: GridView.count(
                          crossAxisCount: gridCrossCount,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          crossAxisSpacing: gridSpacing,
                          mainAxisSpacing: gridSpacing,
                          childAspectRatio: gridChildAspectRatio,
                          children: [
                            _buildStatCard(
                              title: 'إجمالي غرف الدردشة',
                              value: analyticsData['totalChatrooms'].toString(),
                              icon: Icons.chat_bubble_outline,
                              color: Colors.blue,
                            ),
                            _buildStatCard(
                              title: 'إجمالي الملفات الشخصية',
                              value: analyticsData['totalProfiles'].toString(),
                              icon: Icons.people_outline,
                              color: Colors.green,
                            ),
                            _buildStatCard(
                              title: 'المستخدمون المتصلون',
                              value: analyticsData['onlineUsers'].toString(),
                              icon: Icons.circle,
                              color: Colors.green,
                              subtitle: 'نشطون حالياً',
                              isPulsing: true,
                            ),
                            _buildStatCard(
                              title: 'الدول',
                              value: analyticsData['totalCountries'].toString(),
                              icon: Icons.public,
                              color: Colors.red,
                              subtitle: 'نطاق عالمي',
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: isMobile ? 16 : 24),

                    isMobile
                        ? Column(
                          children: [
                            _buildBestUserCard(),
                            SizedBox(height: 16),
                            _buildBestRoomCard(),
                          ],
                        )
                        : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildBestUserCard()),
                            SizedBox(width: 16),
                            Expanded(child: _buildBestRoomCard()),
                          ],
                        ),

                    SizedBox(height: isMobile ? 16 : 24),

                    isMobile
                        ? Column(
                          children: [
                            _buildRecentActivityCard(),
                            SizedBox(height: 16),
                            _buildTopCountriesCard(),
                          ],
                        )
                        : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildRecentActivityCard()),
                            SizedBox(width: 16),
                            Expanded(child: _buildTopCountriesCard()),
                          ],
                        ),

                    SizedBox(height: isMobile ? 16 : 24),

                    _buildRoomStatsCard(),

                    SizedBox(height: isMobile ? 16 : 24),

                    // Online users by hour chart container with horizontal scroll
                    Container(
                      padding: EdgeInsets.all(paddingAll),
                      decoration: BoxDecoration(
                        color: widget.currentTheme['cardBg'],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: widget.currentTheme['shadow'],
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.indigo.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.analytics,
                                  color: Colors.indigo,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'المستخدمون المتصلون حسب الساعة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: widget.currentTheme['textPrimary'],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 200,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width:
                                    isMobile
                                        ? screenWidth * 1.6
                                        : screenWidth * 1.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children:
                                      onlineUsersByHour.map<Widget>((
                                        hourDataDynamic,
                                      ) {
                                        final hourData =
                                            hourDataDynamic
                                                as Map<String, dynamic>;

                                        final maxUsers = onlineUsersByHour
                                            .map<int>(
                                              (h) =>
                                                  ((h
                                                              as Map<
                                                                String,
                                                                dynamic
                                                              >)['users']
                                                          as num)
                                                      .toInt(),
                                            )
                                            .reduce((a, b) => a > b ? a : b);

                                        final int currentUsers =
                                            (hourData['users'] as num).toInt();
                                        final double height =
                                            (currentUsers / maxUsers * 150)
                                                .toDouble();

                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              currentUsers.toString(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                color:
                                                    widget
                                                        .currentTheme['textSecondary'],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                milliseconds: 1000,
                                              ),
                                              width: 20,
                                              height: height,
                                              decoration: BoxDecoration(
                                                color:
                                                    widget
                                                        .currentTheme['accent'],
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    widget
                                                        .currentTheme['accent'],
                                                    widget
                                                        .currentTheme['accent']
                                                        .withOpacity(0.7),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              hourData['hour'].toString(),
                                              style: TextStyle(
                                                fontSize: 8,
                                                color:
                                                    widget
                                                        .currentTheme['textSecondary'],
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: isMobile ? 16 : 24),

                    // Quick actions container
                    Container(
                      padding: EdgeInsets.all(paddingAll),
                      decoration: BoxDecoration(
                        color: widget.currentTheme['cardBg'],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: widget.currentTheme['shadow'],
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.cyan.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.flash_on,
                                  color: Colors.cyan,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'إجراءات سريعة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: widget.currentTheme['textPrimary'],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Flex(
                            direction:
                                isMobile ? Axis.vertical : Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: isMobile ? 0 : 1,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'جارٍ تحديث بيانات التحليلات...',
                                        ),
                                        backgroundColor: Colors.blue,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'تحديث البيانات',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: isMobile ? 0 : 12,
                                height: isMobile ? 12 : 0,
                              ),
                              Expanded(
                                flex: isMobile ? 0 : 1,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'جارٍ تصدير تقرير التحليلات...',
                                        ),
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.download,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'تصدير التقرير',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: isMobile ? 0 : 12,
                                height: isMobile ? 12 : 0,
                              ),
                              Expanded(
                                flex: isMobile ? 0 : 1,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'جارٍ فتح التقارير التفصيلية...',
                                        ),
                                        backgroundColor: Colors.cyan,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.analytics,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'عرض التفاصيل',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.cyan,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
