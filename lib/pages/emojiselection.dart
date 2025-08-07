// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import '../widgets/enhanced_header.dart';

class EmojiSelectionPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const EmojiSelectionPage({super.key, required this.currentTheme});

  @override
  _EmojiSelectionPageState createState() => _EmojiSelectionPageState();
}

class _EmojiSelectionPageState extends State<EmojiSelectionPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fadeController;

  bool isLoading = false;

  // Sample emoji list with positions
  List<Map<String, dynamic>> emojis = [
    {'emoji': '😃', 'position': 5},
    {'emoji': '😊', 'position': 4},
    {'emoji': '🐻', 'position': 3},
    {'emoji': '💋', 'position': 2},
    {'emoji': '😊', 'position': 1},
    {'emoji': '😃', 'position': 0},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // --- CARD BUILDER WITH MOBILE OVERFLOW FIXES ---
  Widget _buildEmojiCard(
    Map<String, dynamic> emojiData,
    int index,
    double cardWidth,
    double emojiFontSize,
    double iconSize,
    TextStyle positionTextStyle,
    bool isMobile, // << pass mobile flag
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            (index * 0.1).clamp(0.0, 1.0),
            ((index * 0.1) + 0.3).clamp(0.0, 1.0),
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
      child: Container(
        width: cardWidth,
        // less vertical margin on mobile
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: isMobile ? 2 : 4),
        decoration: BoxDecoration(
          color: widget.currentTheme['cardBg'],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: widget.currentTheme['shadow'],
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 110,
            maxHeight: isMobile ? 155 : 200, // LOWER maxHeight on mobile
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // main emoji display
              SizedBox(
                width: cardWidth,
                height:
                    cardWidth * (isMobile ? 0.5 : 0.7), // less height on mobile
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      emojiData['emoji'],
                      style: TextStyle(fontSize: emojiFontSize),
                    ),
                  ),
                ),
              ),
              // position number
              Container(
                width: iconSize + 14,
                height: iconSize + 14,
                margin: EdgeInsets.symmetric(vertical: isMobile ? 3 : 6),
                decoration: BoxDecoration(
                  color: widget.currentTheme['mainBg'],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.currentTheme['textSecondary'].withOpacity(
                      0.3,
                    ),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    emojiData['position'].toString(),
                    style: positionTextStyle,
                  ),
                ),
              ),
              // Button row always min size and match-parent width
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: isMobile ? 1 : 2,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _deleteEmoji(index),
                      child: Container(
                        width: iconSize + 14,
                        height: iconSize + 14,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: iconSize,
                        ),
                      ),
                    ),
                    SizedBox(width: isMobile ? 6 : 10),
                    GestureDetector(
                      onTap: () => _replaceEmoji(index),
                      child: Container(
                        width: iconSize + 14,
                        height: iconSize + 14,
                        decoration: BoxDecoration(
                          color: widget.currentTheme['accent'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: widget.currentTheme['accent'].withOpacity(
                              0.3,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          color: widget.currentTheme['accent'],
                          size: iconSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // More room at the bottom only on big screens
              SizedBox(height: isMobile ? 2 : 6),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteEmoji(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: widget.currentTheme['cardBg'],
            title: Text(
              'حذف الرمز التعبيري',
              style: TextStyle(
                color: widget.currentTheme['textPrimary'],
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'هل أنت متأكد من أنك تريد حذف هذا الرمز التعبيري؟',
              style: TextStyle(color: widget.currentTheme['textSecondary']),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'إلغاء',
                  style: TextStyle(color: widget.currentTheme['textSecondary']),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    emojis.removeAt(index);
                    for (int i = 0; i < emojis.length; i++) {
                      emojis[i]['position'] = emojis.length - 1 - i;
                    }
                  });
                  Navigator.pop(context);
                  _showSuccessMessage('تم حذف الرمز التعبيري بنجاح!');
                },
                child: const Text('حذف', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  // Modified _replaceEmoji with text input dialog
  void _replaceEmoji(int index) {
    final currentEmoji = emojis[index]['emoji'];
    _showEmojiInputDialog((enteredEmoji) {
      setState(() {
        emojis[index]['emoji'] = enteredEmoji;
      });
      _showSuccessMessage('تم تحديث الرمز التعبيري بنجاح!');
    }, initialEmoji: currentEmoji);
  }

  // Modified _addNewEmoji with text input dialog
  void _addNewEmoji() {
    if (emojis.length >= 20) {
      _showErrorMessage('الحد الأقصى 20 رمز تعبيري مسموح!');
      return;
    }

    _showEmojiInputDialog((enteredEmoji) {
      setState(() {
        emojis.insert(0, {'emoji': enteredEmoji, 'position': emojis.length});
        for (int i = 0; i < emojis.length; i++) {
          emojis[i]['position'] = emojis.length - 1 - i;
        }
      });
      _showSuccessMessage('تم إضافة رمز تعبيري جديد بنجاح!');
    });
  }

  // New dialog for user emoji input via keyboard
  void _showEmojiInputDialog(
    Function(String) onEmojiEntered, {
    String? initialEmoji,
  }) {
    final TextEditingController controller = TextEditingController(
      text: initialEmoji ?? '',
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: widget.currentTheme['cardBg'],
            title: Text(
              'أدخل الرمز التعبيري',
              style: TextStyle(
                color: widget.currentTheme['textPrimary'],
                fontWeight: FontWeight.bold,
              ),
            ),
            content: TextField(
              controller: controller,
              autofocus: true,
              maxLength: 2, // Most emojis fit within 2 UTF-16 code units
              style: const TextStyle(fontSize: 32),
              decoration: InputDecoration(
                hintText: 'أدخل رمز تعبيري هنا',
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: widget.currentTheme['mainBg'],
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'إلغاء',
                  style: TextStyle(color: widget.currentTheme['textSecondary']),
                ),
              ),
              TextButton(
                onPressed: () {
                  final enteredText = controller.text.trim();
                  if (enteredText.isNotEmpty) {
                    onEmojiEntered(enteredText);
                    Navigator.pop(context);
                  } else {
                    // Optionally: show a message or do nothing for empty input
                  }
                },
                child: const Text(
                  'إضافة',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
    );
  }

  void _saveChanges() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
    _showSuccessMessage('تم حفظ إعدادات الرموز التعبيرية بنجاح!');
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth <= 600;
    final bool isTablet = screenWidth > 600 && screenWidth <= 1024;

    final double horizontalMargin = isMobile ? 8 : (isTablet ? 16 : 24);
    final double mainPadding = isMobile ? 12 : 20;
    final double headerIconSize = isMobile ? 20 : 24;
    final double headerFontSize = isMobile ? 16 : 18;
    final double subtitleFontSize = isMobile ? 12 : 14;
    final double emojiFontSize = isMobile ? 28 : 40; // << reduced a bit
    final double iconSize = isMobile ? 16 : 20;
    final double buttonPaddingVertical = isMobile ? 8 : 12;
    final double buttonPaddingHorizontal = isMobile ? 12 : 16;
    final double positionFontSize = isMobile ? 12 : 14;

    final int crossAxisCount =
        isMobile
            ? 2
            : isTablet
            ? 3
            : (screenWidth > 1400 ? 6 : 4);

    final double cardWidth =
        isMobile
            ? (screenWidth - 2 * horizontalMargin - 32) / 2
            : isTablet
            ? (screenWidth - 2 * horizontalMargin - 48) / 3
            : 120;

    final positionTextStyle = TextStyle(
      color: widget.currentTheme['textPrimary'],
      fontSize: positionFontSize,
      fontWeight: FontWeight.w600,
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(top: 16, right: 16, bottom: 16),
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalMargin,
              vertical: 16,
            ),
            child: EnhancedHeader(
              currentTheme: widget.currentTheme,
              title: 'اختيار الرموز التعبيرية',
              subtitle: 'إدارة الرموز التعبيرية المخصصة',
              description:
                  'إضافة وتعديل وتنظيم مجموعة الرموز التعبيرية المخصصة',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalMargin,
              vertical: 10,
            ),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _addNewEmoji,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'إضافة رمز',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.currentTheme['accent'],
                    padding: EdgeInsets.symmetric(
                      horizontal: buttonPaddingHorizontal,
                      vertical: buttonPaddingVertical,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: TextStyle(fontSize: isMobile ? 14 : 16),
                  ),
                ),
                SizedBox(width: isMobile ? 8 : 12),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: buttonPaddingHorizontal,
                    vertical: buttonPaddingVertical - 2,
                  ),
                  decoration: BoxDecoration(
                    color: widget.currentTheme['cardBg'],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: widget.currentTheme['textSecondary'].withOpacity(
                        0.3,
                      ),
                    ),
                  ),
                  child: Text(
                    '${emojis.length}/20 رمز تعبيري',
                    style: TextStyle(
                      color: widget.currentTheme['textSecondary'],
                      fontSize: isMobile ? 10 : 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : _saveChanges,
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
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 20,
                      vertical: buttonPaddingVertical,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: TextStyle(fontSize: isMobile ? 14 : 16),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(mainPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(mainPadding),
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
                            Icon(
                              Icons.emoji_emotions,
                              color: widget.currentTheme['accent'],
                              size: headerIconSize,
                            ),
                            SizedBox(width: isMobile ? 8 : 12),
                            Expanded(
                              child: Text(
                                'مجموعة الرموز التعبيرية الحالية',
                                style: TextStyle(
                                  color: widget.currentTheme['textPrimary'],
                                  fontSize: headerFontSize,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isMobile ? 6 : 8),
                        Text(
                          'انقر على تعديل لاستبدال رمز تعبيري أو حذف لإزالته',
                          style: TextStyle(
                            color: widget.currentTheme['textSecondary'],
                            fontSize: subtitleFontSize,
                          ),
                        ),
                        SizedBox(height: isMobile ? 12 : 20),
                        emojis.isEmpty
                            ? SizedBox(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.emoji_emotions_outlined,
                                      size: 48,
                                      color:
                                          widget.currentTheme['textSecondary'],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'لم يتم إضافة رموز تعبيرية بعد',
                                      style: TextStyle(
                                        color:
                                            widget
                                                .currentTheme['textSecondary'],
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'انقر على "إضافة رمز" للبدء',
                                      style: TextStyle(
                                        color:
                                            widget
                                                .currentTheme['textSecondary'],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    // Mobile: Shorter aspect, to avoid vertical overflow
                                    childAspectRatio: isMobile ? 0.78 : 0.90,
                                  ),
                              itemCount: emojis.length,
                              itemBuilder: (context, index) {
                                return _buildEmojiCard(
                                  emojis[index],
                                  index,
                                  cardWidth,
                                  emojiFontSize,
                                  iconSize,
                                  positionTextStyle,
                                  isMobile, // << pass to avoid overflow
                                );
                              },
                            ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 16 : 20),
                  Container(
                    padding: EdgeInsets.all(isMobile ? 12 : 16),
                    decoration: BoxDecoration(
                      color: widget.currentTheme['accent'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: widget.currentTheme['accent'].withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: widget.currentTheme['accent'],
                          size: headerIconSize,
                        ),
                        SizedBox(width: isMobile ? 8 : 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'نصائح إدارة الرموز التعبيرية',
                                style: TextStyle(
                                  color: widget.currentTheme['textPrimary'],
                                  fontSize: isMobile ? 12 : 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: isMobile ? 2 : 4),
                              Text(
                                '• أرقام الموضع تحدد ترتيب الرموز التعبيرية\n'
                                '• يمكن إضافة حد أقصى 20 رمز تعبيري\n'
                                '• يتم تطبيق التغييرات فوراً بعد الحفظ',
                                style: TextStyle(
                                  color: widget.currentTheme['textSecondary'],
                                  fontSize: isMobile ? 10 : 12,
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
            ),
          ),
        ],
      ),
    );
  }
}
