// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import '../widgets/enhanced_header.dart';

class BannedSuspendedUsersPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const BannedSuspendedUsersPage({super.key, required this.currentTheme});

  @override
  _BannedSuspendedUsersPageState createState() =>
      _BannedSuspendedUsersPageState();
}

class _BannedSuspendedUsersPageState extends State<BannedSuspendedUsersPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  List<Map<String, dynamic>> bannedUsers = [
    {
      'name': 'أليكس جونسون',
      'username': 'alexj_2024',
      'dateBlocked': '2024-07-15 14:30:00',
      'blockedBy': 'أحمد (مدير)',
      'blockType': 'حظر دائم',
      'location': 'نيويورك، الولايات المتحدة',
      'ipAddress': '192.168.1.100',
      'reason': 'انتهاك إرشادات المجتمع - المضايقة',
      'status': 'محظور',
    },
    {
      'name': 'مايكل تشين',
      'username': 'mike_chen88',
      'dateBlocked': '2024-08-01 16:45:00',
      'blockedBy': 'سارة (مدير)',
      'blockType': 'حظر دائم',
      'location': 'تورونتو، كندا',
      'ipAddress': '172.16.0.78',
      'reason': 'مشاركة محتوى غير مناسب بشكل متكرر',
      'status': 'محظور',
    },
    {
      'name': 'ديفيد كيم',
      'username': 'david_k2024',
      'dateBlocked': '2024-08-04 13:10:00',
      'blockedBy': 'محمد (مدير)',
      'blockType': 'حظر عنوان IP',
      'location': 'سيول، كوريا الجنوبية',
      'ipAddress': '198.51.100.42',
      'reason': 'إنشاء عدة حسابات وهمية',
      'status': 'محظور',
    },
    {
      'name': 'جينيفر براون',
      'username': 'jen_brown',
      'dateBlocked': '2024-08-05 10:25:00',
      'blockedBy': 'علي (مشرف)',
      'blockType': 'إيقاف الحساب',
      'location': 'سيدني، أستراليا',
      'ipAddress': '192.168.2.150',
      'reason': 'انتهاكات بسيطة متكررة - فترة هدوء',
      'status': 'موقوف',
    },
    {
      'name': 'كارلوس مينديز',
      'username': 'carlos_m',
      'dateBlocked': '2024-08-05 15:40:00',
      'blockedBy': 'فاطمة (مدير)',
      'blockType': 'إيقاف الحساب',
      'location': 'مكسيكو سيتي، المكسيك',
      'ipAddress': '10.0.0.88',
      'reason': 'مخاوف أمنية محتملة - مراجعة الحساب',
      'status': 'موقوف',
    },
  ];

  String searchQuery = '';
  String selectedFilter = 'الكل';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredUsers {
    return bannedUsers.where((user) {
      final matchesSearch =
          user['name'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          user['username'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          user['location'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          );

      final matchesFilter =
          selectedFilter == 'الكل' || user['status'] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'محظور':
        return Colors.red;
      case 'موقوف':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Color getBlockTypeColor(String blockType) {
    switch (blockType) {
      case 'حظر دائم':
        return Colors.red;
      case 'حظر عنوان IP':
        return Colors.red.shade800;
      case 'إيقاف الحساب':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'محظور':
        return Icons.block;
      case 'موقوف':
        return Icons.stop_circle;
      default:
        return Icons.help;
    }
  }

  String getActionText(String status) {
    switch (status) {
      case 'محظور':
        return 'إلغاء الحظر';
      case 'موقوف':
        return 'إعادة التفعيل';
      default:
        return 'استعادة';
    }
  }

  String getDialogTitle(String status) {
    switch (status) {
      case 'محظور':
        return 'إلغاء حظر المستخدم';
      case 'موقوف':
        return 'إعادة تفعيل المستخدم';
      default:
        return 'استعادة المستخدم';
    }
  }

  String getDialogMessage(String status) {
    switch (status) {
      case 'محظور':
        return 'هل أنت متأكد من إلغاء حظر هذا المستخدم؟';
      case 'موقوف':
        return 'هل أنت متأكد من إعادة تفعيل حساب هذا المستخدم؟';
      default:
        return 'هل أنت متأكد من استعادة هذا المستخدم؟';
    }
  }

  String getSuccessMessage(String status) {
    switch (status) {
      case 'محظور':
        return 'تم إلغاء حظر المستخدم بنجاح!';
      case 'موقوف':
        return 'تم إعادة تفعيل حساب المستخدم بنجاح!';
      default:
        return 'تم استعادة المستخدم بنجاح!';
    }
  }

  void _showUnbanDialog(Map<String, dynamic> user, int userIndex) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: widget.currentTheme['cardBg'],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                const Icon(Icons.lock_open, color: Colors.green, size: 24),
                const SizedBox(width: 12),
                Text(
                  getDialogTitle(user['status']),
                  style: TextStyle(
                    color: widget.currentTheme['textPrimary'],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getDialogMessage(user['status']),
                  style: TextStyle(
                    color: widget.currentTheme['textPrimary'],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.currentTheme['mainBg'],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'المستخدم: ${user['name']} (@${user['username']})',
                        style: TextStyle(
                          color: widget.currentTheme['textPrimary'],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'نوع الحظر: ${user['blockType']}',
                        style: TextStyle(
                          color: widget.currentTheme['textSecondary'],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'تم الحظر في: ${user['dateBlocked']}',
                        style: TextStyle(
                          color: widget.currentTheme['textSecondary'],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'الحالة: ${user['status']}',
                        style: TextStyle(
                          color: getStatusColor(user['status']),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'إلغاء',
                  style: TextStyle(color: widget.currentTheme['textSecondary']),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    bannedUsers.removeAt(userIndex);
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(getSuccessMessage(user['status'])),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  getActionText(user['status']),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.currentTheme['cardBg'],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: widget.currentTheme['textSecondary']),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: widget.currentTheme['textSecondary'],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: widget.currentTheme['textPrimary'],
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    // Adapt sizes based on screen width
    double horizontalMargin = 16;
    double cardPadding = 16;
    double iconSize = 24;
    double fontSizeLarge = 18;
    double fontSizeMedium = 14;
    double fontSizeSmall = 12;
    double spacing = 12;

    if (screenWidth >= 1200) {
      // Desktop
      horizontalMargin = 48;
      cardPadding = 24;
      iconSize = 32;
      fontSizeLarge = 22;
      fontSizeMedium = 16;
      fontSizeSmall = 14;
      spacing = 16;
    } else if (screenWidth >= 800) {
      // Tablet
      horizontalMargin = 32;
      cardPadding = 20;
      iconSize = 28;
      fontSizeLarge = 20;
      fontSizeMedium = 15;
      fontSizeSmall = 13;
      spacing = 14;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(
          top: 16,
          right: horizontalMargin,
          bottom: 16,
          left: horizontalMargin,
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
              title: 'إدارة المستخدمين',
              subtitle: 'المستخدمون المحظورون والموقوفون',
              description: 'إدارة حسابات المستخدمين المقيدة',
            ),
            // ------------------------
            // Stats Cards Row: Responsive
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: horizontalMargin,
                vertical: 10,
              ),
              height: 110,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 480) {
                    // On very small screens, scrollable horizontally:
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _statsCard(
                            context,
                            Icons.block,
                            Colors.red,
                            bannedUsers.length.toString(),
                            'إجمالي المقيدين',
                            cardPadding,
                            iconSize,
                            fontSizeLarge,
                            fontSizeSmall,
                          ),
                          SizedBox(width: spacing),
                          _statsCard(
                            context,
                            Icons.block,
                            Colors.red,
                            bannedUsers
                                .where((u) => u['status'] == 'محظور')
                                .length
                                .toString(),
                            'محظور',
                            cardPadding,
                            iconSize,
                            fontSizeLarge,
                            fontSizeSmall,
                          ),
                          SizedBox(width: spacing),
                          _statsCard(
                            context,
                            Icons.stop_circle,
                            Colors.blue,
                            bannedUsers
                                .where((u) => u['status'] == 'موقوف')
                                .length
                                .toString(),
                            'موقوف',
                            cardPadding,
                            iconSize,
                            fontSizeLarge,
                            fontSizeSmall,
                          ),
                        ],
                      ),
                    );
                  }
                  // Otherwise, normal Row with Expanded
                  return Row(
                    children: [
                      Expanded(
                        child: _statsCard(
                          context,
                          Icons.block,
                          Colors.red,
                          bannedUsers.length.toString(),
                          'إجمالي المقيدين',
                          cardPadding,
                          iconSize,
                          fontSizeLarge,
                          fontSizeSmall,
                        ),
                      ),
                      SizedBox(width: spacing),
                      Expanded(
                        child: _statsCard(
                          context,
                          Icons.block,
                          Colors.red,
                          bannedUsers
                              .where((u) => u['status'] == 'محظور')
                              .length
                              .toString(),
                          'محظور',
                          cardPadding,
                          iconSize,
                          fontSizeLarge,
                          fontSizeSmall,
                        ),
                      ),
                      SizedBox(width: spacing),
                      Expanded(
                        child: _statsCard(
                          context,
                          Icons.stop_circle,
                          Colors.blue,
                          bannedUsers
                              .where((u) => u['status'] == 'موقوف')
                              .length
                              .toString(),
                          'موقوف',
                          cardPadding,
                          iconSize,
                          fontSizeLarge,
                          fontSizeSmall,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // ------------------------
            // Search and Filter
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: horizontalMargin,
                vertical: 20,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Use vertical layout for very small screens
                  if (constraints.maxWidth < 600) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          style: TextStyle(
                            color: widget.currentTheme['textPrimary'],
                          ),
                          decoration: InputDecoration(
                            hintText: 'البحث عن المستخدمين...',
                            hintStyle: TextStyle(
                              color: widget.currentTheme['textSecondary'],
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: widget.currentTheme['textSecondary'],
                            ),
                            filled: true,
                            fillColor: widget.currentTheme['cardBg'],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: widget.currentTheme['cardBg'],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedFilter,
                              isExpanded: true,
                              dropdownColor: widget.currentTheme['cardBg'],
                              style: TextStyle(
                                color: widget.currentTheme['textPrimary'],
                              ),
                              items:
                                  ['الكل', 'محظور', 'معلق', 'موقوف'].map((
                                    String value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedFilter = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Horizontal for larger screens
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            style: TextStyle(
                              color: widget.currentTheme['textPrimary'],
                            ),
                            decoration: InputDecoration(
                              hintText: 'البحث عن المستخدمين...',
                              hintStyle: TextStyle(
                                color: widget.currentTheme['textSecondary'],
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: widget.currentTheme['textSecondary'],
                              ),
                              filled: true,
                              fillColor: widget.currentTheme['cardBg'],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spacing),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: widget.currentTheme['cardBg'],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedFilter,
                                isExpanded: true,
                                dropdownColor: widget.currentTheme['cardBg'],
                                style: TextStyle(
                                  color: widget.currentTheme['textPrimary'],
                                ),
                                items:
                                    ['الكل', 'محظور', 'معلق', 'موقوف'].map((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedFilter = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            // ------------------------
            // Users List
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (filteredUsers.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.block,
                            size: 64,
                            color: widget.currentTheme['accent'],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'لا توجد مستخدمين مقيدين',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'جرب تعديل البحث أو المرشح',
                            style: TextStyle(
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalMargin,
                      ),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        final userIndex = bannedUsers.indexOf(user);

                        // Adjust font sizes per screen width inside tiles
                        double tileTitleFontSize = fontSizeLarge;
                        double tileSubtitleFontSize = fontSizeSmall;
                        double tileIconSize = iconSize;
                        double tileButtonFontSize = fontSizeSmall;

                        if (screenWidth >= 1200) {
                          tileTitleFontSize = 22;
                          tileSubtitleFontSize = 16;
                          tileIconSize = 32;
                          tileButtonFontSize = 14;
                        } else if (screenWidth >= 800) {
                          tileTitleFontSize = 20;
                          tileSubtitleFontSize = 14;
                          tileIconSize = 28;
                          tileButtonFontSize = 13;
                        }
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(bottom: spacing),
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
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.all(cardPadding),
                            childrenPadding: EdgeInsets.all(cardPadding),
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: getStatusColor(user['status']),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                getStatusIcon(user['status']),
                                color: Colors.white,
                                size: tileIconSize,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                    fontWeight: FontWeight.bold,
                                    fontSize: tileTitleFontSize,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '@${user['username']}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: widget.currentTheme['accent'],
                                    fontSize: tileSubtitleFontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  'تم الحظر: ${user['dateBlocked']}',
                                  style: TextStyle(
                                    color: widget.currentTheme['textSecondary'],
                                    fontSize: tileSubtitleFontSize,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'بواسطة: ${user['blockedBy']}',
                                  style: TextStyle(
                                    color: widget.currentTheme['textSecondary'],
                                    fontSize: tileSubtitleFontSize,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'الموقع: ${user['location']}',
                                  style: TextStyle(
                                    color: widget.currentTheme['textSecondary'],
                                    fontSize: tileSubtitleFontSize,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(user['status']),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            getStatusIcon(user['status']),
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            user['status'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getBlockTypeColor(
                                          user['blockType'],
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        user['blockType'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: ElevatedButton.icon(
                              onPressed:
                                  () => _showUnbanDialog(user, userIndex),
                              icon: const Icon(
                                Icons.lock_open,
                                color: Colors.white,
                                size: 16,
                              ),
                              label: Text(
                                getActionText(user['status']),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: tileButtonFontSize,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10, // Shrink for small screens
                                  vertical: 6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: const Size(70, 28),
                              ),
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.all(cardPadding),
                                decoration: BoxDecoration(
                                  color: widget.currentTheme['mainBg'],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // --- Responsive Wrapped Info Cards ---
                                    Wrap(
                                      spacing: spacing,
                                      runSpacing: spacing,
                                      children: [
                                        SizedBox(
                                          width:
                                              (constraints.maxWidth < 700)
                                                  ? double.infinity
                                                  : (screenWidth / 2) -
                                                      (spacing * 4),
                                          child: _buildInfoCard(
                                            'اسم المستخدم',
                                            '@${user['username']}',
                                            Icons.person,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              (constraints.maxWidth < 700)
                                                  ? double.infinity
                                                  : (screenWidth / 2) -
                                                      (spacing * 4),
                                          child: _buildInfoCard(
                                            'عنوان IP',
                                            user['ipAddress'],
                                            Icons.computer,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spacing),
                                    Wrap(
                                      spacing: spacing,
                                      runSpacing: spacing,
                                      children: [
                                        SizedBox(
                                          width:
                                              (constraints.maxWidth < 700)
                                                  ? double.infinity
                                                  : (screenWidth / 2) -
                                                      (spacing * 4),
                                          child: _buildInfoCard(
                                            'الموقع',
                                            user['location'],
                                            Icons.location_on,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              (constraints.maxWidth < 700)
                                                  ? double.infinity
                                                  : (screenWidth / 2) -
                                                      (spacing * 4),
                                          child: _buildInfoCard(
                                            'نوع الحظر',
                                            user['blockType'],
                                            Icons.block,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spacing),
                                    Wrap(
                                      spacing: spacing,
                                      runSpacing: spacing,
                                      children: [
                                        SizedBox(
                                          width:
                                              (constraints.maxWidth < 700)
                                                  ? double.infinity
                                                  : (screenWidth / 2) -
                                                      (spacing * 4),
                                          child: _buildInfoCard(
                                            'تاريخ الحظر',
                                            user['dateBlocked'],
                                            Icons.calendar_today,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              (constraints.maxWidth < 700)
                                                  ? double.infinity
                                                  : (screenWidth / 2) -
                                                      (spacing * 4),
                                          child: _buildInfoCard(
                                            'محظور بواسطة',
                                            user['blockedBy'],
                                            Icons.admin_panel_settings,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spacing * 1.25),
                                    // --- Reason ---
                                    Text(
                                      'سبب الحظر',
                                      style: TextStyle(
                                        color:
                                            widget.currentTheme['textPrimary'],
                                        fontSize: fontSizeMedium,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: widget.currentTheme['cardBg'],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: getStatusColor(
                                            user['status'],
                                          ).withOpacity(0.3),
                                        ),
                                      ),
                                      child: Text(
                                        user['reason'],
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textPrimary'],
                                          fontSize: fontSizeMedium,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Short helper for stats card
  Widget _statsCard(
    BuildContext context,
    IconData icon,
    Color iconColor,
    String value,
    String label,
    double cardPadding,
    double iconSize,
    double fontSizeLarge,
    double fontSizeSmall,
  ) {
    return Container(
      width: 140, // Fixed width for horizontal scroll
      padding: EdgeInsets.all(cardPadding),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: iconSize),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSizeLarge,
              fontWeight: FontWeight.bold,
              color: widget.currentTheme['textPrimary'],
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSizeSmall,
              color: widget.currentTheme['textSecondary'],
            ),
          ),
        ],
      ),
    );
  }
}
