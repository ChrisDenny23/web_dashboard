// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import '../widgets/enhanced_header.dart';

class ServerSupportPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const ServerSupportPage({super.key, required this.currentTheme});

  @override
  _ServerSupportPageState createState() => _ServerSupportPageState();
}

class _ServerSupportPageState extends State<ServerSupportPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  List<Map<String, dynamic>> servers = [
    {
      'serverName': 'Main Chat Server',
      'serverPassword': 'main123',
      'permissions': {
        'unbanServer': true,
        'banServer': true,
        'hiddenAccess': true,
        'stopChangeRoomSettings': false,
        'changeUserSettings': true,
        'knowScreenshot': true,
        'knowUserLocation': true,
        'giveModeratorPermissions': true,
      },
      'status': 'Active',
      'createdDate': '2024-01-15',
      'lastActive': '2024-08-05 14:30:00',
    },
    {
      'serverName': 'Backup Server',
      'serverPassword': 'backup456',
      'permissions': {
        'unbanServer': false,
        'banServer': true,
        'hiddenAccess': false,
        'stopChangeRoomSettings': true,
        'changeUserSettings': false,
        'knowScreenshot': false,
        'knowUserLocation': true,
        'giveModeratorPermissions': false,
      },
      'status': 'Inactive',
      'createdDate': '2024-02-01',
      'lastActive': '2024-08-03 09:15:00',
    },
  ];

  List<Map<String, dynamic>> supportMembers = [
    {
      'name': 'John',
      'role': 'Senior Support',
      'joinDate': '2024-01-10',
      'ticketsResolved': 156,
      'status': 'Online',
      'email': 'john.support@example.com',
      'phone': '+1-555-0123',
    },
    {
      'name': 'Sarah',
      'role': 'Support Specialist',
      'joinDate': '2024-02-15',
      'ticketsResolved': 89,
      'status': 'Away',
      'email': 'sarah.helper@example.com',
      'phone': '+1-555-0124',
    },
    {
      'name': 'Mike',
      'role': 'Junior Support',
      'joinDate': '2024-03-20',
      'ticketsResolved': 34,
      'status': 'Offline',
      'email': 'mike.assistant@example.com',
      'phone': '+1-555-0125',
    },
  ];

  String searchQuery = '';
  String selectedTab = 'servers'; // 'servers' or 'support'

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredServers {
    return servers.where((server) {
      return server['serverName'].toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
    }).toList();
  }

  List<Map<String, dynamic>> get filteredSupportMembers {
    return supportMembers.where((member) {
      return member['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          member['role'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Active':
      case 'Online':
        return Colors.green;
      case 'Away':
        return Colors.orange;
      case 'Inactive':
      case 'Offline':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Active':
      case 'Online':
        return Icons.check_circle;
      case 'Away':
        return Icons.access_time;
      case 'Inactive':
      case 'Offline':
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
  }) {
    // Arabic mappings for form labels and hints
    final Map<String, String> labelAr = {
      'Server Name': 'اسم الخادم',
      'Server Password': 'كلمة مرور الخادم',
      'Full Name': 'الاسم الكامل',
      'Email Address': 'البريد الإلكتروني',
      'Phone Number': 'رقم الهاتف',
      'Role': 'الدور',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelAr[label] ?? label,
          style: TextStyle(
            color: widget.currentTheme['textPrimary'],
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
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
            style: TextStyle(color: widget.currentTheme['textPrimary']),
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: 'أدخل ${labelAr[label] ?? label}',
              hintStyle: TextStyle(color: widget.currentTheme['textSecondary']),
              prefixIcon: Icon(
                icon,
                color: widget.currentTheme['textSecondary'],
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
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
    required Function(bool) onChanged,
  }) {
    // Arabic mapping for permissions
    final Map<String, String> titleAr = {
      'Unban Server': 'إلغاء حظر الخادم',
      'Ban Server': 'حظر الخادم',
      'Hidden Access': 'وصول مخفي',
      'Stop Change Room Settings': 'منع تعديل إعدادات الغرفة',
      'Change User Settings': 'تغيير إعدادات المستخدم',
      'Know Who Took Screenshot': 'معرفة من أخذ لقطة شاشة',
      'Know User Location': 'معرفة موقع المستخدم',
      'Give Permission to Moderators': 'منح صلاحيات للمشرفين',
    };
    final Map<String, String> descAr = {
      'Allow unbanning users from the server':
          'السماح بإلغاء حظر المستخدمين من الخادم',
      'Allow banning users from the server': 'السماح بحظر المستخدمين من الخادم',
      'Access to hidden server features': 'الوصول إلى ميزات مخفية للخادم',
      'Prevent changes to room configurations': 'منع تغييرات إعداد الغرفة',
      'Modify user account settings': 'تعديل إعدادات المستخدمين',
      'Track screenshot activities': 'تتبع أنشطة التقاط الشاشة',
      'Access user location and online status':
          'الوصول إلى موقع وحالة المستخدم',
      'Grant moderator privileges to users': 'منح صلاحية الإشراف للمستخدمين',
    };
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
        children: [
          Icon(
            icon,
            color:
                value
                    ? widget.currentTheme['accent']
                    : widget.currentTheme['textSecondary'],
            size: 24,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleAr[title] ?? title,
                  style: TextStyle(
                    color: widget.currentTheme['textPrimary'],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  descAr[description] ?? description,
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: widget.currentTheme['accent'],
          ),
        ],
      ),
    );
  }

  void _showAddServerDialog() {
    final serverNameController = TextEditingController();
    final serverPasswordController = TextEditingController();

    Map<String, bool> permissions = {
      'unbanServer': false,
      'banServer': false,
      'hiddenAccess': false,
      'stopChangeRoomSettings': false,
      'changeUserSettings': false,
      'knowScreenshot': false,
      'knowUserLocation': false,
      'giveModeratorPermissions': false,
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: 600,
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
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: widget.currentTheme['accent'],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.dns,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'إضافة خادم جديد',
                                      style: TextStyle(
                                        color:
                                            widget.currentTheme['textPrimary'],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'إعدادات وصلاحيات الخادم',
                                      style: TextStyle(
                                        color:
                                            widget
                                                .currentTheme['textSecondary'],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.close,
                                  color: widget.currentTheme['textSecondary'],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Scrollable Form Content
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Basic Server Information
                                Text(
                                  'معلومات الخادم',
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),

                                _buildFormField(
                                  label: 'Server Name',
                                  controller: serverNameController,
                                  icon: Icons.dns,
                                ),

                                SizedBox(height: 16),

                                _buildFormField(
                                  label: 'Server Password',
                                  controller: serverPasswordController,
                                  icon: Icons.lock,
                                  obscureText: true,
                                ),

                                SizedBox(height: 24),

                                // Permissions Section
                                Text(
                                  'صلاحيات الخادم',
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),

                                _buildPermissionCheckbox(
                                  title: 'Unban Server',
                                  description:
                                      'Allow unbanning users from the server',
                                  icon: Icons.person_add,
                                  value: permissions['unbanServer']!,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      permissions['unbanServer'] = value;
                                    });
                                  },
                                ),

                                _buildPermissionCheckbox(
                                  title: 'Ban Server',
                                  description:
                                      'Allow banning users from the server',
                                  icon: Icons.person_remove,
                                  value: permissions['banServer']!,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      permissions['banServer'] = value;
                                    });
                                  },
                                ),

                                _buildPermissionCheckbox(
                                  title: 'Hidden Access',
                                  description:
                                      'Access to hidden server features',
                                  icon: Icons.visibility_off,
                                  value: permissions['hiddenAccess']!,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      permissions['hiddenAccess'] = value;
                                    });
                                  },
                                ),

                                _buildPermissionCheckbox(
                                  title: 'Stop Change Room Settings',
                                  description:
                                      'Prevent changes to room configurations',
                                  icon: Icons.block,
                                  value: permissions['stopChangeRoomSettings']!,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      permissions['stopChangeRoomSettings'] =
                                          value;
                                    });
                                  },
                                ),

                                _buildPermissionCheckbox(
                                  title: 'Change User Settings',
                                  description: 'Modify user account settings',
                                  icon: Icons.settings,
                                  value: permissions['changeUserSettings']!,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      permissions['changeUserSettings'] = value;
                                    });
                                  },
                                ),

                                _buildPermissionCheckbox(
                                  title: 'Know Who Took Screenshot',
                                  description: 'Track screenshot activities',
                                  icon: Icons.screenshot,
                                  value: permissions['knowScreenshot']!,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      permissions['knowScreenshot'] = value;
                                    });
                                  },
                                ),

                                _buildPermissionCheckbox(
                                  title: 'Know User Location',
                                  description:
                                      'Access user location and online status',
                                  icon: Icons.location_on,
                                  value: permissions['knowUserLocation']!,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      permissions['knowUserLocation'] = value;
                                    });
                                  },
                                ),

                                _buildPermissionCheckbox(
                                  title: 'Give Permission to Moderators',
                                  description:
                                      'Grant moderator privileges to users',
                                  icon: Icons.admin_panel_settings,
                                  value:
                                      permissions['giveModeratorPermissions']!,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      permissions['giveModeratorPermissions'] =
                                          value;
                                    });
                                  },
                                ),

                                SizedBox(height: 32),
                              ],
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
                                    padding: EdgeInsets.symmetric(vertical: 16),
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
                                          widget.currentTheme['textSecondary'],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (serverNameController.text.isNotEmpty &&
                                        serverPasswordController
                                            .text
                                            .isNotEmpty) {
                                      setState(() {
                                        servers.add({
                                          'serverName':
                                              serverNameController.text,
                                          'serverPassword':
                                              serverPasswordController.text,
                                          'permissions': Map.from(permissions),
                                          'status': 'Active',
                                          'createdDate': DateTime.now()
                                              .toString()
                                              .substring(0, 10),
                                          'lastActive':
                                              DateTime.now().toString(),
                                        });
                                      });
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'تم إضافة الخادم بنجاح!',
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
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        widget.currentTheme['accent'],
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'إضافة الخادم',
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
    );
  }

  void _showAddSupportDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    String selectedRole = 'Support Specialist';
    final Map<String, String> roleAr = {
      'Junior Support': 'دعم مبتدئ',
      'Support Specialist': 'اختصاصي دعم',
      'Senior Support': 'دعم أول',
      'Support Manager': 'مدير الدعم',
    };

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: 500,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Container(
                          padding: EdgeInsets.all(24),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: widget.currentTheme['accent'],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.support_agent,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'إضافة عضو دعم',
                                      style: TextStyle(
                                        color:
                                            widget.currentTheme['textPrimary'],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'إضافة عضو جديد لفريق الدعم',
                                      style: TextStyle(
                                        color:
                                            widget
                                                .currentTheme['textSecondary'],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.close,
                                  color: widget.currentTheme['textSecondary'],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Form
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              _buildFormField(
                                label: 'Full Name',
                                controller: nameController,
                                icon: Icons.person,
                              ),
                              SizedBox(height: 16),
                              _buildFormField(
                                label: 'Email Address',
                                controller: emailController,
                                icon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 16),
                              _buildFormField(
                                label: 'Phone Number',
                                controller: phoneController,
                                icon: Icons.phone,
                                keyboardType: TextInputType.phone,
                              ),
                              SizedBox(height: 16),
                              // Role Selection
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'الدور',
                                    style: TextStyle(
                                      color: widget.currentTheme['textPrimary'],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: widget.currentTheme['mainBg'],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: widget
                                            .currentTheme['textSecondary']
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      value: selectedRole,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.work,
                                          color:
                                              widget
                                                  .currentTheme['textSecondary'],
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                      ),
                                      dropdownColor:
                                          widget.currentTheme['cardBg'],
                                      style: TextStyle(
                                        color:
                                            widget.currentTheme['textPrimary'],
                                      ),
                                      items:
                                          [
                                                'Junior Support',
                                                'Support Specialist',
                                                'Senior Support',
                                                'Support Manager',
                                              ]
                                              .map(
                                                (role) => DropdownMenuItem(
                                                  value: role,
                                                  child: Text(
                                                    roleAr[role] ?? role,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                      onChanged: (value) {
                                        setDialogState(() {
                                          selectedRole = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),

                        // Action Buttons
                        Container(
                          padding: EdgeInsets.all(24),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 16),
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
                                          widget.currentTheme['textSecondary'],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (nameController.text.isNotEmpty) {
                                      setState(() {
                                        supportMembers.add({
                                          'name': nameController.text,
                                          'role': selectedRole,
                                          'joinDate': DateTime.now()
                                              .toString()
                                              .substring(0, 10),
                                          'ticketsResolved': 0,
                                          'status': 'Online',
                                          'email':
                                              emailController.text.isNotEmpty
                                                  ? emailController.text
                                                  : '${nameController.text.toLowerCase().replaceAll(' ', '.')}@example.com',
                                          'phone':
                                              phoneController.text.isNotEmpty
                                                  ? phoneController.text
                                                  : '+1-555-${(1000 + supportMembers.length).toString()}',
                                        });
                                      });
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'تم إضافة عضو الدعم بنجاح!',
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
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        widget.currentTheme['accent'],
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    'إضافة عضو دعم',
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
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    // Mapping for info card titles
    final Map<String, String> titleAr = {
      'Server Password': 'كلمة مرور الخادم',
      'Created Date': 'تاريخ الإنشاء',
      'Join Date': 'تاريخ الانضمام',
      'Tickets Resolved': 'التذاكر المحلولة',
      'Email Address': 'البريد الإلكتروني',
      'Phone Number': 'رقم الهاتف',
      'Not Set': 'ليس محددًا',
    };
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
              Icon(icon, size: 16, color: widget.currentTheme['textSecondary']),
              SizedBox(width: 8),
              Text(
                titleAr[title] ?? title,
                style: TextStyle(
                  color: widget.currentTheme['textSecondary'],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            value == 'Not Set' ? 'ليس محددًا' : value,
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

  Widget _buildPermissionBadge(String permission, bool enabled) {
    // Arabic for permission badge
    final Map<String, String> permAr = {
      'Unban Server': 'إلغاء حظر الخادم',
      'Ban Server': 'حظر الخادم',
      'Hidden Access': 'وصول مخفي',
      'Stop Room Changes': 'منع التعديلات على الغرفة',
      'Change User Settings': 'تغيير إعدادات المستخدم',
      'Know Screenshot': 'معرفة من أخذ لقطة شاشة',
      'Know User Location': 'معرفة موقع المستخدم',
      'Give Moderator Permissions': 'منح الصلاحية للمشرفين',
    };
    return Container(
      margin: EdgeInsets.only(right: 8, bottom: 4),
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
        permAr[permission] ?? permission,
        style: TextStyle(
          color:
              enabled
                  ? widget.currentTheme['accent']
                  : widget.currentTheme['textSecondary'],
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
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
            title: 'إدارة الخوادم والدعم',
            subtitle: 'إعدادات الخادم وفريق الدعم',
            description: 'إدارة الخوادم، الصلاحيات، وأعضاء فريق الدعم',
          ),
          // Tab Selection
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: widget.currentTheme['cardBg'],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 'servers'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color:
                            selectedTab == 'servers'
                                ? widget.currentTheme['accent']
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dns,
                            color:
                                selectedTab == 'servers'
                                    ? Colors.white
                                    : widget.currentTheme['textSecondary'],
                          ),
                          SizedBox(width: 8),
                          Text(
                            'الخوادم',
                            style: TextStyle(
                              color:
                                  selectedTab == 'servers'
                                      ? Colors.white
                                      : widget.currentTheme['textSecondary'],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedTab = 'support'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color:
                            selectedTab == 'support'
                                ? widget.currentTheme['accent']
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.support_agent,
                            color:
                                selectedTab == 'support'
                                    ? Colors.white
                                    : widget.currentTheme['textSecondary'],
                          ),
                          SizedBox(width: 8),
                          Text(
                            'فريق الدعم',
                            style: TextStyle(
                              color:
                                  selectedTab == 'support'
                                      ? Colors.white
                                      : widget.currentTheme['textSecondary'],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Stats Cards
          if (selectedTab == 'servers') ...[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
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
                          Icon(
                            Icons.dns,
                            color: widget.currentTheme['accent'],
                            size: 24,
                          ),
                          SizedBox(height: 8),
                          Text(
                            servers.length.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'إجمالي الخوادم',
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
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
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                          SizedBox(height: 8),
                          Text(
                            servers
                                .where((s) => s['status'] == 'Active')
                                .length
                                .toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'الخوادم النشطة',
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
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
                          Icon(Icons.cancel, color: Colors.red, size: 24),
                          SizedBox(height: 8),
                          Text(
                            servers
                                .where((s) => s['status'] == 'Inactive')
                                .length
                                .toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'الخوادم غير النشطة',
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
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
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                          SizedBox(height: 8),
                          Text(
                            supportMembers
                                .where((m) => m['status'] == 'Online')
                                .length
                                .toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'الدعم المتواجد',
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
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
                          Icon(
                            Icons.support_agent,
                            color: widget.currentTheme['accent'],
                            size: 24,
                          ),
                          SizedBox(height: 8),
                          Text(
                            supportMembers.length.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'إجمالي الدعم',
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
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
                          Icon(
                            Icons.confirmation_number,
                            color: Colors.blue,
                            size: 24,
                          ),
                          SizedBox(height: 8),
                          Text(
                            supportMembers
                                .map((m) => m['ticketsResolved'] as int)
                                .fold(0, (a, b) => a + b)
                                .toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'التذاكر المحلولة',
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Search and Add Button
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    style: TextStyle(color: widget.currentTheme['textPrimary']),
                    decoration: InputDecoration(
                      hintText:
                          selectedTab == 'servers'
                              ? 'ابحث عن خادم...'
                              : 'ابحث عن عضو دعم...',
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
                SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed:
                      selectedTab == 'servers'
                          ? _showAddServerDialog
                          : _showAddSupportDialog,
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    selectedTab == 'servers' ? 'إضافة خادم' : 'إضافة عضو دعم',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.currentTheme['accent'],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content List
          Expanded(
            child:
                selectedTab == 'servers'
                    ? _buildServersList()
                    : _buildSupportList(),
          ),
        ],
      ),
    );
  }

  Widget _buildServersList() {
    if (filteredServers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dns, size: 64, color: widget.currentTheme['accent']),
            SizedBox(height: 16),
            Text(
              'لم يتم العثور على خوادم',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.currentTheme['textPrimary'],
              ),
            ),
            Text(
              'حاول تعديل البحث أو إضافة خادم جديد',
              style: TextStyle(color: widget.currentTheme['textSecondary']),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredServers.length,
      itemBuilder: (context, index) {
        final server = filteredServers[index];
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
            tilePadding: EdgeInsets.all(16),
            childrenPadding: EdgeInsets.all(16),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: getStatusColor(server['status']),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.dns, color: Colors.white, size: 28),
            ),
            title: Text(
              server['serverName'],
              style: TextStyle(
                color: widget.currentTheme['textPrimary'],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تاريخ الإنشاء: ${server['createdDate']}',
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: 14,
                  ),
                ),
                Text(
                  'آخر نشاط: ${server['lastActive']}',
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(server['status']),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        getStatusIcon(server['status']),
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        server['status'] == 'Active'
                            ? 'نشط'
                            : server['status'] == 'Inactive'
                            ? 'غير نشط'
                            : server['status'] == 'Online'
                            ? 'متصل'
                            : server['status'] == 'Away'
                            ? 'بعيد'
                            : server['status'] == 'Offline'
                            ? 'غير متصل'
                            : server['status'],
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
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'تعديل',
                            style: TextStyle(
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text('حذف', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    // Handle edit action
                    break;
                  case 'delete':
                    setState(() {
                      servers.remove(server);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم حذف الخادم بنجاح!'),
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
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.currentTheme['mainBg'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Server Information
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            'Server Password',
                            server['serverPassword'].isNotEmpty
                                ? '••••••••'
                                : 'Not Set',
                            Icons.lock,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoCard(
                            'Created Date',
                            server['createdDate'],
                            Icons.calendar_today,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Permissions
                    Text(
                      'صلاحيات الخادم',
                      style: TextStyle(
                        color: widget.currentTheme['textPrimary'],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      children: [
                        if (server['permissions']['unbanServer'])
                          _buildPermissionBadge('Unban Server', true),
                        if (server['permissions']['banServer'])
                          _buildPermissionBadge('Ban Server', true),
                        if (server['permissions']['hiddenAccess'])
                          _buildPermissionBadge('Hidden Access', true),
                        if (server['permissions']['stopChangeRoomSettings'])
                          _buildPermissionBadge('Stop Room Changes', true),
                        if (server['permissions']['changeUserSettings'])
                          _buildPermissionBadge('Change User Settings', true),
                        if (server['permissions']['knowScreenshot'])
                          _buildPermissionBadge('Know Screenshot', true),
                        if (server['permissions']['knowUserLocation'])
                          _buildPermissionBadge('Know User Location', true),
                        if (server['permissions']['giveModeratorPermissions'])
                          _buildPermissionBadge(
                            'Give Moderator Permissions',
                            true,
                          ),
                      ],
                    ),
                    if (server['permissions'].values.every((v) => !v))
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

  Widget _buildSupportList() {
    if (filteredSupportMembers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.support_agent,
              size: 64,
              color: widget.currentTheme['accent'],
            ),
            SizedBox(height: 16),
            Text(
              'لم يتم العثور على أعضاء دعم',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.currentTheme['textPrimary'],
              ),
            ),
            Text(
              'حاول تعديل البحث أو إضافة عضو دعم جديد',
              style: TextStyle(color: widget.currentTheme['textSecondary']),
            ),
          ],
        ),
      );
    }

    final Map<String, String> statusAr = {
      'Online': 'متصل',
      'Away': 'بعيد',
      'Offline': 'غير متصل',
    };

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredSupportMembers.length,
      itemBuilder: (context, index) {
        final member = filteredSupportMembers[index];
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
            tilePadding: EdgeInsets.all(16),
            childrenPadding: EdgeInsets.all(16),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: getStatusColor(member['status']),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(Icons.support_agent, color: Colors.white, size: 28),
            ),
            title: Text(
              member['name'],
              style: TextStyle(
                color: widget.currentTheme['textPrimary'],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member['role'], // Already mapped to Arabic in DropDown
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: 14,
                  ),
                ),
                Text(
                  'تاريخ الانضمام: ${member['joinDate']}',
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: getStatusColor(member['status']),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            getStatusIcon(member['status']),
                            color: Colors.white,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            statusAr[member['status']] ?? member['status'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.currentTheme['accent'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${member['ticketsResolved']} تذكرة',
                        style: TextStyle(
                          color: widget.currentTheme['accent'],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: PopupMenuButton(
              color: widget.currentTheme['cardBg'],
              icon: Icon(
                Icons.more_vert,
                color: widget.currentTheme['textSecondary'],
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
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'تعديل',
                            style: TextStyle(
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text('حذف', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    // Handle edit action
                    break;
                  case 'delete':
                    setState(() {
                      supportMembers.remove(member);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم حذف عضو الدعم بنجاح!'),
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
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.currentTheme['mainBg'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact Information
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            'Email Address',
                            member['email'],
                            Icons.email,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoCard(
                            'Phone Number',
                            member['phone'],
                            Icons.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            'Join Date',
                            member['joinDate'],
                            Icons.calendar_today,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoCard(
                            'Tickets Resolved',
                            member['ticketsResolved'].toString(),
                            Icons.confirmation_number,
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
      },
    );
  }
}
