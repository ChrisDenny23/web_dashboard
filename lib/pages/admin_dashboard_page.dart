// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../widgets/enhanced_header.dart';

class AdminDashboardPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const AdminDashboardPage({super.key, required this.currentTheme});

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  List<Map<String, dynamic>> admins = [
    {
      'name': 'أحمد محمد',
      'email': 'ahmed.admin@example.com',
      'password': 'admin123',
      'permissions': {
        'roomManagement': true,
        'groupsCountries': true,
        'supportAdminNames': true,
        'files': true,
        'loginLogout': true,
        'adminPanel': true,
        'bannedSuspended': false,
        'reports': true,
        'loginIcons': false,
        'appDesign': false,
        'appTerms': true,
        'generalMessages': true,
        'appSettings': false,
      },
      'status': 'نشط',
      'createdDate': '2024-01-10',
      'lastActive': '2024-08-05 15:30:00',
    },
    {
      'name': 'فاطمة أحمد',
      'email': 'fatima.manager@example.com',
      'password': 'manager456',
      'permissions': {
        'roomManagement': false,
        'groupsCountries': true,
        'supportAdminNames': false,
        'files': true,
        'loginLogout': true,
        'adminPanel': false,
        'bannedSuspended': true,
        'reports': true,
        'loginIcons': true,
        'appDesign': true,
        'appTerms': false,
        'generalMessages': true,
        'appSettings': true,
      },
      'status': 'نشط',
      'createdDate': '2024-02-15',
      'lastActive': '2024-08-05 12:45:00',
    },
  ];

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredAdmins {
    return admins.where((admin) {
      return admin['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          admin['email'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'نشط':
        return Colors.green;
      case 'غير نشط':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'نشط':
        return Icons.check_circle;
      case 'غير نشط':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
    double fontSize = 14,
    EdgeInsetsGeometry? contentPadding,
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
          textDirection: TextDirection.rtl,
        ),
        SizedBox(height: 8),
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
            textDirection:
                keyboardType == TextInputType.emailAddress
                    ? TextDirection.ltr
                    : TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'أدخل $label',
              hintStyle: TextStyle(
                color: widget.currentTheme['textSecondary'],
                fontSize: fontSize,
              ),
              prefixIcon: Icon(
                icon,
                color: widget.currentTheme['textSecondary'],
                size: fontSize + 4,
              ),
              border: InputBorder.none,
              contentPadding:
                  contentPadding ??
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionCheckbox({
    required String title,
    required String description,
    required IconData icon,
    required bool value,
    required Function(bool?) onChanged,
    double titleFontSize = 14,
    double descFontSize = 12,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.currentTheme['mainBg'],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              value
                  ? widget.currentTheme['accent'].withOpacity(0.3)
                  : widget.currentTheme['textSecondary'].withOpacity(0.2),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: widget.currentTheme['accent'],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: widget.currentTheme['textPrimary'],
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: descFontSize,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Icon(
            icon,
            color:
                value
                    ? widget.currentTheme['accent']
                    : widget.currentTheme['textSecondary'],
            size: 24,
          ),
        ],
      ),
    );
  }

  void _showAddAdminDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    Map<String, bool> permissions = {
      'roomManagement': false,
      'groupsCountries': false,
      'supportAdminNames': false,
      'files': false,
      'loginLogout': false,
      'adminPanel': false,
      'bannedSuspended': false,
      'reports': false,
      'loginIcons': false,
      'appDesign': false,
      'appTerms': false,
      'generalMessages': false,
      'appSettings': false,
    };

    _showAdminDialog(
      title: 'إضافة مدير جديد',
      subtitle: 'إعداد حساب المدير والصلاحيات',
      nameController: nameController,
      emailController: emailController,
      passwordController: passwordController,
      permissions: permissions,
      onSave: () {
        if (nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          setState(() {
            admins.add({
              'name': nameController.text,
              'email': emailController.text,
              'password': passwordController.text,
              'permissions': Map.from(permissions),
              'status': 'نشط',
              'createdDate': DateTime.now().toString().substring(0, 10),
              'lastActive': DateTime.now().toString(),
            });
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم إضافة المدير بنجاح!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
    );
  }

  void _showEditAdminDialog(Map<String, dynamic> admin, int adminIndex) {
    final nameController = TextEditingController(text: admin['name']);
    final emailController = TextEditingController(text: admin['email']);
    final passwordController = TextEditingController(text: admin['password']);

    Map<String, bool> permissions = Map.from(admin['permissions']);

    _showAdminDialog(
      title: 'تحرير المدير',
      subtitle: 'تحديث حساب المدير والصلاحيات',
      nameController: nameController,
      emailController: emailController,
      passwordController: passwordController,
      permissions: permissions,
      onSave: () {
        if (nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          setState(() {
            admins[adminIndex] = {
              ...admin,
              'name': nameController.text,
              'email': emailController.text,
              'password': passwordController.text,
              'permissions': Map.from(permissions),
            };
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم تحديث المدير بنجاح!'),
              backgroundColor: Colors.blue,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
    );
  }

  void _showAdminDialog({
    required String title,
    required String subtitle,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required Map<String, bool> permissions,
    required VoidCallback onSave,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive dialog width
    double dialogWidth =
        screenWidth < 600
            ? screenWidth * 0.9
            : screenWidth < 900
            ? 600
            : 700;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: dialogWidth,
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: BoxDecoration(
                        color: widget.currentTheme['cardBg'],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: widget.currentTheme['shadow'],
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Header
                          Container(
                            padding: EdgeInsets.all(24),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                    Icons.close,
                                    color: widget.currentTheme['textSecondary'],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textPrimary'],
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        subtitle,
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textSecondary'],
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: widget.currentTheme['accent'],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.admin_panel_settings,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Scrollable Form Content
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  double fontSizeLabel = 14;
                                  double fontSizeDesc = 12;
                                  double verticalPadding = 16;

                                  if (constraints.maxWidth < 400) {
                                    fontSizeLabel = 12;
                                    fontSizeDesc = 10;
                                    verticalPadding = 12;
                                  } else if (constraints.maxWidth > 700) {
                                    fontSizeLabel = 16;
                                    fontSizeDesc = 14;
                                    verticalPadding = 20;
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'معلومات المدير',
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textPrimary'],
                                          fontSize: fontSizeLabel + 4,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      SizedBox(height: verticalPadding),

                                      _buildFormField(
                                        label: 'الاسم الكامل',
                                        controller: nameController,
                                        icon: Icons.person,
                                        fontSize: fontSizeLabel,
                                      ),
                                      SizedBox(height: verticalPadding),

                                      _buildFormField(
                                        label: 'عنوان البريد الإلكتروني',
                                        controller: emailController,
                                        icon: Icons.email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        fontSize: fontSizeLabel,
                                      ),
                                      SizedBox(height: verticalPadding),

                                      _buildFormField(
                                        label: 'كلمة المرور',
                                        controller: passwordController,
                                        icon: Icons.lock,
                                        obscureText: true,
                                        fontSize: fontSizeLabel,
                                      ),
                                      SizedBox(height: verticalPadding * 1.5),

                                      Text(
                                        'صلاحيات المدير',
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textPrimary'],
                                          fontSize: fontSizeLabel + 4,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      SizedBox(height: verticalPadding),

                                      _buildPermissionCheckbox(
                                        title: 'إدارة الغرف',
                                        description:
                                            'إدارة غرف الدردشة وإعدادات الغرف',
                                        icon: Icons.meeting_room,
                                        value: permissions['roomManagement']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['roomManagement'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'المجموعات والدول',
                                        description:
                                            'إدارة مجموعات المستخدمين وإعدادات الدول',
                                        icon: Icons.group,
                                        value: permissions['groupsCountries']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['groupsCountries'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'أسماء الدعم والمديرين',
                                        description:
                                            'إدارة موظفي الدعم وحسابات المديرين',
                                        icon: Icons.support_agent,
                                        value:
                                            permissions['supportAdminNames']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['supportAdminNames'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'الملفات',
                                        description: 'إدارة رفع وتنزيل الملفات',
                                        icon: Icons.folder,
                                        value: permissions['files']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['files'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'تسجيل الدخول والخروج',
                                        description:
                                            'إدارة مصادقة المستخدمين والجلسات',
                                        icon: Icons.login,
                                        value: permissions['loginLogout']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['loginLogout'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'لوحة المديرين',
                                        description:
                                            'الوصول إلى لوحة المديرين ولوحة التحكم',
                                        icon: Icons.dashboard,
                                        value: permissions['adminPanel']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['adminPanel'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'المحظورين والمعلقين',
                                        description:
                                            'إدارة المستخدمين المحظورين والمعلقين',
                                        icon: Icons.block,
                                        value: permissions['bannedSuspended']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['bannedSuspended'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'التقارير',
                                        description:
                                            'عرض وإدارة تقارير المستخدمين',
                                        icon: Icons.report,
                                        value: permissions['reports']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['reports'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'أيقونات تسجيل الدخول',
                                        description:
                                            'إدارة أيقونات شاشة تسجيل الدخول والعلامة التجارية',
                                        icon: Icons.account_circle,
                                        value: permissions['loginIcons']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['loginIcons'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'تصميم التطبيق',
                                        description:
                                            'تخصيص تصميم التطبيق والثيمات',
                                        icon: Icons.palette,
                                        value: permissions['appDesign']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['appDesign'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'شروط التطبيق',
                                        description:
                                            'إدارة شروط التطبيق والأحكام',
                                        icon: Icons.article,
                                        value: permissions['appTerms']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['appTerms'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'الرسائل العامة',
                                        description:
                                            'إرسال رسائل عامة لجميع المستخدمين',
                                        icon: Icons.message,
                                        value: permissions['generalMessages']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['generalMessages'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      _buildPermissionCheckbox(
                                        title: 'إعدادات التطبيق',
                                        description:
                                            'تكوين الإعدادات العامة للتطبيق',
                                        icon: Icons.settings,
                                        value: permissions['appSettings']!,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            permissions['appSettings'] =
                                                value ?? false;
                                          });
                                        },
                                        titleFontSize: fontSizeLabel,
                                        descFontSize: fontSizeDesc,
                                      ),
                                      SizedBox(height: verticalPadding * 2),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),

                          // Action Buttons
                          Container(
                            padding: EdgeInsets.all(24),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                          color: widget
                                              .currentTheme['textSecondary']
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'إلغاء',
                                      style: TextStyle(
                                        color:
                                            widget
                                                .currentTheme['textSecondary'],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: onSave,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          widget.currentTheme['accent'],
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      title.contains('إضافة')
                                          ? 'إضافة المدير'
                                          : 'تحديث المدير',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                ),
          ),
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    double fontSizeTitle,
    double fontSizeValue,
  ) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.currentTheme['cardBg'],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: fontSizeTitle,
                color: widget.currentTheme['textSecondary'],
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: widget.currentTheme['textSecondary'],
                  fontSize: fontSizeTitle,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: widget.currentTheme['textPrimary'],
              fontSize: fontSizeValue,
              fontWeight: FontWeight.w600,
            ),
            textDirection:
                value.contains('@') ? TextDirection.ltr : TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionBadge(
    String permission,
    bool enabled,
    double fontSize,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 8, bottom: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            enabled
                ? widget.currentTheme['accent'].withOpacity(0.1)
                : widget.currentTheme['textSecondary'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              enabled
                  ? widget.currentTheme['accent']
                  : widget.currentTheme['textSecondary'],
          width: 1,
        ),
      ),
      child: Text(
        permission,
        style: TextStyle(
          color:
              enabled
                  ? widget.currentTheme['accent']
                  : widget.currentTheme['textSecondary'],
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAdminsList(double width) {
    if (filteredAdmins.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.admin_panel_settings,
              size: width < 400 ? 48 : 64,
              color: widget.currentTheme['accent'],
            ),
            SizedBox(height: 16),
            Text(
              'لا يوجد مشرفين',
              style: TextStyle(
                fontSize: width < 400 ? 16 : 20,
                fontWeight: FontWeight.bold,
                color: widget.currentTheme['textPrimary'],
              ),
            ),
            Text(
              'حاول تعديل البحث أو إضافة مشرف جديد',
              style: TextStyle(color: widget.currentTheme['textSecondary']),
            ),
          ],
        ),
      );
    }

    double fontSizeTitle = width < 400 ? 14 : 18;
    double fontSizeSubtitle = width < 400 ? 10 : 12;
    double badgeFontSize = width < 400 ? 8 : 10;
    double iconSize = width < 400 ? 20 : 24;

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: width < 400 ? 12 : 20),
      itemCount: filteredAdmins.length,
      itemBuilder: (context, index) {
        final admin = filteredAdmins[index];
        final adminIndex = admins.indexOf(admin);
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.only(bottom: 12),
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
          child: ExpansionTile(
            tilePadding: EdgeInsets.all(width < 400 ? 8 : 16),
            childrenPadding: EdgeInsets.all(width < 400 ? 8 : 16),
            leading: Container(
              width: width < 400 ? 50 : 60,
              height: width < 400 ? 50 : 60,
              decoration: BoxDecoration(
                color: getStatusColor(admin['status']),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.admin_panel_settings,
                color: Colors.white,
                size: iconSize + 4,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  admin['email'],
                  style: TextStyle(
                    color: widget.currentTheme['accent'],
                    fontSize: fontSizeTitle - 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  admin['name'],
                  style: TextStyle(
                    color: widget.currentTheme['textPrimary'],
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeTitle,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  'تاريخ الإنشاء: ${admin['createdDate']}',
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: fontSizeSubtitle,
                  ),
                ),
                Text(
                  'آخر نشاط: ${admin['lastActive']}',
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: fontSizeSubtitle,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(admin['status']),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        getStatusIcon(admin['status']),
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        admin['status'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: PopupMenuButton(
              color: widget.currentTheme['cardBg'],
              icon: Icon(
                Icons.more_vert,
                color: widget.currentTheme['textSecondary'],
                size: iconSize,
              ),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: widget.currentTheme['textPrimary'],
                            size: iconSize - 4,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'تعديل',
                            style: TextStyle(
                              color: widget.currentTheme['textPrimary'],
                              fontSize: fontSizeSubtitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: iconSize - 4,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'حذف',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: fontSizeSubtitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _showEditAdminDialog(admin, adminIndex);
                    break;
                  case 'delete':
                    setState(() {
                      admins.remove(admin);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم حذف المشرف بنجاح!'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    break;
                }
              },
            ),
            children: [
              Container(
                padding: EdgeInsets.all(width < 400 ? 8 : 16),
                decoration: BoxDecoration(
                  color: widget.currentTheme['mainBg'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            'البريد الإلكتروني',
                            admin['email'],
                            Icons.email,
                            fontSizeSubtitle,
                            fontSizeTitle - 2,
                          ),
                        ),
                        SizedBox(width: width < 400 ? 8 : 12),
                        Expanded(
                          child: _buildInfoCard(
                            'كلمة المرور',
                            '••••••••',
                            Icons.lock,
                            fontSizeSubtitle,
                            fontSizeTitle - 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width < 400 ? 8 : 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            'تاريخ الإنشاء',
                            admin['createdDate'],
                            Icons.calendar_today,
                            fontSizeSubtitle,
                            fontSizeTitle - 2,
                          ),
                        ),
                        SizedBox(width: width < 400 ? 8 : 12),
                        Expanded(
                          child: _buildInfoCard(
                            'آخر نشاط',
                            admin['lastActive'],
                            Icons.access_time,
                            fontSizeSubtitle,
                            fontSizeTitle - 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width < 400 ? 12 : 16),

                    Text(
                      'صلاحيات المشرف',
                      style: TextStyle(
                        color: widget.currentTheme['textPrimary'],
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      children: [
                        if (admin['permissions']['roomManagement'])
                          _buildPermissionBadge(
                            'إدارة الغرف',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['groupsCountries'])
                          _buildPermissionBadge(
                            'المجموعات والبلدان',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['supportAdminNames'])
                          _buildPermissionBadge(
                            'الدعم وأسماء المشرفين',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['files'])
                          _buildPermissionBadge('الملفات', true, badgeFontSize),
                        if (admin['permissions']['loginLogout'])
                          _buildPermissionBadge(
                            'تسجيل الدخول والخروج',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['adminPanel'])
                          _buildPermissionBadge(
                            'لوحة المشرف',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['bannedSuspended'])
                          _buildPermissionBadge(
                            'المحظور والمعلق',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['reports'])
                          _buildPermissionBadge(
                            'التقارير',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['loginIcons'])
                          _buildPermissionBadge(
                            'أيقونات تسجيل الدخول',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['appDesign'])
                          _buildPermissionBadge(
                            'تصميم التطبيق',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['appTerms'])
                          _buildPermissionBadge(
                            'شروط التطبيق',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['generalMessages'])
                          _buildPermissionBadge(
                            'الرسائل العامة',
                            true,
                            badgeFontSize,
                          ),
                        if (admin['permissions']['appSettings'])
                          _buildPermissionBadge(
                            'إعدادات التطبيق',
                            true,
                            badgeFontSize,
                          ),
                      ],
                    ),
                    if (admin['permissions'].values.every((v) => !v))
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: widget.currentTheme['textSecondary']
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'لا توجد صلاحيات مفعلة',
                          style: TextStyle(
                            color: widget.currentTheme['textSecondary'],
                            fontStyle: FontStyle.italic,
                            fontSize: badgeFontSize,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive padding & font sizing
    EdgeInsetsGeometry mainMargin = EdgeInsets.only(
      top: 16,
      left: 16,
      bottom: 16,
    );
    if (screenWidth < 600) {
      mainMargin = EdgeInsets.symmetric(horizontal: 8, vertical: 8);
    } else if (screenWidth > 1200) {
      mainMargin = EdgeInsets.symmetric(horizontal: 40, vertical: 20);
    }

    double titleFontSize = screenWidth < 600 ? 18 : 20;
    double subtitleFontSize = screenWidth < 600 ? 12 : 14;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: mainMargin,
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
              title: 'لوحة تحكم المديرين',
              subtitle: 'إدارة المديرين',
              description: 'إدارة حسابات المديرين والصلاحيات',
              titleFontSize: titleFontSize,
              subtitleFontSize: subtitleFontSize,
            ),

            // Stats Cards with adaptive layout
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth < 600 ? 12 : 20,
                vertical: 10,
              ),
              child:
                  screenWidth < 600
                      ? Column(
                        children: [
                          _buildStatCard(
                            Icons.admin_panel_settings,
                            admins.length.toString(),
                            'إجمالي المديرين',
                          ),
                          SizedBox(height: 12),
                          _buildStatCard(
                            Icons.check_circle,
                            admins
                                .where((a) => a['status'] == 'نشط')
                                .length
                                .toString(),
                            'المديرين النشطين',
                            color: Colors.green,
                          ),
                          SizedBox(height: 12),
                          _buildStatCard(
                            Icons.cancel,
                            admins
                                .where((a) => a['status'] == 'غير نشط')
                                .length
                                .toString(),
                            'المديرين غير النشطين',
                            color: Colors.red,
                          ),
                        ],
                      )
                      : Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              Icons.admin_panel_settings,
                              admins.length.toString(),
                              'إجمالي المديرين',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              Icons.check_circle,
                              admins
                                  .where((a) => a['status'] == 'نشط')
                                  .length
                                  .toString(),
                              'المديرين النشطين',
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              Icons.cancel,
                              admins
                                  .where((a) => a['status'] == 'غير نشط')
                                  .length
                                  .toString(),
                              'المديرين غير النشطين',
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
            ),

            // Search and Add Button - responsive layout
            Container(
              margin: EdgeInsets.all(screenWidth < 600 ? 12 : 20),
              child:
                  screenWidth < 600
                      ? Column(
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
                              hintText: 'البحث عن المشرفين...',
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
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: _showAddAdminDialog,
                            icon: Icon(Icons.add, color: Colors.white),
                            label: Text(
                              'إضافة مشرف',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.currentTheme['accent'],
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      )
                      : Row(
                        children: [
                          Expanded(
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
                                hintText: 'البحث عن المشرفين...',
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
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: _showAddAdminDialog,
                            icon: Icon(Icons.add, color: Colors.white),
                            label: Text(
                              'إضافة مشرف',
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
                        ],
                      ),
            ),

            // Admins List expands and scrolls
            Expanded(
              child: LayoutBuilder(
                builder:
                    (context, constraints) =>
                        _buildAdminsList(constraints.maxWidth),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label, {
    Color? color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
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
          Icon(icon, color: color ?? widget.currentTheme['accent'], size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: widget.currentTheme['textPrimary'],
            ),
          ),
          Text(
            label,
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
}
