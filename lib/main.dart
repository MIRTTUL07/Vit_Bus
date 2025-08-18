import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/track_bus_page.dart';
import 'pages/fee_receipt_page.dart';
import 'pages/transport_office_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'widgets/notification_bottomsheet.dart';

void main() {
  runApp(BusTrackingApp());
}

class BusTrackingApp extends StatefulWidget {
  @override
  _BusTrackingAppState createState() => _BusTrackingAppState();
}

class _BusTrackingAppState extends State<BusTrackingApp> {
  bool isDarkMode = false;

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Bus Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo[700],
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          foregroundColor: Colors.white,
        ),
        cardColor: Colors.grey[800],
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey[850]),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: BusTrackingDashboard(
        onDarkModeChanged: toggleDarkMode,
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class BusTrackingDashboard extends StatefulWidget {
  final Function(bool) onDarkModeChanged;
  final bool isDarkMode;

  BusTrackingDashboard({
    required this.onDarkModeChanged,
    required this.isDarkMode,
  });

  @override
  _BusTrackingDashboardState createState() => _BusTrackingDashboardState();
}

class _BusTrackingDashboardState extends State<BusTrackingDashboard> {
  String studentName = "MIR";
  String studentId = "24BLC1270";
  String busNumber = "7A";
  String busStatus = "Reached";
  String busLocation = "Arumbakkam";
  String timeAgo = "1m ago";
  int _selectedIndex = 0;
  int notificationCount = 3;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(
        studentName: studentName,
        busNumber: busNumber,
        busStatus: busStatus,
        busLocation: busLocation,
        timeAgo: timeAgo,
      ),
      TrackBusPage(),
      FeeReceiptPage(),
      TransportOfficePage(),
      ProfilePage(),
      SettingsPage(
        isDarkMode: widget.isDarkMode,
        onDarkModeChanged: widget.onDarkModeChanged,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white, size: 28),
                onPressed: () {
                  _showNotificationsBottomSheet(context);
                },
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                    child: Text(
                      notificationCount > 99 ? '99+' : '$notificationCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[50],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(color: Colors.indigo[700]),
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Text(
                          studentName.substring(0, 1),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[700],
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              studentName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              studentId,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildDrawerItem(Icons.home, 'Home', 0),
              _buildDrawerItem(Icons.directions_bus, 'Track Bus', 1),
              _buildDrawerItem(Icons.receipt_long, 'Fee Receipt', 2),
              _buildDrawerItem(Icons.local_shipping, 'Transport Office', 3),
              _buildDrawerItem(Icons.account_circle, 'Profile', 4),
              _buildDrawerItem(Icons.settings, 'Settings', 5),
              Divider(color: Colors.grey[300]),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 2,
                ),
                leading: Icon(Icons.logout, color: Colors.red[600], size: 22),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.red[600], fontSize: 14),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Handle logout
                },
              ),
            ],
          ),
        ),
      ),
      body: _selectedIndex < _pages.length ? _pages[_selectedIndex] : _pages[0],
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    bool isSelected = _selectedIndex == index;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.indigo[50] : Colors.transparent,
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Icon(
          icon,
          color: isSelected ? Colors.indigo[700] : Colors.grey[600],
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.indigo[700] : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        selected: isSelected,
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showNotificationsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      notificationCount = 0;
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Mark all read',
                    style: TextStyle(
                      color: Colors.indigo[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Notifications List
            Expanded(
              child: ListView(
                children: [
                  _buildNotificationItem(
                    'Bus 7A Update',
                    'Your bus is approaching Nerkundram stop',
                    '2 min ago',
                    Icons.directions_bus,
                    Colors.blue,
                    true,
                  ),
                  _buildNotificationItem(
                    'Route Change',
                    'Bus 7A route has been modified due to traffic',
                    '15 min ago',
                    Icons.warning,
                    Colors.orange,
                    true,
                  ),
                  _buildNotificationItem(
                    'Arrival Alert',
                    'Bus 7A will arrive in 5 minutes',
                    '1 hour ago',
                    Icons.schedule,
                    Colors.green,
                    true,
                  ),
                  _buildNotificationItem(
                    'Maintenance Notice',
                    'Bus services will be temporarily unavailable tomorrow',
                    '2 hours ago',
                    Icons.build,
                    Colors.grey,
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String message,
    String time,
    IconData icon,
    Color iconColor,
    bool isUnread,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: isUnread ? 2 : 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                message,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
          trailing: isUnread
              ? Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.indigo[700],
                    shape: BoxShape.circle,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
