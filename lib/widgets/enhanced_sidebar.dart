// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class EnhancedSidebar extends StatelessWidget {
  final Map<String, dynamic> currentTheme;
  final String selectedMenu;
  final bool isDarkMode;
  final Function(String) onMenuChanged;
  final Function(bool) onThemeChanged;

  const EnhancedSidebar({
    super.key,
    required this.currentTheme,
    required this.selectedMenu,
    required this.isDarkMode,
    required this.onMenuChanged,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Sidebar padding and sizes for different layouts can be fixed here or passed down
    // This sidebar does not handle mobile drawer animation itself (done externally)

    final double padding = 20.0;
    final double titleSize = 17.0;
    final double menuSize = 14.0;
    final double iconSize = 20.0;
    final double avatarRadius = 18.0;

    return Container(
      decoration: BoxDecoration(
        color: currentTheme['sidebarBg'],
        boxShadow: [
          BoxShadow(
            color: currentTheme['shadow'],
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Header with Profile
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [currentTheme['accentDark'], currentTheme['accent']],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(padding * 0.5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.admin_panel_settings,
                        color: Colors.white,
                        size: iconSize + 4,
                      ),
                    ),
                    SizedBox(width: padding * 0.5),
                    Expanded(
                      child: Text(
                        'بوابة المسؤول',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: padding * 0.67),
                // Profile Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: avatarRadius,
                      ),
                    ),
                    SizedBox(width: padding * 0.5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'المسؤول',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: menuSize + 1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'مدير النظام',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: menuSize - 1,
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

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(padding * 0.67),
              children: [
                _buildMenuSection('الرئيسية', [
                  _buildMenuItem(
                    icon: Icons.dashboard,
                    title: 'لوحة تحكم المسؤول',
                    keyVal: 'dashboard',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                  _buildMenuItem(
                    icon: Icons.analytics,
                    title: 'لوحة التحكم',
                    keyVal: 'analytics',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                  _buildMenuItem(
                    icon: Icons.message_rounded,
                    title: 'الرسائل العامة',
                    keyVal: 'public_message',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                ]),
                SizedBox(height: padding * 0.83),
                _buildMenuSection('الإدارة', [
                  _buildMenuItem(
                    icon: Icons.chat,
                    title: 'غرف الدردشة',
                    keyVal: 'rooms',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                  _buildMenuItem(
                    icon: Icons.flag,
                    title: 'الأسماء والتصاميم',
                    keyVal: 'countries',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                  _buildMenuItem(
                    icon: Icons.emoji_emotions,
                    title: 'اختيار الرموز التعبيرية',
                    keyVal: 'emojis',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    title: 'الملفات',
                    keyVal: 'files',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                  _buildMenuItem(
                    icon: Icons.support,
                    title: 'الخادم والدعم',
                    keyVal: 'support',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                  _buildMenuItem(
                    icon: Icons.security,
                    title: 'المستخدمون المحظورون',
                    keyVal: 'security',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                ]),
                SizedBox(height: padding * 0.83),
                _buildMenuSection('النظام', [
                  _buildMenuItem(
                    icon: Icons.settings,
                    title: 'السجلات',
                    keyVal: 'settings',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                  _buildMenuItem(
                    icon: Icons.people,
                    title: 'شروط التطبيق',
                    keyVal: 'users',
                    iconSize: iconSize,
                    fontSize: menuSize,
                    padding: padding * 0.67,
                  ),
                ]),
              ],
            ),
          ),

          // Theme Toggle
          Padding(
            padding: EdgeInsets.all(padding * 0.67),
            child: Row(
              children: [
                Icon(
                  Icons.light_mode,
                  color:
                      isDarkMode
                          ? currentTheme['textMuted']
                          : currentTheme['accent'],
                  size: iconSize,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Switch(
                    value: isDarkMode,
                    onChanged: onThemeChanged,
                    activeColor: currentTheme['accent'],
                    activeTrackColor: currentTheme['accent'].withOpacity(0.3),
                    inactiveThumbColor: currentTheme['textMuted'],
                    inactiveTrackColor: currentTheme['border'],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.dark_mode,
                  color:
                      isDarkMode
                          ? currentTheme['accent']
                          : currentTheme['textMuted'],
                  size: iconSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: currentTheme['textMuted'],
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String keyVal,
    required double iconSize,
    required double fontSize,
    required double padding,
  }) {
    final bool isActive = selectedMenu == keyVal;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => onMenuChanged(keyVal),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: padding * 0.75,
            ),
            decoration: BoxDecoration(
              color:
                  isActive
                      ? currentTheme['accent'].withOpacity(0.1)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border:
                  isActive
                      ? Border.all(
                        color: currentTheme['accent'].withOpacity(0.3),
                      )
                      : null,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color:
                      isActive
                          ? currentTheme['accent']
                          : currentTheme['textSecondary'],
                  size: iconSize,
                ),
                SizedBox(width: padding * 0.75),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color:
                          isActive
                              ? currentTheme['accent']
                              : currentTheme['textSecondary'],
                      fontSize: fontSize,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
