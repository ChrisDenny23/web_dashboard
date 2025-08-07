// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_web_libraries_in_flutter, file_names

import 'package:flutter/material.dart';
import '../widgets/enhanced_header.dart';

class LogsPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const LogsPage({super.key, required this.currentTheme});

  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  List<Map<String, dynamic>> logs = [
    {
      'name': 'جون سميث',
      'country': 'الولايات المتحدة',
      'room': 'النقاش العام',
      'ipAddress': '192.168.1.101',
      'time': '2024-08-05 14:30:22',
      'entryTime': '2024-08-05 14:30:22',
      'checkoutTime': '2024-08-05 15:45:10',
      'duration': '1س 14د',
      'status': 'مكتمل',
    },
    {
      'name': 'ماريا غارسيا',
      'country': 'إسبانيا',
      'room': 'الدعم الفني',
      'ipAddress': '172.16.0.85',
      'time': '2024-08-05 15:20:15',
      'entryTime': '2024-08-05 15:20:15',
      'checkoutTime': null,
      'duration': 'نشط',
      'status': 'متصل',
    },
    {
      'name': 'أحمد حسن',
      'country': 'مصر',
      'room': 'النقاش العام',
      'ipAddress': '198.51.100.55',
      'time': '2024-08-05 13:45:30',
      'entryTime': '2024-08-05 13:45:30',
      'checkoutTime': '2024-08-05 14:20:45',
      'duration': '35د',
      'status': 'مكتمل',
    },
    {
      'name': 'ليزا تشين',
      'country': 'الصين',
      'room': 'منطقة الألعاب',
      'ipAddress': '10.0.0.95',
      'time': '2024-08-05 16:10:05',
      'entryTime': '2024-08-05 16:10:05',
      'checkoutTime': null,
      'duration': 'نشط',
      'status': 'متصل',
    },
    {
      'name': 'روبرت جونسون',
      'country': 'كندا',
      'room': 'الدعم الفني',
      'ipAddress': '192.168.2.178',
      'time': '2024-08-05 12:30:45',
      'entryTime': '2024-08-05 12:30:45',
      'checkoutTime': '2024-08-05 13:15:20',
      'duration': '44د',
      'status': 'مكتمل',
    },
    {
      'name': 'صوفي مارتن',
      'country': 'فرنسا',
      'room': 'النقاش العام',
      'ipAddress': '203.0.113.88',
      'time': '2024-08-05 11:45:12',
      'entryTime': '2024-08-05 11:45:12',
      'checkoutTime': '2024-08-05 12:30:50',
      'duration': '45د',
      'status': 'مكتمل',
    },
    {
      'name': 'هيروشي تاناكا',
      'country': 'اليابان',
      'room': 'منطقة الألعاب',
      'ipAddress': '198.51.100.77',
      'time': '2024-08-05 17:20:30',
      'entryTime': '2024-08-05 17:20:30',
      'checkoutTime': null,
      'duration': 'نشط',
      'status': 'متصل',
    },
    {
      'name': 'إيما ويلسون',
      'country': 'أستراليا',
      'room': 'مجموعة الدراسة',
      'ipAddress': '172.16.1.99',
      'time': '2024-08-05 10:15:25',
      'entryTime': '2024-08-05 10:15:25',
      'checkoutTime': '2024-08-05 11:30:15',
      'duration': '1س 14د',
      'status': 'مكتمل',
    },
  ];

  String searchQuery = '';
  String selectedRoomFilter = 'كل الغرف';
  List<String> availableRooms = ['كل الغرف'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animationController.forward();

    // Extract unique room names for filtering
    Set<String> rooms = logs.map((log) => log['room'] as String).toSet();
    availableRooms.addAll(rooms);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredLogs {
    return logs.where((log) {
      final matchesSearch =
          log['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          log['country'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          log['room'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          log['ipAddress'].toLowerCase().contains(searchQuery.toLowerCase());

      final matchesRoom =
          selectedRoomFilter == 'كل الغرف' || log['room'] == selectedRoomFilter;

      return matchesSearch && matchesRoom;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'متصل':
        return Colors.green;
      case 'مكتمل':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'متصل':
        return Icons.circle;
      case 'مكتمل':
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  void _showDeleteAllDialog() {
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
                const Icon(Icons.delete_sweep, color: Colors.red, size: 24),
                const SizedBox(width: 12),
                Text(
                  'حذف جميع السجلات',
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
                  'هل أنت متأكد من حذف جميع السجلات؟ لا يمكن التراجع عن هذا الإجراء.',
                  style: TextStyle(
                    color: widget.currentTheme['textPrimary'],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'سيتم حذف ${logs.length} سجل نهائيًا.',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
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
                    logs.clear();
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('تم حذف جميع السجلات بنجاح!'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'حذف الكل',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _showDeleteRoomLogsDialog() {
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
                const Icon(
                  Icons.delete_outline,
                  color: Colors.orange,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'حذف سجلات الغرفة',
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
                  'اختر غرفة لحذف جميع سجلاتها:',
                  style: TextStyle(
                    color: widget.currentTheme['textPrimary'],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: widget.currentTheme['mainBg'],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: widget.currentTheme['textSecondary'].withOpacity(
                        0.3,
                      ),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value:
                          selectedRoomFilter == 'كل الغرف'
                              ? availableRooms.firstWhere(
                                (room) => room != 'كل الغرف',
                              )
                              : selectedRoomFilter,
                      isExpanded: true,
                      dropdownColor: widget.currentTheme['cardBg'],
                      style: TextStyle(
                        color: widget.currentTheme['textPrimary'],
                      ),
                      items:
                          availableRooms
                              .where((room) => room != 'كل الغرف')
                              .map((String room) {
                                final roomLogCount =
                                    logs
                                        .where((log) => log['room'] == room)
                                        .length;
                                return DropdownMenuItem<String>(
                                  value: room,
                                  child: Text('$room ($roomLogCount سجل)'),
                                );
                              })
                              .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRoomFilter = newValue!;
                        });
                      },
                    ),
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
                  final roomToDelete =
                      selectedRoomFilter == 'كل الغرف'
                          ? availableRooms.firstWhere(
                            (room) => room != 'كل الغرف',
                          )
                          : selectedRoomFilter;

                  final logsToDeleteCount =
                      logs.where((log) => log['room'] == roomToDelete).length;

                  setState(() {
                    logs.removeWhere((log) => log['room'] == roomToDelete);
                    // After deletions, update availableRooms to reflect current state:
                    final currentRooms =
                        logs.map((log) => log['room'] as String).toSet();
                    availableRooms = ['كل الغرف'];
                    availableRooms.addAll(currentRooms);
                    if (!availableRooms.contains(selectedRoomFilter)) {
                      selectedRoomFilter = 'كل الغرف';
                    }
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'تم حذف $logsToDeleteCount سجل من $roomToDelete',
                      ),
                      backgroundColor: Colors.orange,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'حذف سجلات الغرفة',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon, {
    Color? valueColor,
    double? titleFontSize,
    double? valueFontSize,
    double? iconSize,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
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
                size: iconSize ?? 16,
                color: widget.currentTheme['textSecondary'],
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: titleFontSize ?? 12,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? widget.currentTheme['textPrimary'],
              fontSize: valueFontSize ?? 14,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Responsive helper values based on screen width
    final width = MediaQuery.of(context).size.width;

    // Define breakpoints
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    // Padding/margins based on device type
    final pageMargin =
        isMobile
            ? EdgeInsets.zero
            : EdgeInsets.only(top: 16, right: 16, bottom: 16, left: 16);

    final horizontalPadding =
        isMobile
            ? 12.0
            : isTablet
            ? 20.0
            : 40.0;

    final cardPadding =
        isMobile
            ? 12.0
            : isTablet
            ? 16.0
            : 24.0;

    final cardBorderRadius = isMobile ? 12.0 : 16.0;

    final iconSize =
        isMobile
            ? 20.0
            : isTablet
            ? 24.0
            : 28.0;

    final fontSizeSmall = isMobile ? 10.0 : 12.0;
    final fontSizeMedium = isMobile ? 14.0 : 16.0;
    final fontSizeLarge = isMobile ? 16.0 : 18.0;
    final fontSizeExtraLarge = isMobile ? 18.0 : 20.0;

    final buttonVerticalPadding = isMobile ? 10.0 : 12.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: pageMargin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardBorderRadius),
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
            title: 'سجلات النظام',
            subtitle: 'متابعة نشاط المستخدمين',
            description: 'مراقبة جلسات وأنشطة المستخدمين',
          ),

          /// Statistics cards - responsive layout with wrapping on small screens
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 10,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // On narrow widths wrap cards vertically or with spacing
                final maxWidth = constraints.maxWidth;
                // If enough space for 3 cards horizontally, use Row
                if (maxWidth >= 600) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(cardPadding),
                          decoration: BoxDecoration(
                            color: widget.currentTheme['cardBg'],
                            borderRadius: BorderRadius.circular(
                              cardBorderRadius,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.currentTheme['shadow'],
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.list_alt,
                                color: Colors.blue,
                                size: iconSize,
                              ),
                              SizedBox(height: isMobile ? 6 : 8),
                              Text(
                                logs.length.toString(),
                                style: TextStyle(
                                  fontSize: fontSizeExtraLarge,
                                  fontWeight: FontWeight.bold,
                                  color: widget.currentTheme['textPrimary'],
                                ),
                              ),
                              Text(
                                'إجمالي السجلات',
                                style: TextStyle(
                                  fontSize: fontSizeSmall,
                                  color: widget.currentTheme['textSecondary'],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: isMobile ? 8 : 12),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(cardPadding),
                          decoration: BoxDecoration(
                            color: widget.currentTheme['cardBg'],
                            borderRadius: BorderRadius.circular(
                              cardBorderRadius,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.currentTheme['shadow'],
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: iconSize,
                              ),
                              SizedBox(height: isMobile ? 6 : 8),
                              Text(
                                logs
                                    .where((log) => log['status'] == 'متصل')
                                    .length
                                    .toString(),
                                style: TextStyle(
                                  fontSize: fontSizeExtraLarge,
                                  fontWeight: FontWeight.bold,
                                  color: widget.currentTheme['textPrimary'],
                                ),
                              ),
                              Text(
                                'المستخدمون المتصلون',
                                style: TextStyle(
                                  fontSize: fontSizeSmall,
                                  color: widget.currentTheme['textSecondary'],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: isMobile ? 8 : 12),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(cardPadding),
                          decoration: BoxDecoration(
                            color: widget.currentTheme['cardBg'],
                            borderRadius: BorderRadius.circular(
                              cardBorderRadius,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.currentTheme['shadow'],
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.meeting_room,
                                color: Colors.purple,
                                size: iconSize,
                              ),
                              SizedBox(height: isMobile ? 6 : 8),
                              Text(
                                (availableRooms.length - 1)
                                    .toString(), // exclude "كل الغرف"
                                style: TextStyle(
                                  fontSize: fontSizeExtraLarge,
                                  fontWeight: FontWeight.bold,
                                  color: widget.currentTheme['textPrimary'],
                                ),
                              ),
                              Text(
                                'الغرف النشطة',
                                style: TextStyle(
                                  fontSize: fontSizeSmall,
                                  color: widget.currentTheme['textSecondary'],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Stack cards vertically with spacing for mobile
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(cardPadding),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: widget.currentTheme['cardBg'],
                          borderRadius: BorderRadius.circular(cardBorderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: widget.currentTheme['shadow'],
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.list_alt,
                              color: Colors.blue,
                              size: iconSize,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  logs.length.toString(),
                                  style: TextStyle(
                                    fontSize: fontSizeLarge,
                                    fontWeight: FontWeight.bold,
                                    color: widget.currentTheme['textPrimary'],
                                  ),
                                ),
                                Text(
                                  'إجمالي السجلات',
                                  style: TextStyle(
                                    fontSize: fontSizeSmall,
                                    color: widget.currentTheme['textSecondary'],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(cardPadding),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: widget.currentTheme['cardBg'],
                          borderRadius: BorderRadius.circular(cardBorderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: widget.currentTheme['shadow'],
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: iconSize,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  logs
                                      .where((log) => log['status'] == 'متصل')
                                      .length
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: fontSizeLarge,
                                    fontWeight: FontWeight.bold,
                                    color: widget.currentTheme['textPrimary'],
                                  ),
                                ),
                                Text(
                                  'المستخدمون المتصلون',
                                  style: TextStyle(
                                    fontSize: fontSizeSmall,
                                    color: widget.currentTheme['textSecondary'],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(cardPadding),
                        decoration: BoxDecoration(
                          color: widget.currentTheme['cardBg'],
                          borderRadius: BorderRadius.circular(cardBorderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: widget.currentTheme['shadow'],
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.meeting_room,
                              color: Colors.purple,
                              size: iconSize,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (availableRooms.length - 1).toString(),
                                  style: TextStyle(
                                    fontSize: fontSizeLarge,
                                    fontWeight: FontWeight.bold,
                                    color: widget.currentTheme['textPrimary'],
                                  ),
                                ),
                                Text(
                                  'الغرف النشطة',
                                  style: TextStyle(
                                    fontSize: fontSizeSmall,
                                    color: widget.currentTheme['textSecondary'],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),

          /// Action buttons
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 10,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;
                if (maxWidth >= 600) {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _showDeleteAllDialog,
                          icon: const Icon(
                            Icons.delete_sweep,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'حذف جميع السجلات',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                              vertical: buttonVerticalPadding,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: isMobile ? 8 : 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _showDeleteRoomLogsDialog,
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'حذف سجلات الغرفة',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(
                              vertical: buttonVerticalPadding,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // On small screens stack vertically
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _showDeleteAllDialog,
                          icon: const Icon(
                            Icons.delete_sweep,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'حذف جميع السجلات',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                              vertical: buttonVerticalPadding,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _showDeleteRoomLogsDialog,
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'حذف سجلات الغرفة',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(
                              vertical: buttonVerticalPadding,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
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

          /// Search & filter row
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 10,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive: stack vertically/mobile or horizontal/tablet+
                if (constraints.maxWidth >= 600) {
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
                            hintText: 'ابحث في السجلات...',
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: widget.currentTheme['cardBg'],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedRoomFilter,
                              isExpanded: true,
                              dropdownColor: widget.currentTheme['cardBg'],
                              style: TextStyle(
                                color: widget.currentTheme['textPrimary'],
                              ),
                              items:
                                  availableRooms.map((String room) {
                                    return DropdownMenuItem<String>(
                                      value: room,
                                      child: Text(
                                        room,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedRoomFilter = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
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
                          hintText: 'ابحث في السجلات...',
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
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: widget.currentTheme['cardBg'],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedRoomFilter,
                            isExpanded: true,
                            dropdownColor: widget.currentTheme['cardBg'],
                            style: TextStyle(
                              color: widget.currentTheme['textPrimary'],
                            ),
                            items:
                                availableRooms.map((String room) {
                                  return DropdownMenuItem<String>(
                                    value: room,
                                    child: Text(
                                      room,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRoomFilter = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),

          /// Logs list - Expanded with scroll
          Expanded(
            child: _buildLogsList(
              iconSize: iconSize,
              fontSizeSmall: fontSizeSmall,
              fontSizeMedium: fontSizeMedium,
              fontSizeLarge: fontSizeLarge,
              cardPadding: cardPadding,
              cardBorderRadius: cardBorderRadius,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogsList({
    required double iconSize,
    required double fontSizeSmall,
    required double fontSizeMedium,
    required double fontSizeLarge,
    required double cardPadding,
    required double cardBorderRadius,
  }) {
    if (filteredLogs.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.list_alt,
                size: 64,
                color: widget.currentTheme['accent'],
              ),
              const SizedBox(height: 16),
              Text(
                'لم يتم العثور على سجلات',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: widget.currentTheme['textPrimary'],
                ),
              ),
              Text(
                'حاول تعديل البحث أو التصفية',
                style: TextStyle(color: widget.currentTheme['textSecondary']),
              ),
            ],
          ),
        ),
      );
    }

    return Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      thickness: 8,
      radius: const Radius.circular(8),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: cardPadding),
        itemCount: filteredLogs.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final log = filteredLogs[index];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: widget.currentTheme['cardBg'],
              borderRadius: BorderRadius.circular(cardBorderRadius),
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
                width: iconSize + 20,
                height: iconSize + 20,
                decoration: BoxDecoration(
                  color: getStatusColor(log['status']),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  getStatusIcon(log['status']),
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    log['name'],
                    style: TextStyle(
                      color: widget.currentTheme['textPrimary'],
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeLarge,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    log['country'],
                    style: TextStyle(
                      color: widget.currentTheme['accent'],
                      fontSize: fontSizeMedium,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'الغرفة: ${log['room']}',
                    style: TextStyle(
                      color: widget.currentTheme['textSecondary'],
                      fontSize: fontSizeSmall,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'IP: ${log['ipAddress']}',
                    style: TextStyle(
                      color: widget.currentTheme['textSecondary'],
                      fontSize: fontSizeSmall,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'المدة: ${log['duration']}',
                    style: TextStyle(
                      color: widget.currentTheme['textSecondary'],
                      fontSize: fontSizeSmall,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: getStatusColor(log['status']),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          getStatusIcon(log['status']),
                          color: Colors.white,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          log['status'],
                          style: const TextStyle(
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
              trailing: Icon(
                Icons.expand_more,
                color: widget.currentTheme['textSecondary'],
              ),
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.currentTheme['mainBg'],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: LayoutBuilder(
                    builder: (
                      BuildContext context,
                      BoxConstraints constraints,
                    ) {
                      final childWidth = constraints.maxWidth;

                      final isNarrow = childWidth < 600;

                      // We'll use Columns and Rows adaptively
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isNarrow
                              ? Column(
                                children: [
                                  // Country & Room
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildInfoCard(
                                          'البلد',
                                          log['country'],
                                          Icons.flag,
                                          titleFontSize: fontSizeSmall,
                                          valueFontSize: fontSizeMedium,
                                          iconSize: 18,
                                          padding: const EdgeInsets.all(8),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _buildInfoCard(
                                          'الغرفة',
                                          log['room'],
                                          Icons.meeting_room,
                                          titleFontSize: fontSizeSmall,
                                          valueFontSize: fontSizeMedium,
                                          iconSize: 18,
                                          padding: const EdgeInsets.all(8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  // IP & Status
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildInfoCard(
                                          'عنوان IP',
                                          log['ipAddress'],
                                          Icons.computer,
                                          titleFontSize: fontSizeSmall,
                                          valueFontSize: fontSizeMedium,
                                          iconSize: 18,
                                          padding: const EdgeInsets.all(8),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _buildInfoCard(
                                          'الحالة',
                                          log['status'],
                                          Icons.info,
                                          valueColor: getStatusColor(
                                            log['status'],
                                          ),
                                          titleFontSize: fontSizeSmall,
                                          valueFontSize: fontSizeMedium,
                                          iconSize: 18,
                                          padding: const EdgeInsets.all(8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  // Entry & Checkout time
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildInfoCard(
                                          'وقت الدخول',
                                          log['entryTime'],
                                          Icons.login,
                                          titleFontSize: fontSizeSmall,
                                          valueFontSize: fontSizeMedium,
                                          iconSize: 18,
                                          padding: const EdgeInsets.all(8),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _buildInfoCard(
                                          'وقت الخروج',
                                          log['checkoutTime'] ?? 'متصل حاليًا',
                                          Icons.logout,
                                          valueColor:
                                              log['checkoutTime'] == null
                                                  ? Colors.green
                                                  : null,
                                          titleFontSize: fontSizeSmall,
                                          valueFontSize: fontSizeMedium,
                                          iconSize: 18,
                                          padding: const EdgeInsets.all(8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  // Duration & Log time
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildInfoCard(
                                          'مدة الجلسة',
                                          log['duration'],
                                          Icons.timer,
                                          valueColor:
                                              log['duration'] == 'نشط'
                                                  ? Colors.green
                                                  : null,
                                          titleFontSize: fontSizeSmall,
                                          valueFontSize: fontSizeMedium,
                                          iconSize: 18,
                                          padding: const EdgeInsets.all(8),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _buildInfoCard(
                                          'وقت السجل',
                                          log['time'],
                                          Icons.schedule,
                                          titleFontSize: fontSizeSmall,
                                          valueFontSize: fontSizeMedium,
                                          iconSize: 18,
                                          padding: const EdgeInsets.all(8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                              : Wrap(
                                runSpacing: 12,
                                spacing: 12,
                                children: [
                                  SizedBox(
                                    width: (childWidth - 36) / 3,
                                    child: _buildInfoCard(
                                      'البلد',
                                      log['country'],
                                      Icons.flag,
                                      titleFontSize: fontSizeSmall,
                                      valueFontSize: fontSizeMedium,
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(12),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (childWidth - 36) / 3,
                                    child: _buildInfoCard(
                                      'الغرفة',
                                      log['room'],
                                      Icons.meeting_room,
                                      titleFontSize: fontSizeSmall,
                                      valueFontSize: fontSizeMedium,
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(12),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (childWidth - 36) / 3,
                                    child: _buildInfoCard(
                                      'عنوان IP',
                                      log['ipAddress'],
                                      Icons.computer,
                                      titleFontSize: fontSizeSmall,
                                      valueFontSize: fontSizeMedium,
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(12),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (childWidth - 36) / 3,
                                    child: _buildInfoCard(
                                      'الحالة',
                                      log['status'],
                                      Icons.info,
                                      valueColor: getStatusColor(log['status']),
                                      titleFontSize: fontSizeSmall,
                                      valueFontSize: fontSizeMedium,
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(12),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (childWidth - 36) / 3,
                                    child: _buildInfoCard(
                                      'وقت الدخول',
                                      log['entryTime'],
                                      Icons.login,
                                      titleFontSize: fontSizeSmall,
                                      valueFontSize: fontSizeMedium,
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(12),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (childWidth - 36) / 3,
                                    child: _buildInfoCard(
                                      'وقت الخروج',
                                      log['checkoutTime'] ?? 'متصل حاليًا',
                                      Icons.logout,
                                      valueColor:
                                          log['checkoutTime'] == null
                                              ? Colors.green
                                              : null,
                                      titleFontSize: fontSizeSmall,
                                      valueFontSize: fontSizeMedium,
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(12),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (childWidth - 36) / 3,
                                    child: _buildInfoCard(
                                      'مدة الجلسة',
                                      log['duration'],
                                      Icons.timer,
                                      valueColor:
                                          log['duration'] == 'نشط'
                                              ? Colors.green
                                              : null,
                                      titleFontSize: fontSizeSmall,
                                      valueFontSize: fontSizeMedium,
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(12),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (childWidth - 36) / 3,
                                    child: _buildInfoCard(
                                      'وقت السجل',
                                      log['time'],
                                      Icons.schedule,
                                      titleFontSize: fontSizeSmall,
                                      valueFontSize: fontSizeMedium,
                                      iconSize: 18,
                                      padding: const EdgeInsets.all(12),
                                    ),
                                  ),
                                ],
                              ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
