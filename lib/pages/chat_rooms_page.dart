// تجاهل: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_web_libraries_in_flutter

// ignore_for_file: avoid_web_libraries_in_flutter, library_private_types_in_public_api, deprecated_member_use, duplicate_ignore, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web_dashboard/pages/room_profile.dart';
// ignore: deprecated_member_use
import 'dart:html' as html;
import '../widgets/enhanced_header.dart';

class ChatroomPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const ChatroomPage({super.key, required this.currentTheme});

  @override
  _ChatroomPageState createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final ImagePicker _picker = ImagePicker();

  List<Map<String, dynamic>> chatrooms = [
    {
      'roomName': 'النقاش العام',
      'roomStatus': 'نشط',
      'country': 'عالمي',
      'roomType': 'ذهبي',
      'ownerEmail': 'admin@example.com',
      'ownerName': 'مستخدم الادمن',
      'masterPassword': 'master123',
      'roomPassword': 'room456',
      'allowPictures': true,
      'roomCapacity': 500,
      'roomStartDate': '2024-01-01',
      'roomEndDate': '2025-01-01',
      'masterLimit': 1,
      'superAdminLimit': 3,
      'adminLimit': 10,
      'memberLimit': 386,
      'guestLimit': 100,
      'backgroundImagePath': null,
      'backgroundImageBytes': null,
      'loginHistory': [
        {
          'user': 'john_doe',
          'timestamp': '2024-08-04 10:30:00',
          'userType': 'ادمن',
        },
        {
          'user': 'jane_smith',
          'timestamp': '2024-08-04 09:15:00',
          'userType': 'عضو',
        },
        {
          'user': 'guest_user1',
          'timestamp': '2024-08-04 11:45:00',
          'userType': 'زائر',
        },
      ],
      'chatManagers': 15,
      'roots': 2,
      'currentUsers': {
        'master': 1,
        'superAdmin': 2,
        'admin': 8,
        'member': 234,
        'guest': 45,
        'total': 290,
      },
    },
    {
      'roomName': 'الصالة المميزة',
      'roomStatus': 'نشط',
      'country': 'الولايات المتحدة',
      'roomType': 'خاص',
      'ownerEmail': 'vip@example.com',
      'ownerName': 'مدير مميز',
      'masterPassword': 'vipmaster789',
      'roomPassword': 'viproom123',
      'allowPictures': true,
      'roomCapacity': 100,
      'roomStartDate': '2024-02-15',
      'roomEndDate': '2024-12-31',
      'masterLimit': 1,
      'superAdminLimit': 2,
      'adminLimit': 5,
      'memberLimit': 80,
      'guestLimit': 12,
      'backgroundImagePath': null,
      'backgroundImageBytes': null,
      'loginHistory': [
        {
          'user': 'vip_user1',
          'timestamp': '2024-08-04 11:45:00',
          'userType': 'ماستر',
        },
        {
          'user': 'vip_user2',
          'timestamp': '2024-08-04 11:20:00',
          'userType': 'سوبر أدمن',
        },
        {
          'user': 'guest_vip1',
          'timestamp': '2024-08-04 10:30:00',
          'userType': 'زائر',
        },
      ],
      'chatManagers': 8,
      'roots': 1,
      'currentUsers': {
        'master': 1,
        'superAdmin': 2,
        'admin': 4,
        'member': 78,
        'guest': 8,
        'total': 93,
      },
    },
    {
      'roomName': 'محور الألعاب',
      'roomStatus': 'غير نشط',
      'country': 'المملكة المتحدة',
      'roomType': 'قياسي',
      'ownerEmail': 'gaming@example.com',
      'ownerName': 'ماستر الألعاب',
      'masterPassword': 'gamemaster456',
      'roomPassword': 'gameroom789',
      'allowPictures': false,
      'roomCapacity': 200,
      'roomStartDate': '2024-03-01',
      'roomEndDate': '2024-11-30',
      'masterLimit': 1,
      'superAdminLimit': 2,
      'adminLimit': 8,
      'memberLimit': 150,
      'guestLimit': 39,
      'backgroundImagePath': null,
      'backgroundImageBytes': null,
      'loginHistory': [
        {
          'user': 'gamer123',
          'timestamp': '2024-08-03 18:30:00',
          'userType': 'عضو',
        },
        {
          'user': 'pro_gamer',
          'timestamp': '2024-08-03 17:45:00',
          'userType': 'ادمن',
        },
        {
          'user': 'casual_guest',
          'timestamp': '2024-08-03 16:20:00',
          'userType': 'زائر',
        },
      ],
      'chatManagers': 12,
      'roots': 3,
      'currentUsers': {
        'master': 0,
        'superAdmin': 1,
        'admin': 3,
        'member': 45,
        'guest': 12,
        'total': 61,
      },
    },
  ];

  String selectedRoomType = 'الكل';
  String searchQuery = '';

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

  List<Map<String, dynamic>> get filteredRooms {
    return chatrooms.where((room) {
      final matchesSearch =
          room['roomName'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          room['ownerEmail'].toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          room['ownerName'].toLowerCase().contains(searchQuery.toLowerCase());
      final matchesType =
          selectedRoomType == 'الكل' || room['roomType'] == selectedRoomType;
      return matchesSearch && matchesType;
    }).toList();
  }

  Color getRoomTypeColor(String type) {
    switch (type) {
      case 'ذهبي':
      case 'Gold':
        return Color(0xFFFFD700);
      case 'قياسي':
      case 'Standard':
        return Color(0xFF87CEEB);
      case 'خاص':
      case 'Special':
        return Color(0xFFFF69B4);
      default:
        return Colors.blue;
    }
  }

  IconData getRoomTypeIcon(String type) {
    switch (type) {
      case 'ذهبي':
      case 'Gold':
        return Icons.diamond;
      case 'قياسي':
      case 'Standard':
        return Icons.room;
      case 'خاص':
      case 'Special':
        return Icons.star;
      default:
        return Icons.chat;
    }
  }

  Color getUserTypeColor(String userType) {
    switch (userType) {
      case 'ماستر':
      case 'Master':
        return Colors.red;
      case 'سوبر أدمن':
      case 'Super Admin':
        return Colors.blue;
      case 'ادمن':
      case 'Admin':
        return Colors.green;
      case 'عضو':
      case 'Member':
        return Colors.purple;
      case 'زائر':
      case 'Guest':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  void _showUserCountDialog(Map<String, dynamic> room) {
    final users = room['currentUsers'];
    final capacity = room['roomCapacity'];
    final utilizationPercentage = ((users['total'] / capacity) * 100).round();
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    MediaQuery.of(context).size.height *
                    0.9, // الحد الأقصى للارتفاع 90% من الشاشة
                maxWidth: 450,
              ),
              child: Container(
                width: 450,
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
                    // العنوان
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
                              Icons.people,
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
                                  'إحصائيات المستخدمين',
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${room['roomName']}',
                                  style: TextStyle(
                                    color: widget.currentTheme['textSecondary'],
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

                    // المحتوى القابل للتمرير
                    Flexible(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            // بطاقة إجمالي المستخدمين
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    widget.currentTheme['accent'],
                                    widget.currentTheme['accent'].withOpacity(
                                      0.8,
                                    ),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.groups,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        '${users['total']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'إجمالي المستخدمين المتصلين',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'السعة: $capacity ($utilizationPercentage% مستخدمة)',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20),

                            // تفصيل المستخدمين حسب الدور
                            Text(
                              'تفصيل المستخدمين حسب الدور',
                              style: TextStyle(
                                color: widget.currentTheme['textPrimary'],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),

                            // بطاقات أنواع المستخدمين - الصف 1
                            Row(
                              children: [
                                Expanded(
                                  child: _buildUserTypeCard(
                                    'ماستر',
                                    users['master'].toString(),
                                    room['masterLimit'].toString(),
                                    Icons.stars,
                                    Colors.red,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: _buildUserTypeCard(
                                    'سوبر أدمن',
                                    users['superAdmin'].toString(),
                                    room['superAdminLimit'].toString(),
                                    Icons.security,
                                    Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            // بطاقات أنواع المستخدمين - الصف 2
                            Row(
                              children: [
                                Expanded(
                                  child: _buildUserTypeCard(
                                    'ادمن',
                                    users['admin'].toString(),
                                    room['adminLimit'].toString(),
                                    Icons.admin_panel_settings,
                                    Colors.green,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: _buildUserTypeCard(
                                    'عضو',
                                    users['member'].toString(),
                                    room['memberLimit'].toString(),
                                    Icons.people,
                                    Colors.purple,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            // بطاقات أنواع المستخدمين - الصف 3 (زائر)
                            Row(
                              children: [
                                Expanded(
                                  child: _buildUserTypeCard(
                                    'زائر',
                                    users['guest'].toString(),
                                    room['guestLimit'].toString(),
                                    Icons.person_outline,
                                    Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(),
                                ), // مساحة فارغة للتنسيق
                              ],
                            ),
                            SizedBox(height: 20),

                            // شريط التقدم
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: widget.currentTheme['mainBg'],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'استخدام الغرفة',
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textPrimary'],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '$utilizationPercentage%',
                                        style: TextStyle(
                                          color: widget.currentTheme['accent'],
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: users['total'] / capacity,
                                    backgroundColor: widget
                                        .currentTheme['textSecondary']
                                        .withOpacity(0.2),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      utilizationPercentage > 80
                                          ? Colors.red
                                          : utilizationPercentage > 60
                                          ? Colors.orange
                                          : widget.currentTheme['accent'],
                                    ),
                                    minHeight: 8,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${users['total']} من $capacity مستخدمين',
                                    style: TextStyle(
                                      color:
                                          widget.currentTheme['textSecondary'],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 24), // مسافة سفلية للتمرير
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildUserTypeCard(
    String title,
    String current,
    String limit,
    IconData icon,
    Color color,
  ) {
    final currentInt = int.parse(current);
    final limitInt = int.parse(limit);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.currentTheme['mainBg'],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 8),
          Text(
            current,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'من $limit',
            style: TextStyle(
              color: widget.currentTheme['textSecondary'],
              fontSize: 12,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: widget.currentTheme['textPrimary'],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: widget.currentTheme['textSecondary'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor:
                  limitInt > 0 ? (currentInt / limitInt).clamp(0.0, 1.0) : 0.0,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(Function(String?, Uint8List?) onImageSelected) async {
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
              onImageSelected(null, bytes);
            });
          }
        });
      } else {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 800,
          maxHeight: 400,
          imageQuality: 80,
        );
        if (image != null) {
          onImageSelected(image.path, null);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء اختيار الصورة: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  Widget? _buildImageWidget({
    String? imagePath,
    Uint8List? imageBytes,
    required double width,
    required double height,
    bool isCircular = false,
  }) {
    if (kIsWeb && imageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(isCircular ? width / 2 : 12),
        child: Image.memory(
          imageBytes,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } else if (!kIsWeb && imagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(isCircular ? width / 2 : 12),
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
              hintText: 'أدخل $label',
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

  void _showAddRoomDialog() {
    final roomNameController = TextEditingController();
    final countryController = TextEditingController();
    final ownerEmailController = TextEditingController();
    final ownerNameController = TextEditingController();
    final masterPasswordController = TextEditingController();
    final roomPasswordController = TextEditingController();
    final roomCapacityController = TextEditingController();
    final roomStartDateController = TextEditingController();
    final roomEndDateController = TextEditingController();
    final masterLimitController = TextEditingController();
    final superAdminLimitController = TextEditingController();
    final adminLimitController = TextEditingController();
    final memberLimitController = TextEditingController();
    final guestLimitController = TextEditingController();

    String selectedNewRoomType = 'قياسي';
    String selectedRoomStatus = 'نشط';
    bool allowPictures = true;
    String? selectedBackgroundImagePath;
    Uint8List? selectedBackgroundImageBytes;

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
                        // العنوان
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
                                  Icons.add_comment,
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
                                      'إنشاء غرفة دردشة جديدة',
                                      style: TextStyle(
                                        color:
                                            widget.currentTheme['textPrimary'],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'قم بإعداد تكوين شامل لغرفة الدردشة',
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
                        ), // محتوى النموذج القابل للتمرير
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // قسم خلفية الغرفة
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: widget.currentTheme['mainBg'],
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: widget.currentTheme['accent']
                                          .withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap:
                                        () =>
                                            _pickImage((imagePath, imageBytes) {
                                              setDialogState(() {
                                                selectedBackgroundImagePath =
                                                    imagePath;
                                                selectedBackgroundImageBytes =
                                                    imageBytes;
                                              });
                                            }),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        gradient: LinearGradient(
                                          colors: [
                                            widget.currentTheme['accent']
                                                .withOpacity(0.3),
                                            widget.currentTheme['accent']
                                                .withOpacity(0.1),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child:
                                          _buildImageWidget(
                                            imagePath:
                                                selectedBackgroundImagePath,
                                            imageBytes:
                                                selectedBackgroundImageBytes,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ) ??
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_photo_alternate,
                                                  color:
                                                      widget
                                                          .currentTheme['accent'],
                                                  size: 32,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'أضف صورة خلفية الغرفة',
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
                                    ),
                                  ),
                                ),

                                SizedBox(height: 24),

                                // معلومات الغرفة الأساسية
                                Text(
                                  'معلومات الغرفة الأساسية',
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'اسم الغرفة',
                                        controller: roomNameController,
                                        icon: Icons.chat,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'الدولة',
                                        controller: countryController,
                                        icon: Icons.flag,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'نوع الغرفة',
                                            style: TextStyle(
                                              color:
                                                  widget
                                                      .currentTheme['textPrimary'],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  widget.currentTheme['mainBg'],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: widget
                                                    .currentTheme['textSecondary']
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              value: selectedNewRoomType,
                                              dropdownColor:
                                                  widget.currentTheme['cardBg'],
                                              style: TextStyle(
                                                color:
                                                    widget
                                                        .currentTheme['textPrimary'],
                                              ),
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.room_preferences,
                                                  color:
                                                      widget
                                                          .currentTheme['textSecondary'],
                                                ),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 16,
                                                    ),
                                              ),
                                              items:
                                                  ['قياسي', 'ذهبي', 'خاص'].map((
                                                    type,
                                                  ) {
                                                    return DropdownMenuItem(
                                                      value: type,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 20,
                                                            height: 20,
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  getRoomTypeColor(
                                                                    type,
                                                                  ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    4,
                                                                  ),
                                                            ),
                                                            child: Icon(
                                                              getRoomTypeIcon(
                                                                type,
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                              size: 12,
                                                            ),
                                                          ),
                                                          SizedBox(width: 12),
                                                          Text(type),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                              onChanged: (value) {
                                                setDialogState(() {
                                                  selectedNewRoomType = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'حالة الغرفة',
                                            style: TextStyle(
                                              color:
                                                  widget
                                                      .currentTheme['textPrimary'],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  widget.currentTheme['mainBg'],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: widget
                                                    .currentTheme['textSecondary']
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            child: DropdownButtonFormField<
                                              String
                                            >(
                                              value: selectedRoomStatus,
                                              dropdownColor:
                                                  widget.currentTheme['cardBg'],
                                              style: TextStyle(
                                                color:
                                                    widget
                                                        .currentTheme['textPrimary'],
                                              ),
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.power_settings_new,
                                                  color:
                                                      widget
                                                          .currentTheme['textSecondary'],
                                                ),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 16,
                                                    ),
                                              ),
                                              items:
                                                  ['نشط', 'غير نشط'].map((
                                                    status,
                                                  ) {
                                                    return DropdownMenuItem(
                                                      value: status,
                                                      child: Text(status),
                                                    );
                                                  }).toList(),
                                              onChanged: (value) {
                                                setDialogState(() {
                                                  selectedRoomStatus = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20),

                                // معلومات المالك
                                Text(
                                  'معلومات المالك',
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'اسم المالك',
                                        controller: ownerNameController,
                                        icon: Icons.person,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'البريد الإلكتروني للمالك',
                                        controller: ownerEmailController,
                                        icon: Icons.email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20),

                                // إعدادات الغرفة
                                Text(
                                  'إعدادات الغرفة',
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'كلمة مرور الماستر',
                                        controller: masterPasswordController,
                                        icon: Icons.admin_panel_settings,
                                        obscureText: true,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'كلمة مرور الغرفة',
                                        controller: roomPasswordController,
                                        icon: Icons.lock,
                                        obscureText: true,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16),

                                _buildFormField(
                                  label: 'سعة الغرفة',
                                  controller: roomCapacityController,
                                  icon: Icons.people,
                                  keyboardType: TextInputType.number,
                                ),

                                SizedBox(height: 16),

                                // تبديل السماح بالصور
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: widget.currentTheme['mainBg'],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: widget
                                          .currentTheme['textSecondary']
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color:
                                            widget
                                                .currentTheme['textSecondary'],
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'السماح بالصور في النص',
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textPrimary'],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Switch(
                                        value: allowPictures,
                                        onChanged: (value) {
                                          setDialogState(() {
                                            allowPictures = value;
                                          });
                                        },
                                        activeColor:
                                            widget.currentTheme['accent'],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 20),

                                // الإعدادات الزمنية
                                Text(
                                  'إعدادات التاريخ',
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'تاريخ بدء الغرفة',
                                        controller: roomStartDateController,
                                        icon: Icons.date_range,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'تاريخ نهاية الغرفة',
                                        controller: roomEndDateController,
                                        icon: Icons.event,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20),

                                // حدود الحسابات
                                Text(
                                  'حدود الحسابات',
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'حد الماستر',
                                        controller: masterLimitController,
                                        icon: Icons.stars,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'حد السوبر أدمن',
                                        controller: superAdminLimitController,
                                        icon: Icons.security,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'حد الادمن',
                                        controller: adminLimitController,
                                        icon: Icons.admin_panel_settings,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: _buildFormField(
                                        label: 'حد العضو',
                                        controller: memberLimitController,
                                        icon: Icons.people,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16),

                                // حقل حد الزائر
                                _buildFormField(
                                  label: 'حد الزائر',
                                  controller: guestLimitController,
                                  icon: Icons.person_outline,
                                  keyboardType: TextInputType.number,
                                ),

                                SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ), // أزرار الإجراءات
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
                                    if (roomNameController.text.isNotEmpty &&
                                        ownerNameController.text.isNotEmpty &&
                                        ownerEmailController.text.isNotEmpty) {
                                      setState(() {
                                        chatrooms.add({
                                          'roomName': roomNameController.text,
                                          'roomStatus': selectedRoomStatus,
                                          'country':
                                              countryController.text.isNotEmpty
                                                  ? countryController.text
                                                  : 'عالمي',
                                          'roomType': selectedNewRoomType,
                                          'ownerEmail':
                                              ownerEmailController.text,
                                          'ownerName': ownerNameController.text,
                                          'masterPassword':
                                              masterPasswordController.text,
                                          'roomPassword':
                                              roomPasswordController.text,
                                          'allowPictures': allowPictures,
                                          'roomCapacity':
                                              int.tryParse(
                                                roomCapacityController.text,
                                              ) ??
                                              100,
                                          'roomStartDate':
                                              roomStartDateController
                                                      .text
                                                      .isNotEmpty
                                                  ? roomStartDateController.text
                                                  : DateTime.now()
                                                      .toString()
                                                      .substring(0, 10),
                                          'roomEndDate':
                                              roomEndDateController
                                                      .text
                                                      .isNotEmpty
                                                  ? roomEndDateController.text
                                                  : DateTime.now()
                                                      .add(Duration(days: 365))
                                                      .toString()
                                                      .substring(0, 10),
                                          'masterLimit':
                                              int.tryParse(
                                                masterLimitController.text,
                                              ) ??
                                              1,
                                          'superAdminLimit':
                                              int.tryParse(
                                                superAdminLimitController.text,
                                              ) ??
                                              2,
                                          'adminLimit':
                                              int.tryParse(
                                                adminLimitController.text,
                                              ) ??
                                              5,
                                          'memberLimit':
                                              int.tryParse(
                                                memberLimitController.text,
                                              ) ??
                                              80,
                                          'guestLimit':
                                              int.tryParse(
                                                guestLimitController.text,
                                              ) ??
                                              10,
                                          'backgroundImagePath':
                                              selectedBackgroundImagePath,
                                          'backgroundImageBytes':
                                              selectedBackgroundImageBytes,
                                          'loginHistory': [],
                                          'chatManagers': 0,
                                          'roots': 0,
                                          'currentUsers': {
                                            'master': 0,
                                            'superAdmin': 0,
                                            'admin': 0,
                                            'member': 0,
                                            'guest': 0,
                                            'total': 0,
                                          },
                                        });
                                      });
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'تم إنشاء غرفة الدردشة بنجاح!',
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
                                    'إنشاء غرفة الدردشة',
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

  void _showLoginHistory(Map<String, dynamic> room) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 500,
              height: 600,
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
                            Icons.history,
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
                                'تاريخ الدخول',
                                style: TextStyle(
                                  color: widget.currentTheme['textPrimary'],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${room['roomName']}',
                                style: TextStyle(
                                  color: widget.currentTheme['textSecondary'],
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
                  Expanded(
                    child:
                        room['loginHistory'].isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 64,
                                    color: widget.currentTheme['accent'],
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'لا يوجد سجل دخول',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: widget.currentTheme['textPrimary'],
                                    ),
                                  ),
                                  Text(
                                    'لم يقم أي مستخدم بالدخول إلى هذه الغرفة حتى الآن',
                                    style: TextStyle(
                                      color:
                                          widget.currentTheme['textSecondary'],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              itemCount: room['loginHistory'].length,
                              itemBuilder: (context, index) {
                                final login = room['loginHistory'][index];
                                return Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: widget.currentTheme['mainBg'],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: getUserTypeColor(
                                            login['userType'],
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              login['user'],
                                              style: TextStyle(
                                                color:
                                                    widget
                                                        .currentTheme['textPrimary'],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              login['userType'],
                                              style: TextStyle(
                                                color: getUserTypeColor(
                                                  login['userType'],
                                                ),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        login['timestamp'],
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textSecondary'],
                                          fontSize: 12,
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
            ),
          ),
    );
  }

  void _showRoomProfile(Map<String, dynamic> room) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                RoomProfilePage(currentTheme: widget.currentTheme, room: room),
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
            title: 'إدارة غرف الدردشة',
            subtitle: 'إدارة الغرف',
            description: 'إدارة غرف الدردشة وتكويناتها',
          ), // بطاقات الإحصائيات - أنواع الغرف
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
                        Icon(Icons.diamond, color: Color(0xFFFFD700), size: 24),
                        SizedBox(height: 8),
                        Text(
                          chatrooms
                              .where(
                                (room) =>
                                    room['roomType'] == 'ذهبي' ||
                                    room['roomType'] == 'Gold',
                              )
                              .length
                              .toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: widget.currentTheme['textPrimary'],
                          ),
                        ),
                        Text(
                          'الغرف الذهبية',
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
                        Icon(Icons.room, color: Color(0xFF87CEEB), size: 24),
                        SizedBox(height: 8),
                        Text(
                          chatrooms
                              .where(
                                (room) =>
                                    room['roomType'] == 'قياسي' ||
                                    room['roomType'] == 'Standard',
                              )
                              .length
                              .toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: widget.currentTheme['textPrimary'],
                          ),
                        ),
                        Text(
                          'الغرف القياسية',
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
                        Icon(Icons.star, color: Color(0xFFFF69B4), size: 24),
                        SizedBox(height: 8),
                        Text(
                          chatrooms
                              .where(
                                (room) =>
                                    room['roomType'] == 'خاص' ||
                                    room['roomType'] == 'Special',
                              )
                              .length
                              .toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: widget.currentTheme['textPrimary'],
                          ),
                        ),
                        Text(
                          'الغرف الخاصة',
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

          // شريط البحث والتصفية
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    style: TextStyle(color: widget.currentTheme['textPrimary']),
                    decoration: InputDecoration(
                      hintText: 'ابحث في غرف الدردشة...',
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
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedRoomType,
                    dropdownColor: widget.currentTheme['cardBg'],
                    style: TextStyle(color: widget.currentTheme['textPrimary']),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: widget.currentTheme['cardBg'],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items:
                        ['الكل', 'قياسي', 'ذهبي', 'خاص'].map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRoomType = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _showAddRoomDialog,
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    'إضافة غرفة',
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
          ), // قائمة غرف الدردشة
          Expanded(
            child:
                filteredRooms.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: widget.currentTheme['accent'],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'لم يتم العثور على غرف دردشة',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget.currentTheme['textPrimary'],
                            ),
                          ),
                          Text(
                            'حاول تعديل البحث أو التصفية',
                            style: TextStyle(
                              color: widget.currentTheme['textSecondary'],
                            ),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filteredRooms.length,
                      itemBuilder: (context, index) {
                        final room = filteredRooms[index];
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
                                color: getRoomTypeColor(room['roomType']),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: getRoomTypeColor(room['roomType']),
                                  width: 2,
                                ),
                              ),
                              child:
                                  _buildImageWidget(
                                    imagePath: room['backgroundImagePath'],
                                    imageBytes: room['backgroundImageBytes'],
                                    width: 60,
                                    height: 60,
                                  ) ??
                                  Icon(
                                    getRoomTypeIcon(room['roomType']),
                                    color: Colors.white,
                                    size: 28,
                                  ),
                            ),
                            title: Text(
                              room['roomName'],
                              style: TextStyle(
                                color: getRoomTypeColor(room['roomType']),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'المالك: ${room['ownerName']}',
                                  style: TextStyle(
                                    color: widget.currentTheme['textSecondary'],
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${room['ownerEmail']} • ${room['country']}',
                                  style: TextStyle(
                                    color: widget.currentTheme['textSecondary'],
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getRoomTypeColor(
                                          room['roomType'],
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            getRoomTypeIcon(room['roomType']),
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            room['roomType'],
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
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            room['roomStatus'] == 'نشط' ||
                                                    room['roomStatus'] ==
                                                        'Active'
                                                ? Colors.green
                                                : Colors.orange,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        room['roomStatus'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'السعة: ${room['roomCapacity']}',
                                      style: TextStyle(
                                        color:
                                            widget
                                                .currentTheme['textSecondary'],
                                        fontSize: 12,
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
                                            color:
                                                widget
                                                    .currentTheme['textPrimary'],
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'تعديل',
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
                                          SizedBox(width: 8),
                                          Text(
                                            'حذف',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'user_count',
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.groups,
                                            color: Colors.green,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'عدد المستخدمين',
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'room_profile',
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.account_circle,
                                            color:
                                                widget.currentTheme['accent'],
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'ملف الغرفة',
                                            style: TextStyle(
                                              color:
                                                  widget.currentTheme['accent'],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 'login',
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.history,
                                            color: Colors.blue,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'تاريخ الدخول',
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                              onSelected: (value) {
                                switch (value) {
                                  case 'edit':
                                    // تنفيذ فعل التعديل
                                    break;
                                  case 'delete':
                                    setState(() {
                                      chatrooms.remove(room);
                                    });
                                    break;
                                  case 'user_count':
                                    _showUserCountDialog(room);
                                    break;
                                  case 'room_profile':
                                    _showRoomProfile(room);
                                    break;
                                  case 'login':
                                    _showLoginHistory(room);
                                    break;
                                }
                              },
                            ),
                            children: [
                              // لوحة معلومات الغرفة المفصلة
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: widget.currentTheme['mainBg'],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // صورة خلفية الغرفة
                                    if (room['backgroundImagePath'] != null ||
                                        room['backgroundImageBytes'] != null)
                                      Container(
                                        width: double.infinity,
                                        height: 150,
                                        margin: EdgeInsets.only(bottom: 16),
                                        child: _buildImageWidget(
                                          imagePath:
                                              room['backgroundImagePath'],
                                          imageBytes:
                                              room['backgroundImageBytes'],
                                          width: double.infinity,
                                          height: 150,
                                        ),
                                      ), // إعدادات الغرفة
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildInfoCard(
                                            'السماح بالصور',
                                            room['allowPictures']
                                                ? 'نعم'
                                                : 'لا',
                                            Icons.image,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: _buildInfoCard(
                                            'سعة الغرفة',
                                            room['roomCapacity'].toString(),
                                            Icons.people,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),

                                    // معلومات التاريخ
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildInfoCard(
                                            'تاريخ البدء',
                                            room['roomStartDate'],
                                            Icons.date_range,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: _buildInfoCard(
                                            'تاريخ الانتهاء',
                                            room['roomEndDate'],
                                            Icons.event,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16), // حدود الحسابات
                                    Text(
                                      'حدود الحسابات',
                                      style: TextStyle(
                                        color:
                                            widget.currentTheme['textPrimary'],
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildStatCard(
                                            'ماستر',
                                            room['masterLimit'].toString(),
                                            Icons.stars,
                                            Colors.red,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: _buildStatCard(
                                            'سوبر أدمن',
                                            room['superAdminLimit'].toString(),
                                            Icons.security,
                                            Colors.blue,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: _buildStatCard(
                                            'ادمن',
                                            room['adminLimit'].toString(),
                                            Icons.admin_panel_settings,
                                            Colors.green,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: _buildStatCard(
                                            'عضو',
                                            room['memberLimit'].toString(),
                                            Icons.people,
                                            Colors.purple,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    // بطاقة حد الزائر
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildStatCard(
                                            'زائر',
                                            room['guestLimit'].toString(),
                                            Icons.person_outline,
                                            Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: SizedBox(),
                                        ), // مساحة فارغة
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: SizedBox(),
                                        ), // مساحة فارغة
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: SizedBox(),
                                        ), // مساحة فارغة
                                      ],
                                    ),
                                    SizedBox(height: 16),

                                    // إحصائيات الإدارة
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildInfoCard(
                                            'مدراء الدردشة',
                                            room['chatManagers'].toString(),
                                            Icons.manage_accounts,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: _buildInfoCard(
                                            'الجذور',
                                            room['roots'].toString(),
                                            Icons.verified_user,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),

                                    // معلومات كلمات المرور
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildInfoCard(
                                            'كلمة مرور الماستر',
                                            room['masterPassword'].isNotEmpty
                                                ? '••••••••'
                                                : 'غير مُعينة',
                                            Icons.admin_panel_settings,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: _buildInfoCard(
                                            'كلمة مرور الغرفة',
                                            room['roomPassword'].isNotEmpty
                                                ? '••••••••'
                                                : 'غير مُعينة',
                                            Icons.lock,
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
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
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
                title,
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
            value,
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

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
