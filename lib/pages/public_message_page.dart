// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import '../widgets/enhanced_header.dart';

class PublicMessagePage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const PublicMessagePage({super.key, required this.currentTheme});

  @override
  _PublicMessagePageState createState() => _PublicMessagePageState();
}

class _PublicMessagePageState extends State<PublicMessagePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String selectedMessageType = 'popup'; // Default to popup
  bool isLoading = false;

  List<Map<String, dynamic>> sentMessages = [
    {
      'title': 'مرحباً بك في منصتنا',
      'message':
          'نحن متحمسون لانضمامك إلى مجتمعنا. يرجى أن تأخذ وقتك لاستكشاف جميع الميزات المتاحة لك.',
      'type': 'popup',
      'sentDate': '2024-08-05 14:30:00',
      'status': 'تم الإرسال',
    },
    {
      'title': 'إشعار الصيانة',
      'message':
          'ستخضع منصتنا لصيانة مجدولة يوم الأحد من الساعة 2:00 صباحاً إلى 4:00 صباحاً بتوقيت شرق الولايات المتحدة. خلال هذا الوقت، قد تكون بعض الميزات غير متاحة مؤقتاً.',
      'type': 'within_text',
      'sentDate': '2024-08-04 09:15:00',
      'status': 'تم الإرسال',
    },
    {
      'title': 'تحديث الميزات الجديدة',
      'message':
          'لقد أطلقنا للتو ميزات جديدة مثيرة تشمل قدرات دردشة محسّنة وواجهة مستخدم محسّنة. اكتشفها الآن!',
      'type': 'popup',
      'sentDate': '2024-08-03 16:45:00',
      'status': 'تم الإرسال',
    },
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
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
    String? hintText,
    required double fontSize,
    required double iconSize,
    required EdgeInsetsGeometry contentPadding,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: widget.currentTheme['textPrimary'],
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: fontSize * 0.6),
        Container(
          decoration: BoxDecoration(
            color: widget.currentTheme['mainBg'],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.currentTheme['textSecondary'].withOpacity(0.3),
            ),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: widget.currentTheme['textPrimary'],
              fontSize: fontSize,
            ),
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText ?? 'أدخل $label',
              hintStyle: TextStyle(
                color: widget.currentTheme['textSecondary'],
                fontSize: fontSize * 0.9,
              ),
              prefixIcon:
                  maxLines == 1
                      ? Icon(
                        icon,
                        color: widget.currentTheme['textSecondary'],
                        size: iconSize,
                      )
                      : null,
              border: InputBorder.none,
              contentPadding: contentPadding,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageTypeSelector({
    required double fontSizeTitle,
    required double fontSizeSubtitle,
    required double iconSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نوع الرسالة',
          style: TextStyle(
            color: widget.currentTheme['textPrimary'],
            fontSize: fontSizeTitle,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: fontSizeTitle * 0.6),
        Container(
          decoration: BoxDecoration(
            color: widget.currentTheme['mainBg'],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.currentTheme['textSecondary'].withOpacity(0.3),
            ),
          ),
          child: Column(
            children: [
              RadioListTile<String>(
                title: Row(
                  children: [
                    Icon(
                      Icons.window,
                      color: widget.currentTheme['textPrimary'],
                      size: iconSize,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'نافذة منبثقة',
                      style: TextStyle(
                        color: widget.currentTheme['textPrimary'],
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  'عرض الرسالة في نافذة حوار منبثقة',
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: fontSizeSubtitle,
                  ),
                ),
                value: 'popup',
                groupValue: selectedMessageType,
                activeColor: widget.currentTheme['accent'],
                onChanged: (String? value) {
                  setState(() {
                    selectedMessageType = value!;
                  });
                },
              ),
              Divider(
                color: widget.currentTheme['textSecondary'].withOpacity(0.2),
                height: 1,
              ),
              RadioListTile<String>(
                title: Row(
                  children: [
                    Icon(
                      Icons.text_snippet,
                      color: widget.currentTheme['textPrimary'],
                      size: iconSize,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'ضمن النص',
                      style: TextStyle(
                        color: widget.currentTheme['textPrimary'],
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  'عرض الرسالة ضمن واجهة التطبيق',
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: fontSizeSubtitle,
                  ),
                ),
                value: 'within_text',
                groupValue: selectedMessageType,
                activeColor: widget.currentTheme['accent'],
                onChanged: (String? value) {
                  setState(() {
                    selectedMessageType = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _sendMessage() async {
    if (_titleController.text.trim().isEmpty ||
        _messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('يرجى ملء جميع الحقول'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      sentMessages.insert(0, {
        'title': _titleController.text.trim(),
        'message': _messageController.text.trim(),
        'type': selectedMessageType,
        'sentDate': DateTime.now().toString(),
        'status': 'تم الإرسال',
      });
      isLoading = false;
    });

    // Clear form
    _titleController.clear();
    _messageController.clear();
    selectedMessageType = 'popup';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('تم إرسال الرسالة العامة بنجاح!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildMessageHistory({
    required double fontSizeTitle,
    required double fontSizeDate,
    required double fontSizeContent,
    required double iconSize,
    required double spacingVertical,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(spacingVertical * 2),
          child: Text(
            'سجل الرسائل',
            style: TextStyle(
              color: widget.currentTheme['textPrimary'],
              fontSize: fontSizeTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child:
              sentMessages.isEmpty
                  ? Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.message,
                            size: iconSize * 3.2,
                            color: widget.currentTheme['textSecondary'],
                          ),
                          SizedBox(height: spacingVertical * 1.5),
                          Text(
                            'لا توجد رسائل مُرسلة',
                            style: TextStyle(
                              fontSize: fontSizeTitle,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'ستظهر رسائلك المرسلة هنا',
                            style: TextStyle(
                              color: widget.currentTheme['textSecondary'],
                              fontSize: fontSizeContent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacingVertical * 2,
                    ),
                    itemCount: sentMessages.length,
                    itemBuilder: (context, index) {
                      final message = sentMessages[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spacingVertical * 1.5),
                        padding: EdgeInsets.all(spacingVertical * 1.8),
                        decoration: BoxDecoration(
                          color: widget.currentTheme['cardBg'],
                          borderRadius: BorderRadius.circular(12),
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
                                  padding: EdgeInsets.all(
                                    spacingVertical * 0.8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        message['type'] == 'popup'
                                            ? widget.currentTheme['accent']
                                                .withOpacity(0.1)
                                            : Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    message['type'] == 'popup'
                                        ? Icons.window
                                        : Icons.text_snippet,
                                    color:
                                        message['type'] == 'popup'
                                            ? widget.currentTheme['accent']
                                            : Colors.blue,
                                    size: iconSize,
                                  ),
                                ),
                                SizedBox(width: spacingVertical * 1.2),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message['title'],
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textPrimary'],
                                          fontSize: fontSizeTitle,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        message['sentDate'],
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textSecondary'],
                                          fontSize: fontSizeDate,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spacingVertical * 0.7,
                                    vertical: spacingVertical * 0.3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: Text(
                                    message['status'],
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: fontSizeDate * 0.8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spacingVertical * 1.2),
                            Text(
                              message['message'],
                              style: TextStyle(
                                color: widget.currentTheme['textSecondary'],
                                fontSize: fontSizeContent,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: spacingVertical * 0.8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spacingVertical * 0.7,
                                vertical: spacingVertical * 0.3,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    message['type'] == 'popup'
                                        ? widget.currentTheme['accent']
                                            .withOpacity(0.1)
                                        : Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                message['type'] == 'popup'
                                    ? 'نافذة منبثقة'
                                    : 'ضمن النص',
                                style: TextStyle(
                                  color:
                                      message['type'] == 'popup'
                                          ? widget.currentTheme['accent']
                                          : Colors.blue,
                                  fontSize: fontSizeDate * 0.7,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;

    // Define responsive sizes based on screen width
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    // Responsive font sizes
    final double fontSizeTitle =
        isMobile
            ? 14
            : isTablet
            ? 16
            : 18;
    final double fontSizeSubTitle =
        isMobile
            ? 12
            : isTablet
            ? 13
            : 14;
    final double fontSizeContent =
        isMobile
            ? 12
            : isTablet
            ? 14
            : 15;
    final double fontSizeButton =
        isMobile
            ? 14
            : isTablet
            ? 16
            : 18;
    final double fontSizeHeaderTitle =
        isMobile
            ? 22
            : isTablet
            ? 24
            : 26;
    final double fontSizeHeaderSubtitle =
        isMobile
            ? 14
            : isTablet
            ? 16
            : 18;
    final double iconSizeSmall =
        isMobile
            ? 18
            : isTablet
            ? 20
            : 22;
    final double iconSizeMedium =
        isMobile
            ? 20
            : isTablet
            ? 24
            : 26;
    final double iconSizeLarge =
        isMobile
            ? 24
            : isTablet
            ? 28
            : 30;
    final double spacingVertical =
        isMobile
            ? 12
            : isTablet
            ? 16
            : 20;

    // Responsive layout paddings
    final double containerMargin =
        isMobile
            ? 12
            : isTablet
            ? 16
            : 20;
    final double containerPadding =
        isMobile
            ? 16
            : isTablet
            ? 20
            : 24;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(
        top: containerMargin,
        right: containerMargin,
        bottom: containerMargin,
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
            title: 'الرسائل العامة',
            subtitle: 'إرسال الرسائل لجميع المستخدمين',
            description: 'بث الرسائل المهمة لقاعدة المستخدمين بأكملها',
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Determine layout based on width to maintain existing structure but be responsive
                bool verticalLayout = constraints.maxWidth < 900;

                if (verticalLayout) {
                  // Vertical layout for smaller widths (mobile/tablet portrait)
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: containerMargin,
                      vertical: containerMargin,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Message Form Section
                        Container(
                          margin: EdgeInsets.only(bottom: containerMargin),
                          padding: EdgeInsets.all(containerPadding),
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
                                    padding: EdgeInsets.all(spacingVertical),
                                    decoration: BoxDecoration(
                                      color: widget.currentTheme['accent'],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.campaign,
                                      color: Colors.white,
                                      size: iconSizeLarge,
                                    ),
                                  ),
                                  SizedBox(width: spacingVertical),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'كتابة رسالة',
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textPrimary'],
                                          fontSize: fontSizeHeaderTitle,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'إرسال رسالة لجميع المستخدمين',
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textSecondary'],
                                          fontSize: fontSizeHeaderSubtitle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: spacingVertical * 2),

                              _buildFormField(
                                label: 'عنوان الرسالة',
                                controller: _titleController,
                                icon: Icons.title,
                                hintText: 'أدخل عنواناً جذاباً للرسالة',
                                fontSize: fontSizeContent,
                                iconSize: iconSizeSmall,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),

                              SizedBox(height: spacingVertical * 1.5),

                              _buildFormField(
                                label: 'محتوى الرسالة',
                                controller: _messageController,
                                icon: Icons.message,
                                maxLines: 8,
                                hintText: 'أدخل محتوى الرسالة هنا...',
                                fontSize: fontSizeContent,
                                iconSize: iconSizeSmall,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),

                              SizedBox(height: spacingVertical * 1.5),

                              _buildMessageTypeSelector(
                                fontSizeTitle: fontSizeTitle,
                                fontSizeSubtitle: fontSizeSubTitle,
                                iconSize: iconSizeSmall,
                              ),

                              SizedBox(height: spacingVertical * 2),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: isLoading ? null : _sendMessage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        widget.currentTheme['accent'],
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child:
                                      isLoading
                                          ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Colors.white,
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                'جاري الإرسال...',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: fontSizeButton,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )
                                          : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.send,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'نشر الرسالة',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: fontSizeButton,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Message History Section
                        Container(
                          height:
                              constraints.maxHeight *
                              0.65, // reasonable height for history
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
                          child: _buildMessageHistory(
                            fontSizeTitle: fontSizeTitle,
                            fontSizeDate: fontSizeSubTitle,
                            fontSizeContent: fontSizeContent,
                            iconSize: iconSizeMedium,
                            spacingVertical: spacingVertical,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Horizontal layout for tablet landscape and desktop
                  return Padding(
                    padding: EdgeInsets.only(
                      top: containerMargin,
                      right: containerMargin,
                      bottom: containerMargin,
                      left: containerMargin,
                    ),
                    child: Row(
                      children: [
                        // Message Form Section
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(containerPadding),
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
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                          spacingVertical,
                                        ),
                                        decoration: BoxDecoration(
                                          color: widget.currentTheme['accent'],
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.campaign,
                                          color: Colors.white,
                                          size: iconSizeLarge,
                                        ),
                                      ),
                                      SizedBox(width: spacingVertical),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'كتابة رسالة',
                                            style: TextStyle(
                                              color:
                                                  widget
                                                      .currentTheme['textPrimary'],
                                              fontSize: fontSizeHeaderTitle,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'إرسال رسالة لجميع المستخدمين',
                                            style: TextStyle(
                                              color:
                                                  widget
                                                      .currentTheme['textSecondary'],
                                              fontSize: fontSizeHeaderSubtitle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spacingVertical * 2),

                                  _buildFormField(
                                    label: 'عنوان الرسالة',
                                    controller: _titleController,
                                    icon: Icons.title,
                                    hintText: 'أدخل عنواناً جذاباً للرسالة',
                                    fontSize: fontSizeContent,
                                    iconSize: iconSizeSmall,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),

                                  SizedBox(height: spacingVertical * 1.8),

                                  _buildFormField(
                                    label: 'محتوى الرسالة',
                                    controller: _messageController,
                                    icon: Icons.message,
                                    maxLines: 8,
                                    hintText: 'أدخل محتوى الرسالة هنا...',
                                    fontSize: fontSizeContent,
                                    iconSize: iconSizeSmall,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),

                                  SizedBox(height: spacingVertical * 1.8),

                                  _buildMessageTypeSelector(
                                    fontSizeTitle: fontSizeTitle,
                                    fontSizeSubtitle: fontSizeSubTitle,
                                    iconSize: iconSizeSmall,
                                  ),

                                  SizedBox(height: spacingVertical * 2.5),

                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed:
                                          isLoading ? null : _sendMessage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            widget.currentTheme['accent'],
                                        padding: EdgeInsets.symmetric(
                                          vertical: 18,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child:
                                          isLoading
                                              ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 2,
                                                        ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Text(
                                                    'جاري الإرسال...',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: fontSizeButton,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              )
                                              : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.send,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'نشر الرسالة',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: fontSizeButton,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: containerMargin),

                        // Message History Section
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 0,
                              right: 0,
                              bottom: 0,
                            ),
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
                            child: _buildMessageHistory(
                              fontSizeTitle: fontSizeTitle,
                              fontSizeDate: fontSizeSubTitle,
                              fontSizeContent: fontSizeContent,
                              iconSize: iconSizeMedium,
                              spacingVertical: spacingVertical,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
