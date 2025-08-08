// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import '../widgets/enhanced_header.dart';

class ReportsPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const ReportsPage({super.key, required this.currentTheme});

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  List<Map<String, dynamic>> reports = [
    {
      'id': 'RPT001',
      'type': 'Room Report',
      'reporterName': 'John Smith',
      'roomName': 'Gaming Lounge',
      'userName': '',
      'profileName': '',
      'dateTime': '2024-08-08 14:30:00',
      'reason': 'محتوى غير لائق يتم مشاركته في الغرفة',
      'status': 'Pending',
      'priority': 'High',
    },
    {
      'id': 'RPT002',
      'type': 'User Report',
      'reporterName': 'Sarah Johnson',
      'roomName': '',
      'userName': 'toxic_user123',
      'profileName': '',
      'dateTime': '2024-08-07 16:45:00',
      'reason': 'سلوك مضايقة وتنمر',
      'status': 'Under Review',
      'priority': 'High',
    },
    {
      'id': 'RPT003',
      'type': 'Profile Report',
      'reporterName': 'Mike Chen',
      'roomName': '',
      'userName': '',
      'profileName': 'fake_celebrity',
      'dateTime': '2024-08-06 10:20:00',
      'reason': 'ملف وهمي ينتحل شخصية مشهورة',
      'status': 'Resolved',
      'priority': 'Medium',
    },
    {
      'id': 'RPT004',
      'type': 'Room Report',
      'reporterName': 'Emily Davis',
      'roomName': 'Music Chat',
      'userName': '',
      'profileName': '',
      'dateTime': '2024-08-05 18:15:00',
      'reason': 'رسائل ترويجية وإعلانات مزعجة',
      'status': 'Pending',
      'priority': 'Low',
    },
    {
      'id': 'RPT005',
      'type': 'User Report',
      'reporterName': 'David Wilson',
      'roomName': '',
      'userName': 'spam_bot_user',
      'profileName': '',
      'dateTime': '2024-08-04 12:00:00',
      'reason': 'رسائل سبام آلية',
      'status': 'Under Review',
      'priority': 'High',
    },
  ];

  String searchQuery = '';
  String selectedFilter = 'الكل';

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

  List<Map<String, dynamic>> get filteredReports {
    return reports.where((report) {
      final matchesSearch =
          report['reporterName'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          report['roomName'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          report['userName'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          report['profileName'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          report['reason'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          );

      final matchesFilter =
          selectedFilter == 'الكل' ||
          (selectedFilter == 'قيد الانتظار' && report['status'] == 'Pending') ||
          (selectedFilter == 'قيد المراجعة' &&
              report['status'] == 'Under Review') ||
          (selectedFilter == 'تم الحل' && report['status'] == 'Resolved') ||
          (selectedFilter == 'مرفوض' && report['status'] == 'Rejected');

      return matchesSearch && matchesFilter;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Under Review':
        return Colors.blue;
      case 'Resolved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData getReportTypeIcon(String type) {
    switch (type) {
      case 'Room Report':
        return Icons.meeting_room;
      case 'User Report':
        return Icons.person;
      case 'Profile Report':
        return Icons.account_circle;
      default:
        return Icons.report;
    }
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
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
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: widget.currentTheme['textSecondary'],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? 'غير متوفر' : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    double spacing = 12;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: widget.currentTheme['mainBg'],
          body: Column(
            children: [
              EnhancedHeader(
                currentTheme: widget.currentTheme,
                title: 'إدارة التقارير',
                subtitle: 'تقارير المستخدمين والغرف والملفات الشخصية',
                description: 'مراقبة وإدارة جميع تقارير المنصة',
              ),

              // Stats Cards with horizontal scroll on small screens
              Container(
                height: 120,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _statsCard(
                        context,
                        Icons.report,
                        Colors.blue,
                        reports.length.toString(),
                        'إجمالي التقارير',
                        16,
                        24,
                        18,
                        12,
                      ),
                      SizedBox(width: spacing),
                      _statsCard(
                        context,
                        Icons.pending,
                        Colors.orange,
                        reports
                            .where((r) => r['status'] == 'Pending')
                            .length
                            .toString(),
                        'قيد الانتظار',
                        16,
                        24,
                        18,
                        12,
                      ),
                      SizedBox(width: spacing),
                      _statsCard(
                        context,
                        Icons.rate_review,
                        Colors.blue,
                        reports
                            .where((r) => r['status'] == 'Under Review')
                            .length
                            .toString(),
                        'قيد المراجعة',
                        16,
                        24,
                        18,
                        12,
                      ),
                      SizedBox(width: spacing),
                      _statsCard(
                        context,
                        Icons.check_circle,
                        Colors.green,
                        reports
                            .where((r) => r['status'] == 'Resolved')
                            .length
                            .toString(),
                        'تم الحل',
                        16,
                        24,
                        18,
                        12,
                      ),
                    ],
                  ),
                ),
              ),

              // Search and Filter
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 600) {
                      return Column(
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
                              hintText: 'ابحث في التقارير...',
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
                                value: selectedFilter,
                                isExpanded: true,
                                dropdownColor: widget.currentTheme['cardBg'],
                                style: TextStyle(
                                  color: widget.currentTheme['textPrimary'],
                                ),
                                items:
                                    [
                                      'الكل',
                                      'قيد الانتظار',
                                      'قيد المراجعة',
                                      'تم الحل',
                                      'مرفوض',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedFilter = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
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
                                hintText: 'ابحث في التقارير...',
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
                          SizedBox(width: spacing),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: widget.currentTheme['cardBg'],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedFilter,
                                  isExpanded: true,
                                  dropdownColor: widget.currentTheme['cardBg'],
                                  style: TextStyle(
                                    color: widget.currentTheme['textPrimary'],
                                  ),
                                  items:
                                      [
                                        'الكل',
                                        'قيد الانتظار',
                                        'قيد المراجعة',
                                        'تم الحل',
                                        'مرفوض',
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedFilter = newValue!;
                                    });
                                  },
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

              // Reports List
              Expanded(
                child:
                    filteredReports.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.report_off,
                                size: 64,
                                color: widget.currentTheme['accent'],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'لم يتم العثور على تقارير',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: widget.currentTheme['textPrimary'],
                                ),
                              ),
                              Text(
                                'حاول تعديل البحث أو الفلتر',
                                style: TextStyle(
                                  color: widget.currentTheme['textSecondary'],
                                ),
                              ),
                            ],
                          ),
                        )
                        : Scrollbar(
                          thumbVisibility: true,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: filteredReports.length,
                            itemBuilder: (context, index) {
                              final report = filteredReports[index];
                              double tileTitleFontSize = 18;
                              double tileSubtitleFontSize = 12;
                              double tileIconSize = 24;

                              if (screenWidth >= 1200) {
                                tileTitleFontSize = 22;
                                tileSubtitleFontSize = 16;
                                tileIconSize = 32;
                              } else if (screenWidth >= 800) {
                                tileTitleFontSize = 20;
                                tileSubtitleFontSize = 14;
                                tileIconSize = 28;
                              }

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: EdgeInsets.only(bottom: spacing),
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
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.all(16),
                                  childrenPadding: EdgeInsets.all(16),
                                  leading: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: getStatusColor(report['status']),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      getReportTypeIcon(report['type']),
                                      color: Colors.white,
                                      size: tileIconSize,
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              report['type'] == 'Room Report'
                                                  ? 'تقرير غرفة'
                                                  : report['type'] ==
                                                      'User Report'
                                                  ? 'تقرير مستخدم'
                                                  : 'تقرير ملف شخصي',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color:
                                                    widget
                                                        .currentTheme['textPrimary'],
                                                fontWeight: FontWeight.bold,
                                                fontSize: tileTitleFontSize,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: getPriorityColor(
                                                report['priority'],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              report['priority'] == 'High'
                                                  ? 'عالية'
                                                  : report['priority'] ==
                                                      'Medium'
                                                  ? 'متوسطة'
                                                  : 'منخفضة',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'معرف التقرير: ${report['id']}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: widget.currentTheme['accent'],
                                          fontSize: tileSubtitleFontSize,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        'المبلغ: ${report['reporterName']}',
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textSecondary'],
                                          fontSize: tileSubtitleFontSize,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'التاريخ: ${report['dateTime']}',
                                        style: TextStyle(
                                          color:
                                              widget
                                                  .currentTheme['textSecondary'],
                                          fontSize: tileSubtitleFontSize,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: getStatusColor(
                                            report['status'],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              report['status'] == 'Pending'
                                                  ? Icons.pending
                                                  : report['status'] ==
                                                      'Under Review'
                                                  ? Icons.rate_review
                                                  : report['status'] ==
                                                      'Resolved'
                                                  ? Icons.check_circle
                                                  : Icons.cancel,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              report['status'] == 'Pending'
                                                  ? 'قيد الانتظار'
                                                  : report['status'] ==
                                                      'Under Review'
                                                  ? 'قيد المراجعة'
                                                  : report['status'] ==
                                                      'Resolved'
                                                  ? 'تم الحل'
                                                  : 'مرفوض',
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
                                  trailing: PopupMenuButton<String>(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color:
                                          widget.currentTheme['textSecondary'],
                                    ),
                                    itemBuilder:
                                        (context) => [
                                          if (report['status'] != 'Resolved')
                                            const PopupMenuItem(
                                              value: 'resolve',
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text('تعيين كمحلول'),
                                                ],
                                              ),
                                            ),
                                          if (report['status'] == 'Pending')
                                            const PopupMenuItem(
                                              value: 'review',
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.rate_review,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text('قيد المراجعة'),
                                                ],
                                              ),
                                            ),
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 8),
                                                Text('حذف التقرير'),
                                              ],
                                            ),
                                          ),
                                        ],
                                    onSelected: (value) {
                                      setState(() {
                                        if (value == 'resolve') {
                                          report['status'] = 'Resolved';
                                        } else if (value == 'review') {
                                          report['status'] = 'Under Review';
                                        } else if (value == 'delete') {
                                          reports.remove(report);
                                        }
                                      });
                                      if (value != 'delete') {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              'تم تحديث حالة التقرير بنجاح!',
                                            ),
                                            backgroundColor: Colors.green,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: widget.currentTheme['mainBg'],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            spacing: spacing,
                                            runSpacing: spacing,
                                            children: [
                                              SizedBox(
                                                width:
                                                    (screenWidth < 700)
                                                        ? double.infinity
                                                        : (screenWidth / 2) -
                                                            (spacing * 4),
                                                child: _buildInfoCard(
                                                  'معرف التقرير',
                                                  report['id'],
                                                  Icons.badge,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    (screenWidth < 700)
                                                        ? double.infinity
                                                        : (screenWidth / 2) -
                                                            (spacing * 4),
                                                child: _buildInfoCard(
                                                  'اسم المبلغ',
                                                  report['reporterName'],
                                                  Icons.person_outline,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: spacing),

                                          Wrap(
                                            spacing: spacing,
                                            runSpacing: spacing,
                                            children: [
                                              SizedBox(
                                                width:
                                                    (screenWidth < 700)
                                                        ? double.infinity
                                                        : (screenWidth / 2) -
                                                            (spacing * 4),
                                                child: _buildInfoCard(
                                                  'المستخدم المبلغ عنه',
                                                  report['userName'],
                                                  Icons.person,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    (screenWidth < 700)
                                                        ? double.infinity
                                                        : (screenWidth / 2) -
                                                            (spacing * 4),
                                                child: _buildInfoCard(
                                                  'الغرفة المبلغ عنها',
                                                  report['roomName'],
                                                  Icons.meeting_room,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: spacing),

                                          SizedBox(
                                            width: double.infinity,
                                            child: _buildInfoCard(
                                              'الملف الشخصي المبلغ عنه',
                                              report['profileName'],
                                              Icons.account_circle,
                                            ),
                                          ),

                                          SizedBox(height: spacing),

                                          Wrap(
                                            spacing: spacing,
                                            runSpacing: spacing,
                                            children: [
                                              SizedBox(
                                                width:
                                                    (screenWidth < 700)
                                                        ? double.infinity
                                                        : (screenWidth / 2) -
                                                            (spacing * 4),
                                                child: _buildInfoCard(
                                                  'التاريخ والوقت',
                                                  report['dateTime'],
                                                  Icons.access_time,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    (screenWidth < 700)
                                                        ? double.infinity
                                                        : (screenWidth / 2) -
                                                            (spacing * 4),
                                                child: _buildInfoCard(
                                                  'الحالة',
                                                  report['status'] == 'Pending'
                                                      ? 'قيد الانتظار'
                                                      : report['status'] ==
                                                          'Under Review'
                                                      ? 'قيد المراجعة'
                                                      : report['status'] ==
                                                          'Resolved'
                                                      ? 'تم الحل'
                                                      : 'مرفوض',
                                                  Icons.info_outline,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: spacing * 1.25),

                                          Text(
                                            'سبب الإبلاغ',
                                            style: TextStyle(
                                              color:
                                                  widget
                                                      .currentTheme['textPrimary'],
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color:
                                                  widget.currentTheme['cardBg'],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: getStatusColor(
                                                  report['status'],
                                                ).withOpacity(0.3),
                                              ),
                                            ),
                                            child: Text(
                                              report['reason'],
                                              style: TextStyle(
                                                color:
                                                    widget
                                                        .currentTheme['textPrimary'],
                                                fontSize: 14,
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
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statsCard(
    BuildContext context,
    IconData icon,
    Color iconColor,
    String value,
    String label,
    double cardPadding,
    double iconSize,
    double fontSizeLarge,
    double fontSizeSmall,
  ) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(cardPadding),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: iconSize),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSizeLarge,
              fontWeight: FontWeight.bold,
              color: widget.currentTheme['textPrimary'],
            ),
          ),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSizeSmall,
              color: widget.currentTheme['textSecondary'],
            ),
          ),
        ],
      ),
    );
  }
}
