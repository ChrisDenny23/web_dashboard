// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, empty_catches

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web_dashboard/pages/emojiselection.dart';
import 'package:web_dashboard/pages/analytics_dashboard.dart';
import 'package:web_dashboard/pages/support_page.dart';
import 'pages/admin_dashboard_page.dart';
import 'pages/public_message_page.dart';
import 'pages/terms_page.dart';
import 'pages/chat_rooms_page.dart';
import 'pages/name_design_page.dart';
import 'pages/files_page.dart';
import 'pages/banned_page.dart';
import 'pages/logs_page.dart';
import 'widgets/enhanced_sidebar.dart';

// Firebase configuration options
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'your-api-key-here',
    authDomain: 'your-project.firebaseapp.com',
    projectId: 'your-project-id',
    storageBucket: 'your-project.appspot.com',
    messagingSenderId: '123456789',
    appId: 'your-app-id',
    measurementId: 'G-XXXXXXXXXX', // Optional for Analytics
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      const Text(
                        'Error initializing Firebase',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const AdminLayout();
          }

          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Initializing Firebase...'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  _AdminLayoutState createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  String selectedMenu = 'dashboard'; // menu key
  bool isDarkMode = false;

  // Theme colors
  Map<String, dynamic> get currentTheme => isDarkMode ? darkTheme : lightTheme;

  final Map<String, dynamic> lightTheme = {
    'background': [
      const Color(0xFF0F172A),
      const Color(0xFF1E293B),
      const Color(0xFF334155),
    ],
    'sidebarBg': Colors.white,
    'mainBg': Colors.white,
    'headerBg': const Color(0xFFF8FAFC),
    'cardBg': Colors.white,
    'textPrimary': const Color(0xFF1E293B),
    'textSecondary': const Color(0xFF64748B),
    'textMuted': const Color(0xFF94A3B8),
    'border': const Color(0xFFE2E8F0),
    'shadow': Colors.black.withOpacity(0.05),
    'accent': const Color(0xFF3B82F6),
    'accentDark': const Color(0xFF1E40AF),
  };

  final Map<String, dynamic> darkTheme = {
    'background': [
      const Color(0xFF0F0F23),
      const Color(0xFF1A1A2E),
      const Color(0xFF16213E),
    ],
    'sidebarBg': const Color(0xFF1E1E2E),
    'mainBg': const Color(0xFF1A1A2E),
    'headerBg': const Color(0xFF16213E),
    'cardBg': const Color(0xFF252545),
    'textPrimary': const Color(0xFFE2E8F0),
    'textSecondary': const Color(0xFFCBD5E1),
    'textMuted': const Color(0xFF94A3B8),
    'border': const Color(0xFF374151),
    'shadow': Colors.black.withOpacity(0.25),
    'accent': const Color(0xFF60A5FA),
    'accentDark': const Color(0xFF3B82F6),
  };

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

  Widget _getCurrentPage() {
    switch (selectedMenu) {
      case 'dashboard':
        return AdminDashboardPage(currentTheme: currentTheme);
      case 'analytics':
        return AnalyticsDashboardPage(currentTheme: currentTheme);
      case 'public_message':
        return PublicMessagePage(currentTheme: currentTheme);
      case 'users':
        return AppTermsPage(currentTheme: currentTheme);
      case 'rooms':
        return ChatroomPage(currentTheme: currentTheme);
      case 'countries':
        return NamesDesignPage(currentTheme: currentTheme);
      case 'emojis':
        return EmojiSelectionPage(currentTheme: currentTheme);
      case 'files':
        return VIPPage(currentTheme: currentTheme);
      case 'security':
        return BannedSuspendedUsersPage(currentTheme: currentTheme);
      case 'settings':
        return LogsPage(currentTheme: currentTheme);
      case 'support':
        return ServerSupportPage(currentTheme: currentTheme);
      default:
        return AdminDashboardPage(currentTheme: currentTheme);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      // Create sidebar once outside the drawer
      final sidebar = EnhancedSidebar(
        currentTheme: currentTheme,
        selectedMenu: selectedMenu,
        isDarkMode: isDarkMode,
        onMenuChanged: (menu) {
          setState(() => selectedMenu = menu);
          Navigator.of(context).pop(); // Close drawer on menu selection
        },
        onThemeChanged: (isDark) => setState(() => isDarkMode = isDark),
      );

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: currentTheme['background'],
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: currentTheme['mainBg'],
            elevation: 0,
            iconTheme: IconThemeData(color: currentTheme['accent']),
            title: Text(
              'لوحة تحكم المديرين',
              style: TextStyle(color: currentTheme['textPrimary']),
            ),
          ),
          drawer: Drawer(child: sidebar),
          body: _getCurrentPage(),
        ),
      );
    }

    // Tablet/Desktop layout with fixed sidebar
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: currentTheme['background'],
        ),
      ),
      child: Scaffold(
        backgroundColor: currentTheme['mainBg'],
        body: Row(
          children: [
            SizedBox(
              width: screenWidth < 1024 ? 280 : 320,
              child: EnhancedSidebar(
                currentTheme: currentTheme,
                selectedMenu: selectedMenu,
                isDarkMode: isDarkMode,
                onMenuChanged: (menu) => setState(() => selectedMenu = menu),
                onThemeChanged: (isDark) => setState(() => isDarkMode = isDark),
              ),
            ),
            Expanded(child: _getCurrentPage()),
          ],
        ),
      ),
    );
  }
}
