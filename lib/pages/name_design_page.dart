// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import '../widgets/enhanced_header.dart';

class NamesDesignPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const NamesDesignPage({super.key, required this.currentTheme});

  @override
  _NamesDesignPageState createState() => _NamesDesignPageState();
}

class _NamesDesignPageState extends State<NamesDesignPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  bool isLoading = false;

  // ألوان الأدوار لقسم منتقي الألوان
  Map<String, Color> roleColors = {
    'عضو': const Color(0xFFE8E8E8),
    'مدير': Colors.blue,
    'مدير عام': Colors.green,
    'فتاة مميزة': Colors.pink,
    'مدير رئيسي': Colors.red,
  };

  // الألوان المتاحة لمنتقي الألوان
  final List<Color> availableColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

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

  Widget _buildRoleBadgeImage(
    String roleName,
    String imagePath,
    double width,
    double height,
    double fontSize,
    Color textColor,
    Color cardBgColor,
    Color shadowColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Column(
        children: [
          Text(
            roleName.toUpperCase(),
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: height * 0.1),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/$imagePath',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: widget.currentTheme['mainBg'],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          color: widget.currentTheme['textSecondary'],
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          imagePath,
                          style: TextStyle(
                            color: widget.currentTheme['textSecondary'],
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorRoleSelector(
    String roleName,
    Color currentColor,
    double width,
    double fontSize,
    Color textPrimary,
    Color textSecondary,
    Color shadowColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: width * 0.01,
      ),
      child: Column(
        children: [
          Text(
            roleName,
            style: TextStyle(
              color: textPrimary,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: width * 0.02),
          GestureDetector(
            onTap: () => _showColorPicker(roleName),
            child: Container(
              width: width * 0.8,
              height: width * 0.2,
              decoration: BoxDecoration(
                color: currentColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: textSecondary.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.palette,
                  color:
                      currentColor.computeLuminance() > 0.5
                          ? Colors.black54
                          : Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPicker(String roleName) {
    showDialog(
      context: context,
      builder:
          (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              backgroundColor: widget.currentTheme['cardBg'],
              title: Text(
                'اختر لون $roleName',
                style: TextStyle(
                  color: widget.currentTheme['textPrimary'],
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: availableColors.length,
                  itemBuilder: (context, index) {
                    final color = availableColors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          roleColors[roleName] = color;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                roleColors[roleName] == color
                                    ? Colors.white
                                    : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child:
                            roleColors[roleName] == color
                                ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                )
                                : null,
                      ),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'إلغاء',
                    style: TextStyle(
                      color: widget.currentTheme['textSecondary'],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _saveDesignChanges() async {
    setState(() {
      isLoading = true;
    });

    // محاكاة استدعاء API
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تم حفظ تغييرات التصميم بنجاح!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;

    // Responsive parameters based on width breakpoints:
    // Mobile: <600
    // Tablet: 600-1024
    // Desktop: >1024

    double horizontalMargin = width * 0.04;
    double verticalMargin = 16;
    double cardPadding = width * 0.04;
    double roleBadgeWidth, roleBadgeHeight, badgeFontSize;
    double selectorFontSize;

    if (width >= 1024) {
      // Desktop
      roleBadgeWidth = 260;
      roleBadgeHeight = 140;
      badgeFontSize = 14;
      selectorFontSize = 16;
    } else if (width >= 600) {
      // Tablet
      roleBadgeWidth = 220;
      roleBadgeHeight = 120;
      badgeFontSize = 13;
      selectorFontSize = 14;
    } else {
      // Mobile
      roleBadgeWidth = 160;
      roleBadgeHeight = 95;
      badgeFontSize = 12;
      selectorFontSize = 12;
      cardPadding = 16;
    }

    Color textPrimary = widget.currentTheme['textPrimary'];
    Color textSecondary = widget.currentTheme['textSecondary'];
    Color cardBg = widget.currentTheme['cardBg'];
    Color shadow = widget.currentTheme['shadow'];
    Color accent = widget.currentTheme['accent'];

    // Helper Widget to avoid overflow on small screens:
    Widget horizontalScrollableRow(Widget child) {
      // For small widths, enable horizontal scroll,
      // for bigger widths, disable scroll.
      // But since we have many badges, keep scroll always.
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: child,
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(
          top: verticalMargin,
          right: horizontalMargin,
          bottom: verticalMargin,
          left: horizontalMargin,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.currentTheme['mainBg'],
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          children: [
            EnhancedHeader(
              currentTheme: widget.currentTheme,
              title: 'الأسماء والتصميم',
              subtitle: 'شارات الأدوار وإدارة الألوان',
              description: 'تخصيص شارات الأدوار وإدارة ألوان أدوار المستخدمين',
            ),

            // زر الإجراء
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: horizontalMargin * 1.25,
                vertical: verticalMargin * 0.65,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: isLoading ? null : _saveDesignChanges,
                    icon:
                        isLoading
                            ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : const Icon(Icons.save, color: Colors.white),
                    label: Text(
                      isLoading ? 'جاري الحفظ...' : 'حفظ التغييرات',
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الصف الأول من شارات الأدوار
                        Container(
                          padding: EdgeInsets.all(cardPadding),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: shadow,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'شارات الأدوار الإدارية',
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: badgeFontSize + 4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: verticalMargin),
                              horizontalScrollableRow(
                                Row(
                                  children: [
                                    _buildRoleBadgeImage(
                                      'مدير المحادثة',
                                      'chatmanager.png',
                                      roleBadgeWidth,
                                      roleBadgeHeight,
                                      badgeFontSize,
                                      textSecondary,
                                      cardBg,
                                      shadow,
                                    ),
                                    _buildRoleBadgeImage(
                                      'الجذر',
                                      'root.png',
                                      roleBadgeWidth,
                                      roleBadgeHeight,
                                      badgeFontSize,
                                      textSecondary,
                                      cardBg,
                                      shadow,
                                    ),
                                    _buildRoleBadgeImage(
                                      'فتاة مميزة',
                                      'mastergirl.png',
                                      roleBadgeWidth,
                                      roleBadgeHeight,
                                      badgeFontSize,
                                      textSecondary,
                                      cardBg,
                                      shadow,
                                    ),
                                    _buildRoleBadgeImage(
                                      'مدير رئيسي',
                                      'master.png',
                                      roleBadgeWidth,
                                      roleBadgeHeight,
                                      badgeFontSize,
                                      textSecondary,
                                      cardBg,
                                      shadow,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: verticalMargin),

                        // الصف الثاني من شارات الأدوار
                        Container(
                          padding: EdgeInsets.all(cardPadding),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: shadow,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'شارات أدوار العضوية',
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: badgeFontSize + 4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: verticalMargin),
                              horizontalScrollableRow(
                                Row(
                                  children: [
                                    _buildRoleBadgeImage(
                                      'محمي',
                                      'protected.png',
                                      roleBadgeWidth,
                                      roleBadgeHeight,
                                      badgeFontSize,
                                      textSecondary,
                                      cardBg,
                                      shadow,
                                    ),
                                    _buildRoleBadgeImage(
                                      'ملكي',
                                      'royal.png',
                                      roleBadgeWidth,
                                      roleBadgeHeight,
                                      badgeFontSize,
                                      textSecondary,
                                      cardBg,
                                      shadow,
                                    ),
                                    _buildRoleBadgeImage(
                                      'مميز',
                                      'vip.png',
                                      roleBadgeWidth,
                                      roleBadgeHeight,
                                      badgeFontSize,
                                      textSecondary,
                                      cardBg,
                                      shadow,
                                    ),
                                    _buildRoleBadgeImage(
                                      'متميز',
                                      'premium.png',
                                      roleBadgeWidth,
                                      roleBadgeHeight,
                                      badgeFontSize,
                                      textSecondary,
                                      cardBg,
                                      shadow,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: verticalMargin),

                        // قسم منتقي ألوان الأدوار
                        Container(
                          padding: EdgeInsets.all(cardPadding),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: shadow,
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
                                  Icon(
                                    Icons.palette,
                                    color: accent,
                                    size: badgeFontSize + 10,
                                  ),
                                  SizedBox(width: horizontalMargin * 0.75),
                                  Text(
                                    'إدارة ألوان الأدوار',
                                    style: TextStyle(
                                      color: textPrimary,
                                      fontSize: badgeFontSize + 4,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: verticalMargin * 0.5),
                              Text(
                                'انقر على أي لون دور لتخصيصه باستخدام منتقي الألوان',
                                style: TextStyle(
                                  color: textSecondary,
                                  fontSize: selectorFontSize,
                                ),
                              ),
                              SizedBox(height: verticalMargin),
                              Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                spacing: horizontalMargin,
                                runSpacing: verticalMargin,
                                children:
                                    roleColors.entries.map((entry) {
                                      return _buildColorRoleSelector(
                                        entry.key,
                                        entry.value,
                                        width < 360
                                            ? 120
                                            : (width < 1024 ? 140 : 180),
                                        selectorFontSize,
                                        textPrimary,
                                        textSecondary,
                                        shadow,
                                      );
                                    }).toList(),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: verticalMargin),

                        // تذييل المعلومات
                        Container(
                          padding: EdgeInsets.all(verticalMargin),
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: accent.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: accent),
                              SizedBox(width: horizontalMargin * 0.75),
                              Expanded(
                                child: Text(
                                  'يتم تطبيق تصميمات شارات الأدوار تلقائياً عبر المنصة. ستنعكس تغييرات الألوان في ملفات المستخدمين وواجهات المحادثة.',
                                  style: TextStyle(
                                    color: textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: verticalMargin),
                      ],
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
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
