// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

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

  Map<String, Color> roleColors = {
    'Master Admin': const Color(0xFFE8E8E8),
    'Super Admin': Colors.blue,
    'Master Girl': Colors.green,
    'Master': Colors.pink,
    'Senior Manager': Colors.red,
  };

  Map<String, Color> smallLogoColors = {
    'small_logo1.png': Colors.orange,
    'small_logo2.png': Colors.teal,
    'small_logo3.png': Colors.deepPurple,
    'small_logo4.png': Colors.amber,
  };

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

  Widget _buildSmallLogoColorPicker(
    String logoKey,
    Color currentColor,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () => _showSmallLogoColorPicker(logoKey),
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: currentColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                currentColor.computeLuminance() > 0.5
                    ? Colors.black54
                    : Colors.white70,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: const Offset(0, 1),
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
            size: 18,
          ),
        ),
      ),
    );
  }

  void _showSmallLogoColorPicker(String logoKey) {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: widget.currentTheme['cardBg'],
            title: Text(
              'Choose color for logo',
              style: TextStyle(
                color: widget.currentTheme['textPrimary'],
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 170,
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
                        smallLogoColors[logoKey] = color;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              smallLogoColors[logoKey] == color
                                  ? Colors.white
                                  : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child:
                          smallLogoColors[logoKey] == color
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
                  'Cancel',
                  style: TextStyle(color: widget.currentTheme['textSecondary']),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoleBadgeImage(
    String roleName,
    String imagePath,
    String smallLogoPath,
    double width,
    double height,
    double fontSize,
    Color textColor,
    Color cardBgColor,
    Color shadowColor,
    bool withMiniPalette,
    double miniPaletteSize,
  ) {
    double smallLogoWidthFactor = width >= 1024 ? 0.8 : 0.5;
    double smallLogoHeightFactor = width >= 1024 ? 0.48 : 0.3;
    Widget logo = Container(
      width: width * smallLogoWidthFactor,
      height: height * smallLogoHeightFactor,
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/$smallLogoPath',
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
                    size: 20,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    smallLogoPath,
                    style: TextStyle(
                      color: widget.currentTheme['textSecondary'],
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    List<Widget> logoColumn = [
      logo,
      if (withMiniPalette)
        _buildSmallLogoColorPicker(
          smallLogoPath,
          smallLogoColors[smallLogoPath] ?? Colors.grey,
          miniPaletteSize,
          miniPaletteSize,
        ),
    ];

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
          SizedBox(height: height * 0.08),
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
          SizedBox(height: height * 0.03),
          ...logoColumn,
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
              width: width * 0.67,
              height: width * 0.16,
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
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: widget.currentTheme['cardBg'],
            title: Text(
              'Choose color for $roleName',
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
                  'Cancel',
                  style: TextStyle(color: widget.currentTheme['textSecondary']),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveDesignChanges() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Design changes saved successfully!'),
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

    double horizontalMargin = width * 0.03;
    double verticalMargin = 16;
    double cardPadding = width * 0.03;
    double roleBadgeWidth, roleBadgeHeight, badgeFontSize;
    double selectorFontSize;
    double miniPaletteSizeDesktop = 32,
        miniPaletteSizeTablet = 24,
        miniPaletteSizeMobile = 22;

    if (width >= 1024) {
      roleBadgeWidth = 210;
      roleBadgeHeight = 115;
      badgeFontSize = 14;
      selectorFontSize = 16;
      cardPadding = 22;
    } else if (width >= 600) {
      roleBadgeWidth = 170;
      roleBadgeHeight = 100;
      badgeFontSize = 13;
      selectorFontSize = 14;
      cardPadding = 18;
    } else {
      roleBadgeWidth = 130;
      roleBadgeHeight = 74;
      badgeFontSize = 12;
      selectorFontSize = 12;
      cardPadding = 12;
    }

    Color textPrimary = widget.currentTheme['textPrimary'];
    Color textSecondary = widget.currentTheme['textSecondary'];
    Color cardBg = widget.currentTheme['cardBg'];
    Color shadow = widget.currentTheme['shadow'];
    Color accent = widget.currentTheme['accent'];

    final List<Map<String, String>> badgeWithSmallLogosAdmin = [
      {
        'role': 'Chat Manager',
        'bigLogo': 'chatmanager.png',
        'smallLogo': 'small_logo1.png',
      },
      {'role': 'Root', 'bigLogo': 'root.png', 'smallLogo': 'small_logo2.png'},
      {
        'role': 'Master Girl',
        'bigLogo': 'mastergirl.png',
        'smallLogo': 'small_logo3.png',
      },
      {
        'role': 'Master',
        'bigLogo': 'master.png',
        'smallLogo': 'small_logo4.png',
      },
    ];

    final List<Map<String, String>> badgeWithSmallLogosMember = [
      {
        'role': 'محمي',
        'bigLogo': 'protected.png',
        'smallLogo': 'small_logo5.png',
      },
      {'role': 'ملكي', 'bigLogo': 'royal.png', 'smallLogo': 'small_logo6.png'},
      {'role': 'VIP', 'bigLogo': 'vip.png', 'smallLogo': 'small_logo7.png'},
      {
        'role': 'مميز',
        'bigLogo': 'premium.png',
        'smallLogo': 'small_logo8.png',
      },
    ];

    Widget colorSelectorRow =
        width >= 1024
            ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  roleColors.entries.map((entry) {
                    return _buildColorRoleSelector(
                      entry.key,
                      entry.value,
                      width / 6.2,
                      selectorFontSize,
                      textPrimary,
                      textSecondary,
                      shadow,
                    );
                  }).toList(),
            )
            : Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: horizontalMargin,
              runSpacing: verticalMargin,
              children:
                  roleColors.entries.map((entry) {
                    return _buildColorRoleSelector(
                      entry.key,
                      entry.value,
                      width < 360 ? 75 : (width < 1024 ? 105 : 120),
                      selectorFontSize,
                      textPrimary,
                      textSecondary,
                      shadow,
                    );
                  }).toList(),
            );

    Widget badgesRow(List<Map<String, String>> badges, bool admin) {
      return width >= 1024
          ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                badges.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String smallLogoPath = entry.value['smallLogo']!;
                  bool withMiniPalette = admin && idx < 4;
                  double miniPaletteSize =
                      width >= 1024
                          ? miniPaletteSizeDesktop
                          : (width >= 600
                              ? miniPaletteSizeTablet
                              : miniPaletteSizeMobile);
                  return _buildRoleBadgeImage(
                    entry.value['role']!,
                    entry.value['bigLogo']!,
                    smallLogoPath,
                    roleBadgeWidth,
                    roleBadgeHeight,
                    badgeFontSize,
                    textSecondary,
                    cardBg,
                    shadow,
                    withMiniPalette,
                    miniPaletteSize,
                  );
                }).toList(),
          )
          : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  badges.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String smallLogoPath = entry.value['smallLogo']!;
                    bool withMiniPalette = admin && idx < 4;
                    double miniPaletteSize =
                        width >= 1024
                            ? miniPaletteSizeDesktop
                            : (width >= 600
                                ? miniPaletteSizeTablet
                                : miniPaletteSizeMobile);
                    return _buildRoleBadgeImage(
                      entry.value['role']!,
                      entry.value['bigLogo']!,
                      smallLogoPath,
                      roleBadgeWidth,
                      roleBadgeHeight,
                      badgeFontSize,
                      textSecondary,
                      cardBg,
                      shadow,
                      withMiniPalette,
                      miniPaletteSize,
                    );
                  }).toList(),
            ),
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
              title: 'Names and Design',
              subtitle: 'Role Badges and Color Management',
              description: 'Customize role badges and manage user role colors',
            ),

            Container(
              margin: EdgeInsets.symmetric(
                horizontal: horizontalMargin * 1.1,
                vertical: verticalMargin * 0.58,
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
                      isLoading ? 'Saving...' : 'Save Changes',
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
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
                        // ======= ONLY THIS SECTION IS UPDATED (extra row removed) =======
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
                                    'Manage Role Colors',
                                    style: TextStyle(
                                      color: textPrimary,
                                      fontSize: badgeFontSize + 4,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: verticalMargin * 0.32),
                              Text(
                                'Click on any role color to customize it using the color picker',
                                style: TextStyle(
                                  color: textSecondary,
                                  fontSize: selectorFontSize,
                                ),
                              ),
                              SizedBox(height: verticalMargin),
                              colorSelectorRow,
                            ],
                          ),
                        ),

                        // ======= /ONLY THIS SECTION IS UPDATED =======
                        SizedBox(height: verticalMargin),

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
                                'Administrative Role Badges',
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: badgeFontSize + 4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: verticalMargin),
                              badgesRow(badgeWithSmallLogosAdmin, true),
                            ],
                          ),
                        ),

                        SizedBox(height: verticalMargin),

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
                                'Membership Role Badges',
                                style: TextStyle(
                                  color: textPrimary,
                                  fontSize: badgeFontSize + 4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: verticalMargin),
                              badgesRow(badgeWithSmallLogosMember, false),
                            ],
                          ),
                        ),

                        SizedBox(height: verticalMargin),

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
                              SizedBox(width: horizontalMargin * 0.77),
                              Expanded(
                                child: Text(
                                  'Role badge designs are applied automatically across the platform. Color changes will reflect in user profiles and chat interfaces.',
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
