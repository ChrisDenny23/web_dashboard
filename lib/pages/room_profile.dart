// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:html' as html show FileReader, FileUploadInputElement;
import 'dart:io' show File;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RoomProfilePage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;
  final Map<String, dynamic> room;

  const RoomProfilePage({
    super.key,
    required this.currentTheme,
    required this.room,
  });

  @override
  _RoomProfilePageState createState() => _RoomProfilePageState();
}

class _RoomProfilePageState extends State<RoomProfilePage> {
  List<Map<String, dynamic>> roomMembers = [
    {
      'name': 'جون',
      'username': 'john_admin',
      'email': 'john.admin@example.com',
      'profileType': 'Root',
      'views': 245,
      'birthDate': '1985-03-20',
      'address': '١٢٣ شارع الرئيسي، نيويورك، NY ١٠٠٠١',
      'maritalStatus': 'متزوج',
      'work': 'مهندس برمجيات أول في TechCorp',
      'likes': 'البرمجة، الألعاب، قراءة مدونات التقنية، القهوة',
      'visited': 'اليابان، ألمانيا، أستراليا، كندا',
      'aboutMe':
          'مطور شغوف بخبرة أكثر من ١٠ سنوات. أحب بناء التطبيقات القابلة للتطوير وتوجيه المطورين المبتدئين.',
      'statusText': 'أبني المستقبل، سطر برمجي واحد في كل مرة! 🚀',
      'presenceRate': 85,
      'profileAddDate': '2024-01-15',
      'endDate': '2025-01-15',
      'status': 'نشيط',
      'presence': 'متصل',
      'profileImagePath': null,
      'profileImageBytes': null,
      'profileBackgroundImagePath': null,
      'profileBackgroundImageBytes': null,
    },
    {
      'name': 'سارة',
      'username': 'sarah_manager',
      'email': 'sarah.manager@example.com',
      'profileType': 'Master',
      'views': 156,
      'birthDate': '1990-07-12',
      'address': '٤٥٦ شارع أوك، سان فرانسيسكو، CA ٩٤١٠٢',
      'maritalStatus': 'عزباء',
      'work': 'مديرة مشاريع في InnovateLabs',
      'likes': 'العمل الجماعي، اليوغا، التصوير، المشي الجبلي',
      'visited': 'فرنسا، إيطاليا، إسبانيا، البرتغال',
      'aboutMe':
          'مديرة مشاريع تعتمد على تحقيق النتائج وتحب جمع الفرق لتحقيق الإنجازات.',
      'statusText': 'حالياً أنسق ثلاثة مشاريع مثيرة! 📊',
      'presenceRate': 72,
      'profileAddDate': '2024-02-01',
      'endDate': '2024-12-31',
      'status': 'نشيط',
      'presence': 'بعيد',
      'profileImagePath': null,
      'profileImageBytes': null,
      'profileBackgroundImagePath': null,
      'profileBackgroundImageBytes': null,
    },
  ];

  String selectedProfileType = 'الكل';
  String searchQuery = '';

  List<Map<String, dynamic>> get filteredMembers {
    return roomMembers.where((member) {
      final matchesSearch =
          member['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          member['email'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          (member['username'] ?? '').toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
      final matchesType =
          selectedProfileType == 'الكل' ||
          member['profileType'] == selectedProfileType;
      return matchesSearch && matchesType;
    }).toList();
  }

  Color getProfileTypeColor(String type) {
    switch (type) {
      case 'Root':
        return Colors.amber[600]!;
      case 'Master':
        return Colors.red[600]!;
      default:
        return Colors.grey;
    }
  }

  IconData getProfileTypeIcon(String type) {
    switch (type) {
      case 'Root':
        return Icons.verified_user;
      case 'Master':
        return Icons.admin_panel_settings;
      default:
        return Icons.person;
    }
  }

  void _showEditMemberDialog(Map<String, dynamic> member, int index) {
    final nameController = TextEditingController(text: member['name']);
    final usernameController = TextEditingController(
      text: member['username'] ?? '',
    );
    final emailController = TextEditingController(text: member['email']);
    final passwordController = TextEditingController();
    final profilePasswordController = TextEditingController();
    final addressController = TextEditingController(
      text: member['address'] ?? '',
    );
    final birthDateController = TextEditingController(
      text: member['birthDate'] ?? '',
    );
    final maritalStatusController = TextEditingController(
      text: member['maritalStatus'] ?? '',
    );
    final workController = TextEditingController(text: member['work'] ?? '');
    final likesController = TextEditingController(text: member['likes'] ?? '');
    final visitedController = TextEditingController(
      text: member['visited'] ?? '',
    );
    final presenceRateController = TextEditingController(
      text: member['presenceRate']?.toString() ?? '0',
    );
    final profileAddDateController = TextEditingController(
      text: member['profileAddDate'] ?? '',
    );
    final endDateController = TextEditingController(
      text: member['endDate'] ?? '',
    );
    final aboutMeController = TextEditingController(
      text: member['aboutMe'] ?? '',
    );
    final statusTextController = TextEditingController(
      text: member['statusText'] ?? '',
    );
    final viewsController = TextEditingController(
      text: member['views']?.toString() ?? '0',
    );
    String selectedNewProfileType = member['profileType'];
    String selectedStatus = member['status'] ?? 'نشيط';
    String selectedPresence = member['presence'] ?? 'متصل';

    _showMemberDialog(
      title: 'تعديل العضو',
      subtitle: 'تحديث بيانات ${member['name']}',
      nameController: nameController,
      usernameController: usernameController,
      emailController: emailController,
      passwordController: passwordController,
      profilePasswordController: profilePasswordController,
      addressController: addressController,
      birthDateController: birthDateController,
      maritalStatusController: maritalStatusController,
      workController: workController,
      likesController: likesController,
      visitedController: visitedController,
      presenceRateController: presenceRateController,
      profileAddDateController: profileAddDateController,
      endDateController: endDateController,
      aboutMeController: aboutMeController,
      statusTextController: statusTextController,
      viewsController: viewsController,
      selectedNewProfileType: selectedNewProfileType,
      selectedStatus: selectedStatus,
      selectedPresence: selectedPresence,
      isEdit: true,
      memberIndex: index,
    );
  }

  void _showAddMemberDialog() {
    final nameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final profilePasswordController = TextEditingController();
    final addressController = TextEditingController();
    final birthDateController = TextEditingController();
    final maritalStatusController = TextEditingController();
    final workController = TextEditingController();
    final likesController = TextEditingController();
    final visitedController = TextEditingController();
    final presenceRateController = TextEditingController();
    final profileAddDateController = TextEditingController();
    final endDateController = TextEditingController();
    final aboutMeController = TextEditingController();
    final statusTextController = TextEditingController();
    final viewsController = TextEditingController();

    String selectedNewProfileType = 'Master';
    String selectedStatus = 'نشيط';
    String selectedPresence = 'متصل';

    _showMemberDialog(
      title: 'إضافة عضو في الغرفة',
      subtitle: 'إضافة عضو جديد إلى ${widget.room['roomName']}',
      nameController: nameController,
      usernameController: usernameController,
      emailController: emailController,
      passwordController: passwordController,
      profilePasswordController: profilePasswordController,
      addressController: addressController,
      birthDateController: birthDateController,
      maritalStatusController: maritalStatusController,
      workController: workController,
      likesController: likesController,
      visitedController: visitedController,
      presenceRateController: presenceRateController,
      profileAddDateController: profileAddDateController,
      endDateController: endDateController,
      aboutMeController: aboutMeController,
      statusTextController: statusTextController,
      viewsController: viewsController,
      selectedNewProfileType: selectedNewProfileType,
      selectedStatus: selectedStatus,
      selectedPresence: selectedPresence,
      isEdit: false,
    );
  }

  void _showMemberDialog({
    required String title,
    required String subtitle,
    required TextEditingController nameController,
    required TextEditingController usernameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController profilePasswordController,
    required TextEditingController addressController,
    required TextEditingController birthDateController,
    required TextEditingController maritalStatusController,
    required TextEditingController workController,
    required TextEditingController likesController,
    required TextEditingController visitedController,
    required TextEditingController presenceRateController,
    required TextEditingController profileAddDateController,
    required TextEditingController endDateController,
    required TextEditingController aboutMeController,
    required TextEditingController statusTextController,
    required TextEditingController viewsController,
    required String selectedNewProfileType,
    required String selectedStatus,
    required String selectedPresence,
    required bool isEdit,
    int? memberIndex,
  }) {
    String currentSelectedProfileType = selectedNewProfileType;
    String currentSelectedStatus = selectedStatus;
    String currentSelectedPresence = selectedPresence;
    String? selectedProfileImagePath;
    Uint8List? selectedProfileImageBytes;
    String? selectedProfileBackgroundImagePath;
    Uint8List? selectedProfileBackgroundImageBytes;

    final ImagePicker picker = ImagePicker();

    Future<void> pickProfileImage() async {
      try {
        if (kIsWeb) {
          final html.FileUploadInputElement uploadInput =
              html.FileUploadInputElement();
          uploadInput.accept = 'image/*';
          uploadInput.click();

          uploadInput.onChange.listen((e) {
            final files = uploadInput.files;
            if (files!.length == 1) {
              final file = files[0];
              final reader = html.FileReader();
              reader.readAsArrayBuffer(file);
              reader.onLoadEnd.listen((e) {
                final bytes = reader.result as Uint8List;
                setState(() {
                  selectedProfileImageBytes = bytes;
                  selectedProfileImagePath = null;
                });
              });
            }
          });
        } else {
          final XFile? image = await picker.pickImage(
            source: ImageSource.gallery,
            maxWidth: 400,
            maxHeight: 400,
            imageQuality: 80,
          );
          if (image != null) {
            final bytes = await image.readAsBytes();
            setState(() {
              selectedProfileImagePath = image.path;
              selectedProfileImageBytes = bytes;
            });
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء اختيار صورة الملف الشخصي: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }

    Future<void> pickProfileBackgroundImage() async {
      try {
        if (kIsWeb) {
          final html.FileUploadInputElement uploadInput =
              html.FileUploadInputElement();
          uploadInput.accept = 'image/*';
          uploadInput.click();

          uploadInput.onChange.listen((e) {
            final files = uploadInput.files;
            if (files!.length == 1) {
              final file = files[0];
              final reader = html.FileReader();
              reader.readAsArrayBuffer(file);
              reader.onLoadEnd.listen((e) {
                final bytes = reader.result as Uint8List;
                setState(() {
                  selectedProfileBackgroundImageBytes = bytes;
                  selectedProfileBackgroundImagePath = null;
                });
              });
            }
          });
        } else {
          final XFile? image = await picker.pickImage(
            source: ImageSource.gallery,
            maxWidth: 800,
            maxHeight: 400,
            imageQuality: 80,
          );
          if (image != null) {
            final bytes = await image.readAsBytes();
            setState(() {
              selectedProfileBackgroundImagePath = image.path;
              selectedProfileBackgroundImageBytes = bytes;
            });
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء اختيار خلفية الملف: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: 700,
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      color: widget.currentTheme['cardBg'],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        // Header
                        Container(
                          padding: EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.currentTheme['accent'],
                                widget.currentTheme['accent'].withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  isEdit ? Icons.edit : Icons.person_add,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      subtitle,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(
                                    0.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Form Content
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Profile Pictures
                                _buildSectionHeader(
                                  'صور الملف الشخصي',
                                  Icons.image,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildImageUploadField(
                                        'صورة الملف الشخصي',
                                        selectedProfileImagePath,
                                        selectedProfileImageBytes,
                                        pickProfileImage,
                                        Icons.add_a_photo,
                                        isCircular: true,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: _buildImageUploadField(
                                        'الخلفية الشخصية',
                                        selectedProfileBackgroundImagePath,
                                        selectedProfileBackgroundImageBytes,
                                        pickProfileBackgroundImage,
                                        Icons.add_photo_alternate,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 32),
                                _buildSectionHeader(
                                  'معلومات أساسية',
                                  Icons.person,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'الاسم الكامل',
                                        controller: nameController,
                                        icon: Icons.person,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'اسم المستخدم',
                                        controller: usernameController,
                                        icon: Icons.alternate_email,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'البريد الإلكتروني',
                                        controller: emailController,
                                        icon: Icons.email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'تاريخ الميلاد',
                                        controller: birthDateController,
                                        icon: Icons.cake,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'كلمة المرور',
                                        controller: passwordController,
                                        icon: Icons.lock,
                                        obscureText: true,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'كلمة مرور الملف',
                                        controller: profilePasswordController,
                                        icon: Icons.admin_panel_settings,
                                        obscureText: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                _buildFormField(
                                  label: 'العنوان',
                                  controller: addressController,
                                  icon: Icons.location_on,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'الحالة الاجتماعية',
                                        controller: maritalStatusController,
                                        icon: Icons.favorite,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'العمل',
                                        controller: workController,
                                        icon: Icons.work,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                                _buildSectionHeader(
                                  'معلومات شخصية',
                                  Icons.info,
                                ),
                                SizedBox(height: 20),
                                _buildFormField(
                                  label: 'الهوايات',
                                  controller: likesController,
                                  icon: Icons.thumb_up,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 20),
                                _buildFormField(
                                  label: 'أماكن تمت زيارتها',
                                  controller: visitedController,
                                  icon: Icons.flight,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 20),
                                _buildFormField(
                                  label: 'عنّي',
                                  controller: aboutMeController,
                                  icon: Icons.info,
                                  maxLines: 3,
                                ),
                                SizedBox(height: 20),
                                _buildFormField(
                                  label: 'حالة الملف',
                                  controller: statusTextController,
                                  icon: Icons.text_fields,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 24),
                                _buildSectionHeader(
                                  'إعدادات الملف',
                                  Icons.settings,
                                ),
                                SizedBox(height: 20),
                                _buildDropdownField(
                                  label: 'نوع الملف',
                                  icon: Icons.account_circle,
                                  value: currentSelectedProfileType,
                                  items: ['Root', 'Master'],
                                  onChanged: (value) {
                                    setDialogState(() {
                                      currentSelectedProfileType = value!;
                                    });
                                  },
                                  itemBuilder:
                                      (type) => Row(
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: getProfileTypeColor(type),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Icon(
                                              getProfileTypeIcon(type),
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            type == 'Root'
                                                ? 'جذر'
                                                : type == 'Master'
                                                ? 'مدير'
                                                : type,
                                          ),
                                        ],
                                      ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDropdownField(
                                        label: 'الحالة',
                                        icon: Icons.power_settings_new,
                                        value: currentSelectedStatus,
                                        items: ['نشيط', 'غير نشط'],
                                        onChanged: (value) {
                                          setDialogState(() {
                                            currentSelectedStatus = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _buildDropdownField(
                                        label: 'التواجد',
                                        icon: Icons.circle,
                                        value: currentSelectedPresence,
                                        items: ['متصل', 'بعيد', 'غير متصل'],
                                        onChanged: (value) {
                                          setDialogState(() {
                                            currentSelectedPresence = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                                _buildSectionHeader(
                                  'إعدادات إضافية',
                                  Icons.tune,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'تاريخ إضافة الملف',
                                        controller: profileAddDateController,
                                        icon: Icons.date_range,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'تاريخ الانتهاء',
                                        controller: endDateController,
                                        icon: Icons.event,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'نسبة التواجد',
                                        controller: presenceRateController,
                                        icon: Icons.trending_up,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'المشاهدات',
                                        controller: viewsController,
                                        icon: Icons.visibility,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: widget.currentTheme['mainBg'],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: BorderSide(
                                        color: widget
                                            .currentTheme['textSecondary']
                                            .withOpacity(0.3),
                                        width: 2,
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
                              SizedBox(width: 20),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (nameController.text.isNotEmpty &&
                                        usernameController.text.isNotEmpty &&
                                        emailController.text.isNotEmpty) {
                                      final memberData = {
                                        'name': nameController.text,
                                        'username': usernameController.text,
                                        'email': emailController.text,
                                        'password': passwordController.text,
                                        'profilePassword':
                                            profilePasswordController.text,
                                        'address': addressController.text,
                                        'birthDate': birthDateController.text,
                                        'maritalStatus':
                                            maritalStatusController.text,
                                        'work': workController.text,
                                        'likes': likesController.text,
                                        'visited': visitedController.text,
                                        'aboutMe': aboutMeController.text,
                                        'statusText': statusTextController.text,
                                        'profileType':
                                            currentSelectedProfileType,
                                        'profileAddDate':
                                            profileAddDateController
                                                    .text
                                                    .isNotEmpty
                                                ? profileAddDateController.text
                                                : DateTime.now()
                                                    .toString()
                                                    .substring(0, 10),
                                        'endDate':
                                            endDateController.text.isNotEmpty
                                                ? endDateController.text
                                                : DateTime.now()
                                                    .add(Duration(days: 365))
                                                    .toString()
                                                    .substring(0, 10),
                                        'status': currentSelectedStatus,
                                        'presence': currentSelectedPresence,
                                        'presenceRate':
                                            int.tryParse(
                                              presenceRateController.text,
                                            ) ??
                                            0,
                                        'views':
                                            int.tryParse(
                                              viewsController.text,
                                            ) ??
                                            0,
                                        'profileImagePath':
                                            selectedProfileImagePath,
                                        'profileImageBytes':
                                            selectedProfileImageBytes,
                                        'profileBackgroundImagePath':
                                            selectedProfileBackgroundImagePath,
                                        'profileBackgroundImageBytes':
                                            selectedProfileBackgroundImageBytes,
                                      };
                                      setState(() {
                                        if (isEdit && memberIndex != null) {
                                          roomMembers[memberIndex] = memberData;
                                        } else {
                                          roomMembers.add(memberData);
                                        }
                                      });

                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            isEdit
                                                ? 'تم تحديث بيانات العضو بنجاح!'
                                                : 'تمت إضافة العضو بنجاح!',
                                          ),
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'يرجى تعبئة جميع الحقول المطلوبة (الاسم، اسم المستخدم، البريد الإلكتروني)',
                                          ),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        widget.currentTheme['accent'],
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    isEdit
                                        ? 'تحديث بيانات العضو'
                                        : 'إضافة العضو',
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: widget.currentTheme['accent'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: widget.currentTheme['accent'], size: 24),
        ),
        SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(
            color: widget.currentTheme['textPrimary'],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildImageUploadField(
    String label,
    String? imagePath,
    Uint8List? imageBytes,
    VoidCallback onTap,
    IconData icon, {
    bool isCircular = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: widget.currentTheme['textPrimary'],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: widget.currentTheme['mainBg'],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.currentTheme['accent'].withOpacity(0.3),
                width: 2,
              ),
            ),
            child:
                _buildImageWidget(
                  imagePath: imagePath,
                  imageBytes: imageBytes,
                  width: double.infinity,
                  height: 140,
                  isCircular: isCircular,
                ) ??
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: widget.currentTheme['accent'],
                        size: 40,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'إضافة $label',
                        style: TextStyle(
                          color: widget.currentTheme['textSecondary'],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ],
    );
  }

  Widget? _buildImageWidget({
    String? imagePath,
    Uint8List? imageBytes,
    required double width,
    required double height,
    bool isCircular = false,
  }) {
    if (imageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(isCircular ? width / 2 : 16),
        child: Image.memory(
          imageBytes,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } else if (!kIsWeb && imagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(isCircular ? width / 2 : 16),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    }
    return null;
  }

  Widget _buildDropdownField<T>({
    required String label,
    required IconData icon,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    Widget Function(T)? itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: widget.currentTheme['textPrimary'],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: widget.currentTheme['mainBg'],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.currentTheme['textSecondary'].withOpacity(0.3),
              width: 1,
            ),
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            dropdownColor: widget.currentTheme['cardBg'],
            style: TextStyle(
              color: widget.currentTheme['textPrimary'],
              fontSize: 16,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: widget.currentTheme['textSecondary'],
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
            items:
                items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: itemBuilder?.call(item) ?? Text(item.toString()),
                  );
                }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _deleteMember(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: widget.currentTheme['cardBg'],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(Icons.warning, color: Colors.red, size: 28),
                SizedBox(width: 12),
                Text(
                  'حذف العضو',
                  style: TextStyle(
                    color: widget.currentTheme['textPrimary'],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(
              'هل أنت متأكد أنك تريد حذف ${roomMembers[index]['name']}؟ لا يمكن التراجع عن هذا الإجراء.',
              style: TextStyle(
                color: widget.currentTheme['textSecondary'],
                fontSize: 16,
              ),
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
                    roomMembers.removeAt(index);
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم حذف العضو بنجاح!'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('حذف', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: widget.currentTheme['textPrimary'],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: widget.currentTheme['mainBg'],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.currentTheme['textSecondary'].withOpacity(0.3),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: widget.currentTheme['textPrimary'],
              fontSize: 16,
            ),
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: 'أدخل $label',
              hintStyle: TextStyle(color: widget.currentTheme['textSecondary']),
              prefixIcon: Icon(
                icon,
                color: widget.currentTheme['textSecondary'],
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color getPresenceColor(String presence) {
    switch (presence) {
      case 'متصل':
        return Colors.green;
      case 'بعيد':
        return Colors.orange;
      case 'غير متصل':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Widget _buildRoleBadge(String profileType) {
    final color = getProfileTypeColor(profileType);
    final icon = getProfileTypeIcon(profileType);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          SizedBox(width: 6),
          Text(
            profileType == 'Root'
                ? 'جذر'
                : profileType == 'Master'
                ? 'مدير'
                : profileType,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.currentTheme['mainBg'],
      appBar: AppBar(
        backgroundColor: widget.currentTheme['cardBg'],
        elevation: 0,
        title: Text(
          '${widget.room['roomName']} - ملف الغرفة',
          style: TextStyle(
            color: widget.currentTheme['textPrimary'],
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: widget.currentTheme['textPrimary'],
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: widget.currentTheme['accent']),
            onPressed: () {
              // Handle edit room
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // Handle delete room
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Enhanced Room Header with Background
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.currentTheme['accent'],
                  widget.currentTheme['accent'].withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Background image if exists
                if (widget.room['backgroundImageBytes'] != null)
                  Positioned.fill(
                    child: ClipRRect(
                      child: Image.memory(
                        widget.room['backgroundImageBytes'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else if (!kIsWeb && widget.room['backgroundImagePath'] != null)
                  Positioned.fill(
                    child: ClipRRect(
                      child: Image.file(
                        File(widget.room['backgroundImagePath']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                // Enhanced Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                // Content
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.room['roomName'] ?? 'اسم الغرفة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.public,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  widget.room['roomType'] ?? 'عام',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  (widget.room['roomStatus'] ?? 'Active') ==
                                          'Active'
                                      ? Colors.green.withOpacity(0.9)
                                      : Colors.orange.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  (widget.room['roomStatus'] ?? 'Active') ==
                                          'Active'
                                      ? 'نشطة'
                                      : 'غير نشطة',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
          ),

          // Enhanced Statistics Panel
          Container(
            margin: EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: widget.currentTheme['cardBg'],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: widget.currentTheme['shadow'],
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.amber[600]!.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.verified_user,
                            color: Colors.amber[600],
                            size: 24,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          roomMembers
                              .where((m) => m['profileType'] == 'Root')
                              .length
                              .toString(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[600],
                          ),
                        ),
                        Text(
                          'جذور',
                          style: TextStyle(
                            color: widget.currentTheme['textSecondary'],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: widget.currentTheme['cardBg'],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: widget.currentTheme['shadow'],
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red[600]!.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.admin_panel_settings,
                            color: Colors.red[600],
                            size: 24,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          roomMembers
                              .where((m) => m['profileType'] == 'Master')
                              .length
                              .toString(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[600],
                          ),
                        ),
                        Text(
                          'مديرون',
                          style: TextStyle(
                            color: widget.currentTheme['textSecondary'],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: widget.currentTheme['cardBg'],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: widget.currentTheme['shadow'],
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: widget.currentTheme['accent'].withOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.group,
                            color: widget.currentTheme['accent'],
                            size: 24,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          roomMembers.length.toString(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: widget.currentTheme['accent'],
                          ),
                        ),
                        Text(
                          'إجمالي الأعضاء',
                          style: TextStyle(
                            color: widget.currentTheme['textSecondary'],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Enhanced Search and Filter Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.currentTheme['cardBg'],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: widget.currentTheme['shadow'],
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      style: TextStyle(
                        color: widget.currentTheme['textPrimary'],
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: 'ابحث عن الأعضاء...',
                        hintStyle: TextStyle(
                          color: widget.currentTheme['textSecondary'],
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: widget.currentTheme['textSecondary'],
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.currentTheme['cardBg'],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: widget.currentTheme['shadow'],
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedProfileType,
                      dropdownColor: widget.currentTheme['cardBg'],
                      style: TextStyle(
                        color: widget.currentTheme['textPrimary'],
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      items:
                          ['الكل', 'Root', 'Master'].map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(
                                type == 'الكل'
                                    ? 'الكل'
                                    : type == 'Root'
                                    ? 'جذر'
                                    : type == 'Master'
                                    ? 'مدير'
                                    : type,
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProfileType = value!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        widget.currentTheme['accent'],
                        widget.currentTheme['accent'].withOpacity(0.8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.currentTheme['accent'].withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _showAddMemberDialog,
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text(
                      'إضافة عضو',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Enhanced Members List
          Expanded(
            child:
                filteredMembers.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: widget.currentTheme['accent'].withOpacity(
                                0.1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.people_outline,
                              size: 80,
                              color: widget.currentTheme['accent'],
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'لا يوجد أعضاء',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'حاول تعديل البحث أو عوامل التصفية',
                            style: TextStyle(
                              color: widget.currentTheme['textSecondary'],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      itemCount: filteredMembers.length,
                      itemBuilder: (context, index) {
                        final member = filteredMembers[index];
                        final originalIndex = roomMembers.indexOf(member);
                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: widget.currentTheme['cardBg'],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: widget.currentTheme['shadow'],
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(20),
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    getProfileTypeColor(member['profileType']),
                                    getProfileTypeColor(
                                      member['profileType'],
                                    ).withOpacity(0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: getProfileTypeColor(
                                      member['profileType'],
                                    ).withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(
                                getProfileTypeIcon(member['profileType']),
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            title: Row(
                              children: [
                                _buildRoleBadge(member['profileType']),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    member['name'],
                                    style: TextStyle(
                                      color: widget.currentTheme['textPrimary'],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(
                                  '@${member['username'] ?? 'unknown'}',
                                  style: TextStyle(
                                    color: widget.currentTheme['textSecondary'],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  member['email'],
                                  style: TextStyle(
                                    color: widget.currentTheme['textSecondary'],
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: getPresenceColor(
                                          member['presence'] ?? 'غير متصل',
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: getPresenceColor(
                                              member['presence'] ?? 'غير متصل',
                                            ).withOpacity(0.5),
                                            blurRadius: 4,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      member['presence'] ?? 'غير متصل',
                                      style: TextStyle(
                                        color: getPresenceColor(
                                          member['presence'] ?? 'غير متصل',
                                        ),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            member['status'] == 'Active'
                                                ? Colors.green.withOpacity(0.1)
                                                : Colors.orange.withOpacity(
                                                  0.1,
                                                ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color:
                                              member['status'] == 'Active'
                                                  ? Colors.green
                                                  : Colors.orange,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        member['status'] == 'Active'
                                            ? 'نشط'
                                            : 'غير نشط',
                                        style: TextStyle(
                                          color:
                                              member['status'] == 'Active'
                                                  ? Colors.green
                                                  : Colors.orange,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${member['views'] ?? 0} مشاهدة',
                                      style: TextStyle(
                                        color:
                                            widget
                                                .currentTheme['textSecondary'],
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'نسبة التواجد: ${member['presenceRate'] ?? 0}%',
                                      style: TextStyle(
                                        color:
                                            widget
                                                .currentTheme['textSecondary'],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16),
                                PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: widget.currentTheme['textSecondary'],
                                  ),
                                  color: widget.currentTheme['cardBg'],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  onSelected: (value) {
                                    switch (value) {
                                      case 'edit':
                                        _showEditMemberDialog(
                                          member,
                                          originalIndex,
                                        );
                                        break;
                                      case 'delete':
                                        _deleteMember(originalIndex);
                                        break;
                                    }
                                  },
                                  itemBuilder:
                                      (context) => [
                                        PopupMenuItem(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color:
                                                    widget
                                                        .currentTheme['accent'],
                                                size: 20,
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                'تعديل العضو',
                                                style: TextStyle(
                                                  color:
                                                      widget
                                                          .currentTheme['textPrimary'],
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
                                                size: 20,
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                'حذف العضو',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                ),
                              ],
                            ),
                            onTap: () {
                              // Show enhanced member details
                              _showMemberDetailsDialog(member);
                            },
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  void _showMemberDetailsDialog(Map<String, dynamic> member) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 500,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              decoration: BoxDecoration(
                color: widget.currentTheme['cardBg'],
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: widget.currentTheme['shadow'],
                    blurRadius: 30,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with profile image
                  Container(
                    padding: EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          getProfileTypeColor(member['profileType']),
                          getProfileTypeColor(
                            member['profileType'],
                          ).withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildRoleBadge(member['profileType']),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 24,
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 3,
                            ),
                          ),
                          child:
                              member['profileImageBytes'] != null
                                  ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.memory(
                                      member['profileImageBytes'],
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  )
                                  : Icon(
                                    getProfileTypeIcon(member['profileType']),
                                    color: Colors.white,
                                    size: 50,
                                  ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          member['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '@${member['username'] ?? 'unknown'}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                        if (member['statusText'] != null &&
                            member['statusText'].isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                member['statusText'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Details Section
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Contact Information
                          _buildDetailSection(
                            'معلومات الاتصال',
                            Icons.contact_mail,
                            [
                              _buildDetailRow(
                                'البريد الإلكتروني',
                                member['email'],
                                Icons.email,
                              ),
                              if (member['address'] != null &&
                                  member['address'].isNotEmpty)
                                _buildDetailRow(
                                  'العنوان',
                                  member['address'],
                                  Icons.location_on,
                                ),
                            ],
                          ),

                          // Personal Information
                          if (_hasPersonalInfo(member))
                            _buildDetailSection('معلومات شخصية', Icons.person, [
                              if (member['birthDate'] != null &&
                                  member['birthDate'].isNotEmpty)
                                _buildDetailRow(
                                  'تاريخ الميلاد',
                                  member['birthDate'],
                                  Icons.cake,
                                ),
                              if (member['maritalStatus'] != null &&
                                  member['maritalStatus'].isNotEmpty)
                                _buildDetailRow(
                                  'الحالة الاجتماعية',
                                  member['maritalStatus'],
                                  Icons.favorite,
                                ),
                              if (member['work'] != null &&
                                  member['work'].isNotEmpty)
                                _buildDetailRow(
                                  'العمل',
                                  member['work'],
                                  Icons.work,
                                ),
                            ]),

                          // Interests & Travel
                          if (_hasInterestsInfo(member))
                            _buildDetailSection(
                              'الهوايات و السفر',
                              Icons.interests,
                              [
                                if (member['likes'] != null &&
                                    member['likes'].isNotEmpty)
                                  _buildDetailRow(
                                    'الهوايات',
                                    member['likes'],
                                    Icons.thumb_up,
                                  ),
                                if (member['visited'] != null &&
                                    member['visited'].isNotEmpty)
                                  _buildDetailRow(
                                    'أماكن تمت زيارتها',
                                    member['visited'],
                                    Icons.flight,
                                  ),
                              ],
                            ),

                          // About Me
                          if (member['aboutMe'] != null &&
                              member['aboutMe'].isNotEmpty)
                            _buildDetailSection('عني', Icons.info, [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: widget.currentTheme['mainBg'],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  member['aboutMe'],
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ]),

                          // Statistics
                          _buildDetailSection('الإحصائيات', Icons.analytics, [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStatCard(
                                    'المشاهدات',
                                    '${member['views'] ?? 0}',
                                    Icons.visibility,
                                    Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: _buildStatCard(
                                    'نسبة التواجد',
                                    '${member['presenceRate'] ?? 0}%',
                                    Icons.trending_up,
                                    Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ]),

                          // Dates
                          _buildDetailSection('تواريخ مهمة', Icons.date_range, [
                            if (member['profileAddDate'] != null &&
                                member['profileAddDate'].isNotEmpty)
                              _buildDetailRow(
                                'تاريخ إضافة الملف',
                                member['profileAddDate'],
                                Icons.date_range,
                              ),
                            if (member['endDate'] != null &&
                                member['endDate'].isNotEmpty)
                              _buildDetailRow(
                                'تاريخ الانتهاء',
                                member['endDate'],
                                Icons.event,
                              ),
                          ]),
                        ],
                      ),
                    ),
                  ),

                  // Footer
                  Container(
                    padding: EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: widget.currentTheme['mainBg'],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              _showEditMemberDialog(
                                member,
                                roomMembers.indexOf(member),
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.white),
                            label: Text(
                              'تعديل العضو',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.currentTheme['accent'],
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.currentTheme['cardBg'],
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: widget.currentTheme['textSecondary']
                                    .withOpacity(0.3),
                              ),
                            ),
                          ),
                          child: Text(
                            'إغلاق',
                            style: TextStyle(
                              color: widget.currentTheme['textPrimary'],
                              fontWeight: FontWeight.w600,
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
    );
  }

  bool _hasPersonalInfo(Map<String, dynamic> member) {
    return (member['birthDate'] != null && member['birthDate'].isNotEmpty) ||
        (member['maritalStatus'] != null &&
            member['maritalStatus'].isNotEmpty) ||
        (member['work'] != null && member['work'].isNotEmpty);
  }

  bool _hasInterestsInfo(Map<String, dynamic> member) {
    return (member['likes'] != null && member['likes'].isNotEmpty) ||
        (member['visited'] != null && member['visited'].isNotEmpty);
  }

  Widget _buildDetailSection(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.currentTheme['accent'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: widget.currentTheme['accent'], size: 20),
            ),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: widget.currentTheme['textPrimary'],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ...children,
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: widget.currentTheme['textSecondary']),
          SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: TextStyle(
                      color: widget.currentTheme['textSecondary'],
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      color: widget.currentTheme['textPrimary'],
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
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

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: widget.currentTheme['textSecondary'],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
