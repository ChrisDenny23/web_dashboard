import 'package:flutter/material.dart';

class EnhancedHeader extends StatelessWidget {
  final Map<String, dynamic> currentTheme;
  final String title;
  final String subtitle;
  final String description;
  final double? titleFontSize;
  final double? subtitleFontSize;

  const EnhancedHeader({
    super.key,
    required this.currentTheme,
    required this.title,
    required this.subtitle,
    required this.description,
    this.titleFontSize,
    this.subtitleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive breakpoints
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1200;

    // Responsive sizing
    double responsivePadding =
        isMobile
            ? 16
            : isTablet
            ? 24
            : 32;
    double responsiveTitleFontSize =
        titleFontSize ??
        (isMobile
            ? 12
            : isTablet
            ? 14
            : 16);
    double responsiveSubtitleFontSize =
        subtitleFontSize ??
        (isMobile
            ? 20
            : isTablet
            ? 24
            : 28);
    double responsiveDescriptionFontSize =
        isMobile
            ? 12
            : isTablet
            ? 14
            : 16;
    double responsiveIconSize = isMobile ? 14 : 16;
    double responsiveSpacing = isMobile ? 4 : 8;
    double responsiveButtonPadding =
        isMobile
            ? 8
            : isTablet
            ? 10
            : 12;
    double responsiveButtonHorizontalPadding =
        isMobile
            ? 12
            : isTablet
            ? 16
            : 20;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(responsivePadding),
        decoration: BoxDecoration(
          color: currentTheme['headerBg'],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isMobile ? 12 : 20),
            topRight: Radius.circular(isMobile ? 12 : 20),
          ),
        ),
        child: Column(
          children: [
            // Mobile layout - stack vertically
            if (isMobile) ...[
              _buildMobileHeader(
                responsiveTitleFontSize,
                responsiveSubtitleFontSize,
                responsiveDescriptionFontSize,
                responsiveIconSize,
                responsiveSpacing,
                responsiveButtonPadding,
                responsiveButtonHorizontalPadding,
              ),
            ]
            // Tablet and Desktop layout - side by side
            else ...[
              _buildDesktopTabletHeader(
                responsiveTitleFontSize,
                responsiveSubtitleFontSize,
                responsiveDescriptionFontSize,
                responsiveIconSize,
                responsiveSpacing,
                responsiveButtonPadding,
                responsiveButtonHorizontalPadding,
                isTablet,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMobileHeader(
    double titleFontSize,
    double subtitleFontSize,
    double descriptionFontSize,
    double iconSize,
    double spacing,
    double buttonPadding,
    double buttonHorizontalPadding,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top row with notifications and logout button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Breadcrumb navigation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: currentTheme['textSecondary'],
                            fontSize: titleFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.chevron_left,
                        color: currentTheme['textMuted'],
                        size: iconSize,
                      ),
                      Text(
                        'نظرة عامة',
                        style: TextStyle(
                          color: currentTheme['accent'],
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Actions row
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNotificationIcon(iconSize + 4),
                SizedBox(width: 4),
                _buildLogoutButton(
                  buttonPadding,
                  buttonHorizontalPadding,
                  titleFontSize - 2,
                  iconSize - 2,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: spacing * 2),
        // Title and description
        Text(
          subtitle,
          style: TextStyle(
            fontSize: subtitleFontSize,
            fontWeight: FontWeight.w800,
            color: currentTheme['textPrimary'],
          ),
        ),
        SizedBox(height: spacing),
        Text(
          description,
          style: TextStyle(
            fontSize: descriptionFontSize,
            color: currentTheme['textSecondary'],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopTabletHeader(
    double titleFontSize,
    double subtitleFontSize,
    double descriptionFontSize,
    double iconSize,
    double spacing,
    double buttonPadding,
    double buttonHorizontalPadding,
    bool isTablet,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Title and navigation
        Expanded(
          flex: isTablet ? 2 : 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb navigation
              Row(
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: currentTheme['textSecondary'],
                        fontSize: titleFontSize,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.chevron_left,
                    color: currentTheme['textMuted'],
                    size: iconSize,
                  ),
                  Text(
                    'نظرة عامة',
                    style: TextStyle(
                      color: currentTheme['accent'],
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.w800,
                  color: currentTheme['textPrimary'],
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: descriptionFontSize,
                  color: currentTheme['textSecondary'],
                ),
              ),
            ],
          ),
        ),
        // Right side - Actions
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNotificationIcon(iconSize + 8),
            SizedBox(width: spacing),
            _buildLogoutButton(
              buttonPadding,
              buttonHorizontalPadding,
              titleFontSize,
              iconSize,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationIcon(double iconSize) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_outlined,
            color: currentTheme['textSecondary'],
          ),
          iconSize: iconSize,
          constraints: BoxConstraints(
            minWidth: iconSize + 16,
            minHeight: iconSize + 16,
          ),
          padding: EdgeInsets.all(8),
        ),
        Positioned(
          left: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(minWidth: 12, minHeight: 12),
            child: Text(
              '3',
              style: TextStyle(color: Colors.white, fontSize: 8),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(
    double verticalPadding,
    double horizontalPadding,
    double fontSize,
    double iconSize,
  ) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.logout, size: iconSize),
      label: Text('تسجيل خروج', style: TextStyle(fontSize: fontSize)),
      style: ElevatedButton.styleFrom(
        backgroundColor: currentTheme['accent'],
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: Size(0, 32), // Minimum height for touch targets
      ),
    );
  }
}
