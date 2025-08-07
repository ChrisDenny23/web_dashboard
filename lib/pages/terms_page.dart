// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import '../widgets/enhanced_header.dart';

class AppTermsPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const AppTermsPage({super.key, required this.currentTheme});

  @override
  _AppTermsPageState createState() => _AppTermsPageState();
}

class _AppTermsPageState extends State<AppTermsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  bool isEditing = false;
  bool isLoading = false;

  Map<String, TextEditingController> controllers = {};

  Map<String, String> termsData = {
    'lastUpdated': '2024-08-06',
    'effectiveDate': '2024-01-01',
    'version': '2.1',
    'introduction':
        '''مرحباً بك في منصتنا. تحكم شروط الخدمة هذه ("الشروط") استخدامك لتطبيقنا وخدماتنا. من خلال الوصول إلى خدمتنا أو استخدامها، فإنك توافق على الالتزام بهذه الشروط. إذا كنت لا توافق على أي جزء من هذه الشروط، فلا يجوز لك الوصول إلى الخدمة.''',

    'acceptanceOfTerms':
        '''من خلال إنشاء حساب أو استخدام خدماتنا بأي شكل من الأشكال، فإنك تقر بأنك قد قرأت وفهمت ووافقت على الالتزام بشروط الخدمة هذه وسياسة الخصوصية الخاصة بنا. تشكل هذه الشروط اتفاقية ملزمة قانونياً بينك وبين شركتنا.''',

    'userAccounts':
        '''للوصول إلى ميزات معينة في خدمتنا، يجب عليك إنشاء حساب. أنت مسؤول عن:
• المحافظة على سرية بيانات اعتماد حسابك
• جميع الأنشطة التي تحدث تحت حسابك
• تقديم معلومات دقيقة وكاملة
• تحديث معلوماتك حسب الضرورة
• إشعارنا فوراً بأي استخدام غير مصرح به لحسابك''',

    'userConduct': '''توافق على عدم استخدام خدمتنا لـ:
• انتهاك أي قوانين أو لوائح معمول بها
• مضايقة أو إساءة معاملة أو إيذاء المستخدمين الآخرين
• نقل الرسائل غير المرغوب فيها أو الفيروسات أو التعليمات البرمجية الضارة
• انتحال شخصية الآخرين أو تقديم معلومات خاطئة
• التدخل في الأداء السليم لخدمتنا
• الوصول أو محاولة الوصول إلى حسابات المستخدمين الآخرين
• استخدام الأنظمة الآلية للوصول إلى خدمتنا دون إذن''',

    'contentPolicy':
        '''يمكن للمستخدمين نشر المحتوى على منصتنا وفقاً لهذه الإرشادات:
• يجب ألا يكون المحتوى غير قانوني أو ضار أو مسيء
• تحتفظ بملكية محتواك ولكنك تمنحنا ترخيصاً لاستخدامه
• قد نقوم بإزالة المحتوى الذي يخالف سياساتنا
• أنت مسؤول عن محتواك وعواقبه
• احترم حقوق الملكية الفكرية للآخرين
• أبلغ عن المحتوى غير المناسب من خلال نظام الإبلاغ الخاص بنا''',

    'privacyAndData':
        '''خصوصيتك مهمة بالنسبة لنا. تشرح سياسة الخصوصية الخاصة بنا كيف نجمع ونستخدم ونحمي معلوماتك. باستخدام خدمتنا، فإنك توافق على ممارسات البيانات الخاصة بنا كما هو موضح في سياسة الخصوصية الخاصة بنا. نحن ننفذ تدابير أمنية مناسبة لحماية معلوماتك الشخصية.''',

    'serviceAvailability':
        '''نحن نسعى جاهدين لتقديم خدمة موثوقة ولكن لا يمكننا ضمان:
• الوصول المستمر إلى خدمتنا
• الدقة الكاملة لجميع المعلومات
• الخلو من المشاكل التقنية أو التوقف عن العمل
• التوافق مع جميع الأجهزة أو الأنظمة
نحتفظ بالحق في تعديل أو تعليق أو إيقاف خدمتنا في أي وقت.''',

    'intellectualProperty':
        '''جميع المحتويات والميزات ووظائف خدمتنا مملوكة لنا أو لمرخصينا ومحمية بموجب قوانين حقوق الطبع والنشر والعلامات التجارية وقوانين الملكية الفكرية الأخرى. لا يجوز لك نسخ أو تعديل أو توزيع أو إجراء هندسة عكسية لأي جزء من خدمتنا دون إذن صريح.''',

    'limitations':
        '''إلى أقصى حد يسمح به القانون، نحن نخلي مسؤوليتنا عن جميع الضمانات ونحد من مسؤوليتنا عن:
• الأضرار غير المباشرة أو العارضة أو التبعية
• فقدان البيانات أو الأرباح أو الفرص التجارية
• الأضرار الناتجة عن استخدامك أو عدم قدرتك على استخدام خدمتنا
• محتوى أو إجراءات طرف ثالث
لا تتجاوز مسؤوليتنا الإجمالية المبلغ الذي دفعته مقابل خدمتنا.''',

    'termination':
        '''يمكننا إنهاء أو تعليق حسابك والوصول إلى خدمتنا فوراً، دون إشعار مسبق، لأي سبب، بما في ذلك:
• انتهاك هذه الشروط
• انتهاك القوانين المعمول بها
• السلوك الضار أو المدمر
• الخمول لفترة طويلة
عند الإنهاء، ينتهي حقك في استخدام خدمتنا فوراً.''',

    'changesTerms':
        '''نحتفظ بالحق في تعديل هذه الشروط في أي وقت. سنقوم بإخطار المستخدمين بالتغييرات المهمة من خلال:
• إشعارات البريد الإلكتروني للمستخدمين المسجلين
• الإشعارات داخل التطبيق
• التحديثات على موقعنا الإلكتروني
الاستمرار في استخدام خدمتنا بعد التغييرات يشكل قبولاً للشروط الجديدة.''',

    'governingLaw':
        '''تخضع هذه الشروط وتُفسر وفقاً لقوانين [الولاية القضائية الخاصة بك]، دون اعتبار لمبادئ تضارب القوانين. أي نزاعات تنشأ من هذه الشروط يجب حلها في محاكم [الولاية القضائية الخاصة بك].''',

    'contactInformation':
        '''إذا كان لديك أسئلة حول هذه الشروط، يرجى الاتصال بنا على:
البريد الإلكتروني: legal@yourcompany.com
العنوان: [عنوان شركتك]
الهاتف: [رقم هاتفك]

سنرد على الاستفسارات خلال 48 ساعة خلال أيام العمل.''',
  };

  Map<String, String> sectionTitles = {
    'introduction': 'المقدمة',
    'acceptanceOfTerms': 'قبول الشروط',
    'userAccounts': 'حسابات المستخدمين والتسجيل',
    'userConduct': 'سلوك المستخدم والأنشطة المحظورة',
    'contentPolicy': 'سياسة المحتوى والإرشادات',
    'privacyAndData': 'الخصوصية وحماية البيانات',
    'serviceAvailability': 'توفر الخدمة والموثوقية',
    'intellectualProperty': 'حقوق الملكية الفكرية',
    'limitations': 'تحديد المسؤولية',
    'termination': 'إنهاء الحساب',
    'changesTerms': 'التغييرات على الشروط',
    'governingLaw': 'القانون الحاكم والاختصاص',
    'contactInformation': 'معلومات الاتصال',
  };

  Map<String, IconData> sectionIcons = {
    'introduction': Icons.info_outline,
    'acceptanceOfTerms': Icons.check_circle_outline,
    'userAccounts': Icons.account_circle_outlined,
    'userConduct': Icons.gavel_outlined,
    'contentPolicy': Icons.policy_outlined,
    'privacyAndData': Icons.security_outlined,
    'serviceAvailability': Icons.cloud_outlined,
    'intellectualProperty': Icons.copyright_outlined,
    'limitations': Icons.warning_amber_outlined,
    'termination': Icons.cancel_outlined,
    'changesTerms': Icons.update_outlined,
    'governingLaw': Icons.balance_outlined,
    'contactInformation': Icons.contact_support_outlined,
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();

    // Initialize controllers
    termsData.forEach((key, value) {
      controllers[key] = TextEditingController(text: value);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        // Reset controllers if canceling edit
        termsData.forEach((key, value) {
          controllers[key]!.text = value;
        });
      }
    });
  }

  void _saveTerms() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      // Update terms data with controller values
      controllers.forEach((key, controller) {
        termsData[key] = controller.text;
      });

      // Update last updated date
      termsData['lastUpdated'] = DateTime.now().toString().substring(0, 10);
      controllers['lastUpdated']!.text = termsData['lastUpdated']!;

      isEditing = false;
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم تحديث الشروط والأحكام بنجاح!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.currentTheme['cardBg'],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: widget.currentTheme['shadow'],
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: widget.currentTheme['accent'], size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: widget.currentTheme['textPrimary'],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: widget.currentTheme['textSecondary'],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection(String key, String title, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: widget.currentTheme['cardBg'],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: widget.currentTheme['shadow'],
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: widget.currentTheme['accent'].withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.currentTheme['accent'],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: widget.currentTheme['textPrimary'],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child:
                isEditing
                    ? TextField(
                      controller: controllers[key],
                      maxLines: null,
                      style: TextStyle(
                        color: widget.currentTheme['textPrimary'],
                        fontSize: 14,
                        height: 1.5,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: widget.currentTheme['textSecondary']
                                .withOpacity(0.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: widget.currentTheme['textSecondary']
                                .withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: widget.currentTheme['accent'],
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: widget.currentTheme['mainBg'],
                        contentPadding: EdgeInsets.all(16),
                      ),
                    )
                    : SelectableText(
                      termsData[key]!,
                      style: TextStyle(
                        color: widget.currentTheme['textSecondary'],
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(top: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.currentTheme['mainBg'],
        boxShadow: [
          BoxShadow(
            color: widget.currentTheme['shadow'],
            blurRadius: 30,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          EnhancedHeader(
            currentTheme: widget.currentTheme,
            title: 'شروط وأحكام التطبيق',
            subtitle: 'الشروط القانونية واتفاقية الخدمة',
            description: 'إدارة وتحديث شروط الخدمة الخاصة بتطبيقك',
          ),

          // Stats Cards
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    'الإصدار',
                    termsData['version']!,
                    Icons.tag,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    'آخر تحديث',
                    termsData['lastUpdated']!,
                    Icons.update,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    'تاريخ النفاذ',
                    termsData['effectiveDate']!,
                    Icons.calendar_today,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    'مجموع الأقسام',
                    (termsData.length - 3).toString(),
                    Icons.article,
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                if (!isEditing) ...[
                  ElevatedButton.icon(
                    onPressed: _toggleEditMode,
                    icon: Icon(Icons.edit, color: Colors.white),
                    label: Text(
                      'تعديل الشروط',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.currentTheme['accent'],
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Spacer(),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Preview functionality could be added here
                    },
                    icon: Icon(
                      Icons.preview,
                      color: widget.currentTheme['textSecondary'],
                    ),
                    label: Text(
                      'معاينة',
                      style: TextStyle(
                        color: widget.currentTheme['textSecondary'],
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: widget.currentTheme['textSecondary'].withOpacity(
                          0.3,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  ElevatedButton.icon(
                    onPressed: isLoading ? null : _saveTerms,
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
                            : Icon(Icons.save, color: Colors.white),
                    label: Text(
                      isLoading ? 'جاري الحفظ...' : 'حفظ التغييرات',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: isLoading ? null : _toggleEditMode,
                    icon: Icon(Icons.cancel, color: Colors.red),
                    label: Text('إلغاء', style: TextStyle(color: Colors.red)),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                  Spacer(),
                ],
              ],
            ),
          ),

          // Terms Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Build all terms sections except metadata
                  ...sectionTitles.entries
                      .where(
                        (entry) =>
                            ![
                              'lastUpdated',
                              'effectiveDate',
                              'version',
                            ].contains(entry.key),
                      )
                      .map(
                        (entry) => _buildTermsSection(
                          entry.key,
                          entry.value,
                          sectionIcons[entry.key]!,
                        ),
                      ),

                  SizedBox(height: 20),

                  // Footer
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: widget.currentTheme['cardBg'],
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
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'هذه الشروط ملزمة قانونياً. يرجى التأكد من دقة جميع المعلومات قبل النشر.',
                            style: TextStyle(
                              color: widget.currentTheme['textSecondary'],
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
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
