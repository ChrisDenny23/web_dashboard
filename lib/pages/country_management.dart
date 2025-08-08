import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// Replace this theme map with your specific colors or adjust as needed.
final Map<String, dynamic> defaultTheme = {
  'mainBg': Colors.white,
  'cardBg': Colors.grey[100],
  'accent': Colors.deepOrange,
  'textPrimary': Colors.black,
  'textSecondary': Colors.grey,
  'shadow': Colors.black12,
};

class CountriesManagementPage extends StatefulWidget {
  final Map<String, dynamic> currentTheme;

  const CountriesManagementPage({super.key, this.currentTheme = const {}});

  @override
  State<CountriesManagementPage> createState() =>
      _CountriesManagementPageState();
}

class _CountriesManagementPageState extends State<CountriesManagementPage>
    with TickerProviderStateMixin {
  late final Map<String, dynamic> theme;

  late AnimationController _animationController;

  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _numberOfUsersController =
      TextEditingController();
  final TextEditingController _numberOfRoomsController =
      TextEditingController();
  final TextEditingController _countryNameController = TextEditingController();

  String _searchQuery = '';
  final String _selectedFilter = 'All'; // If needed for filtering
  final Set<String> _expandedItems = {};

  File? _flagImageFile; // For Add Dialog image
  File? _editFlagImageFile; // For Edit Dialog image

  final Map<String, String> _countryFlags = {
    'india': '🇮🇳',
    'usa': '🇺🇸',
    'egypt': '🇪🇬',
    'united states': '🇺🇸',
    // add more as needed
  };

  final List<Map<String, dynamic>> _countries = [
    {
      'id': '1',
      'roomName': 'General India',
      'numberOfUsers': 400,
      'numberOfRooms': 5,
      'countryName': 'India',
      'flag': '🇮🇳',
      'flagImagePath': null,
      'status': 'Active',
      'addedDate': '2024-01-01',
      'useDemoAsset': true,
    },
    {
      'id': '2',
      'roomName': 'General USA',
      'numberOfUsers': 200,
      'numberOfRooms': 3,
      'countryName': 'USA',
      'flag': '🇺🇸',
      'flagImagePath': null,
      'status': 'Inactive',
      'addedDate': '2024-02-01',
      'useDemoAsset': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    theme = widget.currentTheme.isNotEmpty ? widget.currentTheme : defaultTheme;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _roomNameController.dispose();
    _numberOfUsersController.dispose();
    _numberOfRoomsController.dispose();
    _countryNameController.dispose();
    super.dispose();
  }

  String _getFlagForCountry(String countryName) {
    String key = countryName.toLowerCase().trim();
    return _countryFlags[key] ?? '🏳️';
  }

  List<Map<String, dynamic>> get _filteredCountries {
    return _countries.where((country) {
      final searchLower = _searchQuery.toLowerCase();
      final matchesSearch =
          country['roomName'].toLowerCase().contains(searchLower) ||
          country['countryName'].toLowerCase().contains(searchLower);
      final matchesFilter =
          _selectedFilter == 'All' ||
          (_selectedFilter == 'Active' && country['status'] == 'Active') ||
          (_selectedFilter == 'Inactive' && country['status'] == 'Inactive');
      return matchesSearch && matchesFilter;
    }).toList();
  }

  Widget buildFlagAvatar(Map<String, dynamic> country, bool isMobile) {
    if (country['useDemoAsset'] == true) {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
          image: const DecorationImage(
            image: AssetImage('assets/images/india_flag.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (country['flagImagePath'] != null) {
      final file = File(country['flagImagePath']);
      if (file.existsSync()) {
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
            image: DecorationImage(image: FileImage(file), fit: BoxFit.cover),
          ),
        );
      }
    }

    // Fallback emoji flag
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: Center(
        child: Text(
          country['flag'] ?? '🏳️',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  Widget _buildFormField(
    String label,
    TextEditingController controller,
    String hint,
    IconData icon, {
    TextInputType? keyboardType,
    bool isMobile = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // translated below
          style: TextStyle(
            color: theme['textPrimary'],
            fontSize: isMobile ? 12 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: theme['mainBg'],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme['textSecondary'].withOpacity(0.3)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              color: theme['textPrimary'],
              fontSize: isMobile ? 14 : 16,
            ),
            decoration: InputDecoration(
              hintText: hint, // translated below
              hintStyle: TextStyle(color: theme['textSecondary']),
              prefixIcon: Icon(icon, color: theme['textSecondary']),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isMobile ? 12 : 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddCountryDialog() {
    _roomNameController.clear();
    _numberOfUsersController.clear();
    _numberOfRoomsController.clear();
    _countryNameController.clear();
    _flagImageFile = null;
    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('إضافة دولة'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildFormField(
                          'اسم الغرفة',
                          _roomNameController,
                          'أدخل اسم الغرفة',
                          Icons.meeting_room,
                        ),
                        const SizedBox(height: 12),
                        _buildFormField(
                          'عدد المستخدمين',
                          _numberOfUsersController,
                          '0',
                          Icons.people,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 12),
                        _buildFormField(
                          'عدد الغرف',
                          _numberOfRoomsController,
                          '0',
                          Icons.room,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                'اسم الدولة',
                                _countryNameController,
                                'أدخل اسم الدولة',
                                Icons.public,
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (pickedFile != null) {
                                  setDialogState(() {
                                    _flagImageFile = File(pickedFile.path);
                                  });
                                }
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                  image:
                                      _flagImageFile != null
                                          ? DecorationImage(
                                            image: FileImage(_flagImageFile!),
                                            fit: BoxFit.cover,
                                          )
                                          : null,
                                ),
                                child:
                                    _flagImageFile == null
                                        ? const Icon(
                                          Icons.add_a_photo,
                                          color: Colors.blueGrey,
                                        )
                                        : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_roomNameController.text.isNotEmpty &&
                            _countryNameController.text.isNotEmpty) {
                          setState(() {
                            _countries.add({
                              'id':
                                  DateTime.now().millisecondsSinceEpoch
                                      .toString(),
                              'roomName': _roomNameController.text,
                              'numberOfUsers':
                                  int.tryParse(_numberOfUsersController.text) ??
                                  0,
                              'numberOfRooms':
                                  int.tryParse(_numberOfRoomsController.text) ??
                                  0,
                              'countryName': _countryNameController.text,
                              'flag': _getFlagForCountry(
                                _countryNameController.text,
                              ),
                              'flagImagePath': _flagImageFile?.path,
                              'status': 'Active',
                              'addedDate':
                                  DateTime.now().toString().split(' ').first,
                              'useDemoAsset': false,
                            });
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تمت إضافة الدولة بنجاح!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: const Text('إضافة'),
                    ),
                  ],
                ),
          ),
    );
  }

  void _showEditDialog(Map<String, dynamic> country) {
    _roomNameController.text = country['roomName'];
    _numberOfUsersController.text = country['numberOfUsers'].toString();
    _numberOfRoomsController.text = country['numberOfRooms'].toString();
    _countryNameController.text = country['countryName'];
    _editFlagImageFile =
        country['flagImagePath'] != null
            ? File(country['flagImagePath'])
            : null;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('تعديل الدولة'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildFormField(
                          'اسم الغرفة',
                          _roomNameController,
                          'أدخل اسم الغرفة',
                          Icons.meeting_room,
                        ),
                        const SizedBox(height: 12),
                        _buildFormField(
                          'عدد المستخدمين',
                          _numberOfUsersController,
                          '0',
                          Icons.people,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 12),
                        _buildFormField(
                          'عدد الغرف',
                          _numberOfRoomsController,
                          '0',
                          Icons.room,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                'اسم الدولة',
                                _countryNameController,
                                'أدخل اسم الدولة',
                                Icons.public,
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (pickedFile != null) {
                                  setDialogState(() {
                                    _editFlagImageFile = File(pickedFile.path);
                                  });
                                }
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                  image:
                                      _editFlagImageFile != null
                                          ? DecorationImage(
                                            image: FileImage(
                                              _editFlagImageFile!,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                          : null,
                                ),
                                child:
                                    _editFlagImageFile == null
                                        ? const Icon(
                                          Icons.add_a_photo,
                                          color: Colors.blueGrey,
                                        )
                                        : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_roomNameController.text.isNotEmpty &&
                            _countryNameController.text.isNotEmpty) {
                          setState(() {
                            final index = _countries.indexWhere(
                              (c) => c['id'] == country['id'],
                            );
                            if (index != -1) {
                              _countries[index] = {
                                ..._countries[index],
                                'roomName': _roomNameController.text,
                                'numberOfUsers':
                                    int.tryParse(
                                      _numberOfUsersController.text,
                                    ) ??
                                    0,
                                'numberOfRooms':
                                    int.tryParse(
                                      _numberOfRoomsController.text,
                                    ) ??
                                    0,
                                'countryName': _countryNameController.text,
                                'flag': _getFlagForCountry(
                                  _countryNameController.text,
                                ),
                                'flagImagePath': _editFlagImageFile?.path,
                                'useDemoAsset': false,
                              };
                            }
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم تحديث الدولة!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: const Text('تحديث'),
                    ),
                  ],
                ),
          ),
    );
  }

  Widget _buildDetailItem(
    String label,
    String value,
    IconData icon, {
    bool isMobile = false,
  }) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 8 : 12),
      decoration: BoxDecoration(
        color: theme['cardBg'],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme['textSecondary'].withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme['accent'], size: isMobile ? 16 : 20),
          SizedBox(width: isMobile ? 6 : 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label, // translated below
                  style: TextStyle(
                    color: theme['textSecondary'],
                    fontSize: isMobile ? 10 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: theme['textPrimary'],
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCell(String label, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme['accent'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label, // translated below
        style: TextStyle(
          color: theme['textPrimary'],
          fontWeight: FontWeight.w600,
          fontSize: isMobile ? 12 : 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isDesktop = width >= 1024;

    final horizontalMargin =
        isDesktop
            ? 32.0
            : isTablet
            ? 24.0
            : 12.0;
    final verticalMargin =
        isDesktop
            ? 24.0
            : isTablet
            ? 20.0
            : 12.0;
    final cardRadius = 20.0;

    return Scaffold(
      backgroundColor: theme['mainBg'],
      appBar: AppBar(
        title: const Text('إدارة الدول'),
        backgroundColor: theme['accent'],
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddCountryDialog,
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: verticalMargin,
          ),
          decoration: BoxDecoration(
            color: theme['mainBg'],
            borderRadius: BorderRadius.circular(cardRadius),
            boxShadow: [
              BoxShadow(
                color: theme['shadow'],
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalMargin,
                  vertical: verticalMargin,
                ),
                child:
                    isMobile
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'ابحث عن دولة أو غرفة...',
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: theme['textSecondary'],
                                ),
                                filled: true,
                                fillColor: theme['cardBg'],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                hintStyle: TextStyle(
                                  color: theme['textSecondary'],
                                ),
                              ),
                              style: TextStyle(color: theme['textPrimary']),
                              onChanged:
                                  (value) =>
                                      setState(() => _searchQuery = value),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme['accent'],
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _showAddCountryDialog,
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: const Text(
                                'إضافة دولة',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                        : Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'ابحث عن دولة أو غرفة...',
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: theme['textSecondary'],
                                  ),
                                  filled: true,
                                  fillColor: theme['cardBg'],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintStyle: TextStyle(
                                    color: theme['textSecondary'],
                                  ),
                                ),
                                style: TextStyle(color: theme['textPrimary']),
                                onChanged:
                                    (value) =>
                                        setState(() => _searchQuery = value),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme['accent'],
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _showAddCountryDialog,
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: const Text(
                                'إضافة دولة',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme['cardBg'],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: isMobile ? 40 : 50,
                      ), // For edit/actions buttons
                      Expanded(
                        flex: 2,
                        child: _headerCell('المستخدمون', isMobile),
                      ),
                      SizedBox(width: isMobile ? 12 : 16),
                      Expanded(flex: 2, child: _headerCell('الغرف', isMobile)),
                      SizedBox(width: isMobile ? 12 : 16),
                      Expanded(flex: 3, child: _headerCell('الدولة', isMobile)),
                      SizedBox(width: isMobile ? 40 : 50), // For flag and menu
                    ],
                  ),
                ),
              ),
              Expanded(
                child:
                    _filteredCountries.isEmpty
                        ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 12 : 24,
                            ),
                            child: Text(
                              'لم يتم العثور على دول. حاول تعديل البحث أو إضافة دولة جديدة.',
                              style: TextStyle(
                                color: theme['textSecondary'],
                                fontSize: isMobile ? 14 : 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                        : Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: horizontalMargin,
                          ),
                          decoration: BoxDecoration(
                            color: theme['cardBg'],
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: ListView.builder(
                              itemCount: _filteredCountries.length,
                              itemBuilder: (context, index) {
                                final country = _filteredCountries[index];
                                final bool isExpanded = _expandedItems.contains(
                                  country['id'],
                                );
                                return Column(
                                  children: [
                                    if (index > 0)
                                      Divider(
                                        height: 1,
                                        color: theme['textSecondary']
                                            .withOpacity(0.1),
                                      ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isExpanded
                                              ? _expandedItems.remove(
                                                country['id'],
                                              )
                                              : _expandedItems.add(
                                                country['id'],
                                              );
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 35,
                                                  height: 25,
                                                  child: ElevatedButton(
                                                    onPressed:
                                                        () => _showEditDialog(
                                                          country,
                                                        ),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
                                                      padding: EdgeInsets.zero,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    child: const Text(
                                                      'تعديل',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                SizedBox(
                                                  width: 35,
                                                  height: 25,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isExpanded
                                                            ? _expandedItems
                                                                .remove(
                                                                  country['id'],
                                                                )
                                                            : _expandedItems
                                                                .add(
                                                                  country['id'],
                                                                );
                                                      });
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          theme['accent'],
                                                      padding: EdgeInsets.zero,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    child: Text(
                                                      isExpanded
                                                          ? 'إخفاء'
                                                          : 'إظهار',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                country['numberOfUsers']
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: theme['textPrimary'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: isMobile ? 14 : 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: isMobile ? 12 : 16),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                country['numberOfRooms']
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: theme['textPrimary'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: isMobile ? 14 : 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: isMobile ? 12 : 16),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                country['countryName'] ?? '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: theme['textPrimary'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: isMobile ? 14 : 16,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: isMobile ? 12 : 16),
                                            Row(
                                              children: [
                                                buildFlagAvatar(
                                                  country,
                                                  isMobile,
                                                ),
                                                const SizedBox(width: 8),
                                                PopupMenuButton<String>(
                                                  color: theme['cardBg'],
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color:
                                                        theme['textSecondary'],
                                                  ),
                                                  onSelected: (value) {
                                                    switch (value) {
                                                      case 'edit':
                                                        _showEditDialog(
                                                          country,
                                                        );
                                                        break;
                                                      case 'delete':
                                                        setState(() {
                                                          _countries.remove(
                                                            country,
                                                          );
                                                          _expandedItems.remove(
                                                            country['id'],
                                                          );
                                                        });
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                              'تم حذف الدولة!',
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                        );
                                                        break;
                                                      case 'details':
                                                        setState(() {
                                                          isExpanded
                                                              ? _expandedItems
                                                                  .remove(
                                                                    country['id'],
                                                                  )
                                                              : _expandedItems
                                                                  .add(
                                                                    country['id'],
                                                                  );
                                                        });
                                                        break;
                                                    }
                                                  },
                                                  itemBuilder:
                                                      (context) => [
                                                        PopupMenuItem(
                                                          value: 'edit',
                                                          child: Text(
                                                            'تعديل',
                                                            style: TextStyle(
                                                              color:
                                                                  theme['textPrimary'],
                                                            ),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          value: 'details',
                                                          child: Text(
                                                            isExpanded
                                                                ? 'إخفاء التفاصيل'
                                                                : 'إظهار التفاصيل',
                                                            style: TextStyle(
                                                              color:
                                                                  theme['textPrimary'],
                                                            ),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          value: 'delete',
                                                          child: const Text(
                                                            'حذف',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      height: isExpanded ? null : 0,
                                      child:
                                          isExpanded
                                              ? Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                padding: const EdgeInsets.all(
                                                  16,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: theme['mainBg'],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color:
                                                        theme['textSecondary']
                                                            .withOpacity(0.1),
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'التفاصيل',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            isMobile ? 14 : 16,
                                                        color:
                                                            theme['textPrimary'],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: _buildDetailItem(
                                                            'اسم الغرفة',
                                                            country['roomName'],
                                                            Icons.meeting_room,
                                                            isMobile: isMobile,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              isMobile ? 8 : 16,
                                                        ),
                                                        Expanded(
                                                          child: _buildDetailItem(
                                                            'الدولة',
                                                            country['countryName'],
                                                            Icons.public,
                                                            isMobile: isMobile,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: _buildDetailItem(
                                                            'المستخدمون',
                                                            country['numberOfUsers']
                                                                .toString(),
                                                            Icons.people,
                                                            isMobile: isMobile,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              isMobile ? 8 : 16,
                                                        ),
                                                        Expanded(
                                                          child: _buildDetailItem(
                                                            'الغرف',
                                                            country['numberOfRooms']
                                                                .toString(),
                                                            Icons.room,
                                                            isMobile: isMobile,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: _buildDetailItem(
                                                            'الحالة',
                                                            country['status'] ==
                                                                    'Active'
                                                                ? 'نشط'
                                                                : 'غير نشط',
                                                            Icons.info,
                                                            isMobile: isMobile,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              isMobile ? 8 : 16,
                                                        ),
                                                        Expanded(
                                                          child: _buildDetailItem(
                                                            'تاريخ الإضافة',
                                                            country['addedDate'],
                                                            Icons
                                                                .calendar_today,
                                                            isMobile: isMobile,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                              : Container(),
                                    ),
                                    if (isExpanded)
                                      SizedBox(height: isMobile ? 12 : 16),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
