import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(BusTrackingApp());
}

// Route Map Page
class RouteMapPage extends StatelessWidget {
  final String busNumber;

  RouteMapPage({required this.busNumber});

  @override
  Widget build(BuildContext context) {
    List<RouteStop> stops = _getRouteStops(busNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Route Map - Bus $busNumber',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Route Map',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Bus $busNumber Schedule',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),

            // Route Timeline
            Expanded(
              child: ListView.builder(
                itemCount: stops.length,
                itemBuilder: (context, index) {
                  RouteStop stop = stops[index];
                  bool isLast = index == stops.length - 1;

                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Timeline indicator
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: stop.isCompleted
                                    ? Colors.green[600]
                                    : stop.isCurrent
                                    ? Colors.indigo[700]
                                    : Colors.grey[300],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                stop.icon,
                                color: stop.isCompleted || stop.isCurrent
                                    ? Colors.white
                                    : Colors.grey[600],
                                size: 20,
                              ),
                            ),
                            if (!isLast)
                              Container(
                                width: 3,
                                height: 60,
                                color: Colors.grey[300],
                                margin: EdgeInsets.symmetric(vertical: 4),
                              ),
                          ],
                        ),
                        SizedBox(width: 16),

                        // Stop information
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: stop.isCurrent
                                  ? Colors.indigo[50]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: stop.isCurrent
                                    ? Colors.indigo[700]!
                                    : Colors.grey[200]!,
                                width: stop.isCurrent ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        stop.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: stop.isCurrent
                                              ? Colors.indigo[700]
                                              : Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: stop.isCompleted
                                            ? Colors.green[100]
                                            : stop.isCurrent
                                            ? Colors.indigo[100]
                                            : Colors.grey[100],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        stop.time,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: stop.isCompleted
                                              ? Colors.green[700]
                                              : stop.isCurrent
                                              ? Colors.indigo[700]
                                              : Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (stop.isCurrent) ...[
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.directions_bus,
                                        size: 16,
                                        color: Colors.indigo[700],
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Bus is currently here',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.indigo[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (stop.isCompleted && !stop.isCurrent) ...[
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: Colors.green[600],
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Reached',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.green[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Legend
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildLegendItem(
                    Colors.green[600]!,
                    'Reached',
                    Icons.check_circle,
                  ),
                  _buildLegendItem(
                    Colors.indigo[700]!,
                    'Current',
                    Icons.directions_bus,
                  ),
                  _buildLegendItem(
                    Colors.grey[400]!,
                    'Upcoming',
                    Icons.schedule,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, IconData icon) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 14),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  List<RouteStop> _getRouteStops(String busNumber) {
    // Sample route data - you can customize this based on actual routes
    switch (busNumber) {
      case '7A':
        return [
          RouteStop(
            name: 'Arumbakkam',
            time: '6:30 AM',
            icon: Icons.location_on,
            isCompleted: true,
            isCurrent: false,
          ),
          RouteStop(
            name: 'Nerkundram',
            time: '6:45 AM',
            icon: Icons.directions_bus,
            isCompleted: false,
            isCurrent: true,
          ),
          RouteStop(
            name: 'Porur Toll',
            time: '7:00 AM',
            icon: Icons.toll,
            isCompleted: false,
            isCurrent: false,
          ),
          RouteStop(
            name: 'VIT Chennai',
            time: '7:45 AM',
            icon: Icons.school,
            isCompleted: false,
            isCurrent: false,
          ),
        ];
      default:
        return [
          RouteStop(
            name: 'Starting Point',
            time: '6:30 AM',
            icon: Icons.location_on,
            isCompleted: true,
            isCurrent: false,
          ),
          RouteStop(
            name: 'Intermediate Stop',
            time: '6:45 AM',
            icon: Icons.directions_bus,
            isCompleted: false,
            isCurrent: true,
          ),
          RouteStop(
            name: 'VIT Chennai',
            time: '7:45 AM',
            icon: Icons.school,
            isCompleted: false,
            isCurrent: false,
          ),
        ];
    }
  }
}

class RouteStop {
  final String name;
  final String time;
  final IconData icon;
  final bool isCompleted;
  final bool isCurrent;

  RouteStop({
    required this.name,
    required this.time,
    required this.icon,
    this.isCompleted = false,
    this.isCurrent = false,
  });
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo[700],
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  int notificationCount = 3; // Sample notification count

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
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
    ]);
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
          // Notifications Icon with Badge
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white, size: 28),
                onPressed: () {
                  // Navigate to notifications page
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

class HomePage extends StatelessWidget {
  final String studentName;
  final String busNumber;
  final String busStatus;
  final String busLocation;
  final String timeAgo;

  HomePage({
    required this.studentName,
    required this.busNumber,
    required this.busStatus,
    required this.busLocation,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String greeting = _getGreeting(now.hour);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.indigo[700],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, $studentName',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Powerfull people come from powerful places!',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Your Bus: ',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        busNumber,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Running Status Card
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.directions_bus,
                        color: Colors.green[600],
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Running Status',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(busStatus).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _getStatusColor(busStatus),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          busStatus,
                          style: TextStyle(
                            color: _getStatusColor(busStatus),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        timeAgo,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red[500], size: 20),
                      SizedBox(width: 8),
                      Text(
                        busLocation,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          // Quick Actions
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  'Track Live',
                  Icons.my_location,
                  Colors.blue,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Live tracking will be available soon!'),
                        backgroundColor: Colors.indigo[700],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Complaints',
                  Icons.report_problem,
                  Colors.orange,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ComplaintsPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  'Route Map',
                  Icons.map,
                  Colors.green,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RouteMapPage(busNumber: busNumber),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Driver Details',
                  Icons.support_agent,
                  Colors.purple,
                  () {
                    _showDriverDetails(context, busNumber);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getGreeting(int hour) {
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'reached':
        return Colors.green;
      case 'running':
        return Colors.blue;
      case 'delayed':
        return Colors.orange;
      case 'stopped':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 32, color: color),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDriverDetails(BuildContext context, String busNumber) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
            SizedBox(height: 16),

            // Header
            Text(
              'Driver Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Bus $busNumber Driver Information',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),

            // Driver Info
            Row(
              children: [
                // Driver Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.indigo[700]!, width: 3),
                  ),
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),

                // Driver Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getDriverName(busNumber),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${_getDriverExperience(busNumber)} years experience',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.indigo[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Rating
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            double rating = _getDriverRating(busNumber);
                            return Icon(
                              index < rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber[600],
                              size: 20,
                            );
                          }),
                          SizedBox(width: 8),
                          Text(
                            '${_getDriverRating(busNumber).toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Phone Number
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.phone, color: Colors.green[600], size: 20),
                ),
                title: Text('Phone Number'),
                subtitle: Text(_getDriverPhone(busNumber)),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.call, color: Colors.white, size: 18),
                    onPressed: () => _callDriver(_getDriverPhone(busNumber)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),

            // Emergency Contact
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.emergency,
                    color: Colors.red[600],
                    size: 20,
                  ),
                ),
                title: Text('Emergency'),
                subtitle: Text('+91 98765 43210'),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.call, color: Colors.white, size: 18),
                    onPressed: () => _callDriver('+91 98765 43210'),
                  ),
                ),
              ),
            ),

            Spacer(),

            // Close Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper methods for driver information
String _getDriverName(String busNumber) {
  Map<String, String> drivers = {
    '7A': 'Mr. Rajesh Kumar',
    '8A': 'Mr. Suresh Babu',
    '270': 'Mr. Venkat Reddy',
    '7B': 'Mr. Mahesh Singh',
    '9A': 'Mr. Prakash Rao',
    '15C': 'Mr. Dinesh Kumar',
    '22B': 'Mr. Ramesh Sharma',
    '45D': 'Mr. Lokesh Gupta',
  };
  return drivers[busNumber] ?? 'Mr. John Driver';
}

String _getDriverPhone(String busNumber) {
  Map<String, String> phones = {
    '7A': '+91 98765 12345',
    '8A': '+91 98765 12346',
    '270': '+91 98765 12347',
    '7B': '+91 98765 12348',
    '9A': '+91 98765 12349',
    '15C': '+91 98765 12350',
    '22B': '+91 98765 12351',
    '45D': '+91 98765 12352',
  };
  return phones[busNumber] ?? '+91 98765 00000';
}

double _getDriverRating(String busNumber) {
  Map<String, double> ratings = {
    '7A': 4.5,
    '8A': 4.2,
    '270': 4.8,
    '7B': 4.3,
    '9A': 4.6,
    '15C': 4.1,
    '22B': 4.7,
    '45D': 4.4,
  };
  return ratings[busNumber] ?? 4.0;
}

int _getDriverExperience(String busNumber) {
  Map<String, int> experience = {
    '7A': 8,
    '8A': 5,
    '270': 12,
    '7B': 6,
    '9A': 10,
    '15C': 4,
    '22B': 15,
    '45D': 7,
  };
  return experience[busNumber] ?? 5;
}

void _callDriver(String phoneNumber) {
  // Phone call functionality
  print('Calling: $phoneNumber');
  // You can implement actual phone call functionality here
}

// Track Bus Page with Search and Bus List
class TrackBusPage extends StatefulWidget {
  @override
  _TrackBusPageState createState() => _TrackBusPageState();
}

class _TrackBusPageState extends State<TrackBusPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> allBuses = ['7A', '8A', '270', '7B', '9A', '15C', '22B', '45D'];
  List<String> filteredBuses = [];
  String? selectedBus;

  @override
  void initState() {
    super.initState();
    filteredBuses = allBuses;
    _searchController.addListener(_filterBuses);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterBuses() {
    setState(() {
      if (_searchController.text.isEmpty) {
        filteredBuses = allBuses;
      } else {
        filteredBuses = allBuses
            .where(
              (bus) => bus.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track Bus',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search bus number...',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                    size: 24,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey[600]),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 24),

            // Bus List
            Text(
              'Available Buses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),

            Expanded(
              child: filteredBuses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No buses found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try searching with different keywords',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredBuses.length,
                      itemBuilder: (context, index) {
                        String busNumber = filteredBuses[index];
                        bool isSelected = selectedBus == busNumber;

                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Card(
                            elevation: isSelected ? 4 : 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: isSelected
                                    ? Colors.indigo[700]!
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.indigo[700]
                                      : Colors.indigo[100],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  Icons.directions_bus,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.indigo[700],
                                  size: 28,
                                ),
                              ),
                              title: Text(
                                'Bus $busNumber',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.indigo[700]
                                      : Colors.grey[800],
                                ),
                              ),
                              subtitle: Text(
                                _getBusRoute(busNumber),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getBusStatusColor(
                                        busNumber,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: _getBusStatusColor(busNumber),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      _getBusStatus(busNumber),
                                      style: TextStyle(
                                        color: _getBusStatusColor(busNumber),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    isSelected
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    color: isSelected
                                        ? Colors.indigo[700]
                                        : Colors.grey[400],
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  selectedBus = busNumber;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Track Button
            if (selectedBus != null)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LiveTrackingPage(busNumber: selectedBus!),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[700],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_location, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Track Bus $selectedBus',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getBusRoute(String busNumber) {
    Map<String, String> routes = {
      '7A': 'Tambaram - Velachery - VIT',
      '8A': 'Chrompet - Pallavaram - VIT',
      '270': 'Perungudi - OMR - VIT',
      '7B': 'Tambaram - GST Road - VIT',
      '9A': 'Adyar - Guindy - VIT',
      '15C': 'T.Nagar - Saidapet - VIT',
      '22B': 'Anna Nagar - Kilpauk - VIT',
      '45D': 'Porur - Kathipara - VIT',
    };
    return routes[busNumber] ?? 'Route information not available';
  }

  String _getBusStatus(String busNumber) {
    List<String> statuses = ['Running', 'Reached', 'Delayed', 'Stopped'];
    return statuses[busNumber.hashCode % statuses.length];
  }

  Color _getBusStatusColor(String busNumber) {
    String status = _getBusStatus(busNumber);
    switch (status.toLowerCase()) {
      case 'running':
        return Colors.blue;
      case 'reached':
        return Colors.green;
      case 'delayed':
        return Colors.orange;
      case 'stopped':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Live Tracking Page
class LiveTrackingPage extends StatelessWidget {
  final String busNumber;

  LiveTrackingPage({required this.busNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bus $busNumber - Live Tracking',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Section
            _buildMapSection(context),
            SizedBox(height: 20),

            // Driver Details Section
            _buildDriverDetailsSection(context),
            SizedBox(height: 20),

            // Route Map Section
            _buildRouteMapSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 60, color: Colors.indigo[700]),
            SizedBox(height: 12),
            Text(
              'Live Map',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Bus $busNumber Location',
              style: TextStyle(
                fontSize: 16,
                color: Colors.indigo[700],
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Google Maps integration will be implemented here',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverDetailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Driver Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            TextButton(
              onPressed: () => _showFullDriverDetails(context),
              child: Text(
                'View Full Details',
                style: TextStyle(
                  color: Colors.indigo[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // Driver Image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.indigo[700]!, width: 2),
                  ),
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),

                // Driver Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getDriverName(busNumber),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${_getDriverExperience(busNumber)} years experience',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            double rating = _getDriverRating(busNumber);
                            return Icon(
                              index < rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber[600],
                              size: 16,
                            );
                          }),
                          SizedBox(width: 8),
                          Text(
                            '${_getDriverRating(busNumber).toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Call Button
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(22.5),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.call, color: Colors.white, size: 20),
                    onPressed: () => _callDriver(_getDriverPhone(busNumber)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRouteMapSection(BuildContext context) {
    List<RouteStop> stops = _getRouteStops(busNumber);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Route Map',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Bus $busNumber Schedule',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        SizedBox(height: 16),

        Container(
          height: 300, // Fixed height for the route timeline
          child: ListView.builder(
            itemCount: stops.length,
            itemBuilder: (context, index) {
              RouteStop stop = stops[index];
              bool isLast = index == stops.length - 1;

              return Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline indicator
                    Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: stop.isCompleted
                                ? Colors.green[600]
                                : stop.isCurrent
                                ? Colors.indigo[700]
                                : Colors.grey[300],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            stop.icon,
                            color: stop.isCompleted || stop.isCurrent
                                ? Colors.white
                                : Colors.grey[600],
                            size: 16,
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 40,
                            color: Colors.grey[300],
                            margin: EdgeInsets.symmetric(vertical: 4),
                          ),
                      ],
                    ),
                    SizedBox(width: 12),

                    // Stop information
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: stop.isCurrent
                              ? Colors.indigo[50]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: stop.isCurrent
                                ? Colors.indigo[700]!
                                : Colors.grey[200]!,
                            width: stop.isCurrent ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    stop.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: stop.isCurrent
                                          ? Colors.indigo[700]
                                          : Colors.grey[800],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: stop.isCompleted
                                        ? Colors.green[100]
                                        : stop.isCurrent
                                        ? Colors.indigo[100]
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    stop.time,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: stop.isCompleted
                                          ? Colors.green[700]
                                          : stop.isCurrent
                                          ? Colors.indigo[700]
                                          : Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (stop.isCurrent) ...[
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.directions_bus,
                                    size: 14,
                                    color: Colors.indigo[700],
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Bus is currently here',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.indigo[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (stop.isCompleted && !stop.isCurrent) ...[
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 14,
                                    color: Colors.green[600],
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Reached',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.green[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Helper methods for driver information (bus-specific)
  String _getDriverName(String busNumber) {
    Map<String, String> drivers = {
      '7A': 'Mr. Rajesh Kumar',
      '8A': 'Mr. Suresh Babu',
      '270': 'Mr. Venkat Reddy',
      '7B': 'Mr. Mahesh Singh',
      '9A': 'Mr. Prakash Rao',
      '15C': 'Mr. Dinesh Kumar',
      '22B': 'Mr. Ramesh Sharma',
      '45D': 'Mr. Lokesh Gupta',
    };
    return drivers[busNumber] ?? 'Mr. John Driver';
  }

  String _getDriverPhone(String busNumber) {
    Map<String, String> phones = {
      '7A': '+91 98765 12345',
      '8A': '+91 98765 12346',
      '270': '+91 98765 12347',
      '7B': '+91 98765 12348',
      '9A': '+91 98765 12349',
      '15C': '+91 98765 12350',
      '22B': '+91 98765 12351',
      '45D': '+91 98765 12352',
    };
    return phones[busNumber] ?? '+91 98765 00000';
  }

  double _getDriverRating(String busNumber) {
    Map<String, double> ratings = {
      '7A': 4.5,
      '8A': 4.2,
      '270': 4.8,
      '7B': 4.3,
      '9A': 4.6,
      '15C': 4.1,
      '22B': 4.7,
      '45D': 4.4,
    };
    return ratings[busNumber] ?? 4.0;
  }

  int _getDriverExperience(String busNumber) {
    Map<String, int> experience = {
      '7A': 8,
      '8A': 5,
      '270': 12,
      '7B': 6,
      '9A': 10,
      '15C': 4,
      '22B': 15,
      '45D': 7,
    };
    return experience[busNumber] ?? 5;
  }

  void _callDriver(String phoneNumber) {
    print('Calling: $phoneNumber');
    // You can implement actual phone call functionality here
  }

  void _showFullDriverDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
            SizedBox(height: 16),

            // Header
            Text(
              'Driver Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Bus $busNumber Driver Information',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),

            // Driver Info
            Row(
              children: [
                // Driver Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.indigo[700]!, width: 3),
                  ),
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),

                // Driver Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getDriverName(busNumber),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${_getDriverExperience(busNumber)} years experience',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.indigo[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Rating
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            double rating = _getDriverRating(busNumber);
                            return Icon(
                              index < rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber[600],
                              size: 20,
                            );
                          }),
                          SizedBox(width: 8),
                          Text(
                            '${_getDriverRating(busNumber).toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Phone Number
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.phone, color: Colors.green[600], size: 20),
                ),
                title: Text('Phone Number'),
                subtitle: Text(_getDriverPhone(busNumber)),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.call, color: Colors.white, size: 18),
                    onPressed: () => _callDriver(_getDriverPhone(busNumber)),
                  ),
                ),
              ),
            ),

            Spacer(),

            // Close Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Route stops method - same as dashboard but bus-specific
  List<RouteStop> _getRouteStops(String busNumber) {
    switch (busNumber) {
      case '7A':
        return [
          RouteStop(
            name: 'Arumbakkam',
            time: '6:30 AM',
            icon: Icons.location_on,
            isCompleted: true,
            isCurrent: false,
          ),
          RouteStop(
            name: 'Nerkundram',
            time: '6:45 AM',
            icon: Icons.directions_bus,
            isCompleted: false,
            isCurrent: true,
          ),
          RouteStop(
            name: 'Porur Toll',
            time: '7:00 AM',
            icon: Icons.toll,
            isCompleted: false,
            isCurrent: false,
          ),
          RouteStop(
            name: 'VIT Chennai',
            time: '7:45 AM',
            icon: Icons.school,
            isCompleted: false,
            isCurrent: false,
          ),
        ];
      case '8A':
        return [
          RouteStop(
            name: 'Chrompet',
            time: '6:30 AM',
            icon: Icons.location_on,
            isCompleted: true,
            isCurrent: false,
          ),
          RouteStop(
            name: 'Pallavaram',
            time: '6:50 AM',
            icon: Icons.directions_bus,
            isCompleted: false,
            isCurrent: true,
          ),
          RouteStop(
            name: 'VIT Chennai',
            time: '7:30 AM',
            icon: Icons.school,
            isCompleted: false,
            isCurrent: false,
          ),
        ];
      case '270':
        return [
          RouteStop(
            name: 'Perungudi',
            time: '6:30 AM',
            icon: Icons.location_on,
            isCompleted: true,
            isCurrent: false,
          ),
          RouteStop(
            name: 'OMR Junction',
            time: '6:55 AM',
            icon: Icons.directions_bus,
            isCompleted: false,
            isCurrent: true,
          ),
          RouteStop(
            name: 'VIT Chennai',
            time: '7:40 AM',
            icon: Icons.school,
            isCompleted: false,
            isCurrent: false,
          ),
        ];
      default:
        return [
          RouteStop(
            name: 'Starting Point',
            time: '6:30 AM',
            icon: Icons.location_on,
            isCompleted: true,
            isCurrent: false,
          ),
          RouteStop(
            name: 'Intermediate Stop',
            time: '6:45 AM',
            icon: Icons.directions_bus,
            isCompleted: false,
            isCurrent: true,
          ),
          RouteStop(
            name: 'VIT Chennai',
            time: '7:45 AM',
            icon: Icons.school,
            isCompleted: false,
            isCurrent: false,
          ),
        ];
    }
  }
}

class TransportOfficePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transport Office',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Transport Office',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Contact Information',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),

            // Office Details Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.indigo[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.local_shipping,
                            color: Colors.indigo[700],
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'VIT Transport Office',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Available 24/7 for assistance',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Office Address
                    _buildInfoRow(
                      Icons.location_on,
                      'Address',
                      'VIT Chennai Campus\nKelambakkam - Vandalur Rd\nChennai, Tamil Nadu 600127',
                    ),
                    SizedBox(height: 16),

                    // Working Hours
                    _buildInfoRow(
                      Icons.access_time,
                      'Working Hours',
                      'Monday - Saturday: 7:00 AM - 6:00 PM\nSunday: Emergency only',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Contact Numbers Section
            Text(
              'Contact Numbers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),

            // Phone Numbers with Call Buttons
            _buildPhoneCard(
              'Transport Manager',
              '+91 98765 43210',
              Icons.person,
              Colors.blue,
            ),
            SizedBox(height: 12),

            _buildPhoneCard(
              'Emergency Helpline',
              '+91 98765 43211',
              Icons.emergency,
              Colors.red,
            ),
            SizedBox(height: 12),

            _buildPhoneCard(
              'Main Office',
              '+91 44 3993 1555',
              Icons.business,
              Colors.green,
            ),
            SizedBox(height: 12),

            _buildPhoneCard(
              'Bus Coordinator',
              '+91 98765 43212',
              Icons.directions_bus,
              Colors.orange,
            ),
            SizedBox(height: 24),

            // Quick Actions
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    'File Complaint',
                    Icons.report_problem,
                    Colors.orange,
                    () {
                      _showComplaintDialog(context);
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildQuickActionButton(
                    'Request Info',
                    Icons.info,
                    Colors.blue,
                    () {
                      _showInfoDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.indigo[700], size: 20),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneCard(
    String title,
    String phone,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Text(
          phone,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(22.5),
          ),
          child: IconButton(
            icon: Icon(Icons.call, color: Colors.white, size: 20),
            onPressed: () => _makePhoneCall(phone),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 32, color: color),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    // Note: You'll need to add url_launcher dependency to pubspec.yaml
    // For now, showing a dialog as placeholder
    // await launchUrl(launchUri);

    // Placeholder - showing phone number
    print('Calling: $phoneNumber');
    // You can replace this with actual phone call functionality
  }

  void _showComplaintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('File Complaint'),
          content: Text(
            'Complaint filing functionality will be implemented here.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Request Information'),
          content: Text(
            'Information request functionality will be implemented here.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.indigo[100]!),
              ),
              child: Column(
                children: [
                  // Profile Picture
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.indigo[700],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'MIR',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'JUCSE14 3F',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Profile Information
            Text(
              'Profile Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),

            // Information Cards
            _buildInfoCard('Name', 'MIR', Icons.person),
            _buildInfoCard('Student ID', 'JUCSE14 3F', Icons.badge),
            _buildInfoCard('Bus Number', '7A', Icons.directions_bus),
            _buildInfoCard('Email', 'mir@vit.ac.in', Icons.email),
            _buildInfoCard('Mobile', '+91 98765 43210', Icons.phone),
            _buildInfoCard('Department', 'Computer Science', Icons.school),
            _buildInfoCard('Year', '3rd Year', Icons.calendar_today),

            SizedBox(height: 24),

            // Action Buttons
            _buildActionButton(
              'Edit Profile',
              Icons.edit,
              Colors.indigo[700]!,
              () {
                // Handle edit profile
                _showEditDialog(context);
              },
            ),
            SizedBox(height: 12),
            _buildActionButton(
              'Change Password',
              Icons.lock,
              Colors.orange[600]!,
              () {
                // Handle change password
                _showChangePasswordDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.indigo[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.indigo[700], size: 24),
          ),
          title: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Text(
            'Profile editing functionality will be implemented here.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Text(
            'Password change functionality will be implemented here.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

// Updated Settings Page based on the image format
class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeChanged;

  SettingsPage({required this.isDarkMode, required this.onDarkModeChanged});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool darkMode;
  bool manageNotification = true;
  bool privacyPolicy = true;
  bool sendFeedback = true;
  bool signOut = false;

  @override
  void initState() {
    super.initState();
    darkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            SizedBox(height: 24),

            // Dark Mode
            _buildSettingsItem('Dark Mode', Icons.dark_mode, darkMode, (value) {
              setState(() {
                darkMode = value;
              });
              widget.onDarkModeChanged(value);
            }),

            // Manage Notification
            _buildSettingsItem(
              'Manage Notification',
              Icons.notifications,
              manageNotification,
              (value) {
                setState(() {
                  manageNotification = value;
                });
              },
            ),

            // Privacy Policy
            _buildSettingsItem(
              'Privacy Policy',
              Icons.privacy_tip,
              privacyPolicy,
              (value) {
                setState(() {
                  privacyPolicy = value;
                });
              },
            ),

            // Send Feedback
            _buildSettingsItem('Send Feedback', Icons.feedback, sendFeedback, (
              value,
            ) {
              setState(() {
                sendFeedback = value;
              });
            }),

            // Sign Out
            _buildSettingsItem('Sign Out', Icons.logout, signOut, (value) {
              setState(() {
                signOut = value;
              });
              if (value) {
                _showSignOutDialog(context);
              }
            }, isSignOut: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    IconData icon,
    bool value,
    Function(bool) onChanged, {
    bool isSignOut = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Theme.of(context).cardColor,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSignOut ? Colors.red[100] : Colors.indigo[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isSignOut ? Colors.red[600] : Colors.indigo[700],
              size: 24,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSignOut
                  ? Colors.red[600]
                  : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          trailing: Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: isSignOut ? Colors.red[600] : Colors.indigo[700],
              activeTrackColor: isSignOut
                  ? Colors.red[200]
                  : Colors.indigo[200],
            ),
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: Text(
            'Sign Out',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  signOut = false;
                });
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle actual sign out logic here
              },
              child: Text('Sign Out', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

class FeeReceiptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fee Receipt',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Fee Receipt',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Annual Bus Transportation Fee',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),

            // Receipt Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.grey[50]!],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Receipt Header
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.indigo[700],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.school,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'VIT CHENNAI',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            'Transport Department',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.green[600]!,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'RECEIPT',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Student Details Section
                    _buildSectionHeader('Student Details'),
                    SizedBox(height: 12),
                    _buildDetailRow('Name', 'MIR'),
                    _buildDetailRow('Registration No.', 'JUCSE14 3F'),
                    _buildDetailRow('Course', 'B.Tech CSE'),
                    _buildDetailRow('Academic Year', '2024-2025'),

                    SizedBox(height: 20),

                    // Bus Details Section
                    _buildSectionHeader('Bus Details'),
                    SizedBox(height: 12),
                    _buildDetailRow('Bus Number', '7A'),
                    _buildDetailRow('Route', 'Tambaram - Velachery - VIT'),

                    // AC/NON AC Bus Type - Bold notation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bus Type:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.blue[600]!,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            'AC BUS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Fee Details Section
                    _buildSectionHeader('Fee Details'),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        children: [
                          _buildFeeDetailRow('Annual Bus Fee (AC)', '₹ 24,000'),
                          Divider(color: Colors.grey[400]),
                          _buildFeeDetailRow('Processing Fee', '₹ 500'),
                          Divider(color: Colors.grey[400]),
                          _buildFeeDetailRow(
                            'Total Amount',
                            '₹ 24,500',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Payment Details Section
                    _buildSectionHeader('Payment Details'),
                    SizedBox(height: 12),
                    _buildDetailRow('Payment Date', '15 Aug 2024'),
                    _buildDetailRow('Transaction ID', 'TXN2024080001'),
                    _buildDetailRow('Payment Mode', 'Online'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.green[600]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green[600],
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'PAID',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24),

                    // QR Code Section
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'QR Code for Verification',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  size: 60,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'QR CODE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Scan to verify receipt authenticity',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Footer
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'This is a computer generated receipt',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Valid for Academic Year 2024-2025',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Download Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _downloadReceipt(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'Download Receipt',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Additional Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue[600], size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Important Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      '• Keep this receipt safe for verification purposes\n'
                      '• Bus pass will be issued separately\n'
                      '• Fee is non-refundable once academic year starts\n'
                      '• For queries, contact Transport Office',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.indigo[700]!, width: 2),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.indigo[700],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeDetailRow(
    String label,
    String amount, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              color: isTotal ? Colors.grey[800] : Colors.grey[700],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              color: isTotal ? Colors.green[700] : Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _downloadReceipt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.download, color: Colors.indigo[700]),
              SizedBox(width: 8),
              Text('Download Receipt'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select download format:'),
              SizedBox(height: 16),
              ListTile(
                dense: true,
                leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text('PDF Format'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Handle PDF download
                  _showDownloadSuccess(context, 'PDF');
                },
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.image, color: Colors.blue),
                title: Text('Image Format (PNG)'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Handle image download
                  _showDownloadSuccess(context, 'PNG');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showDownloadSuccess(BuildContext context, String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Receipt downloaded as $format successfully!'),
          ],
        ),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// Main Complaints Page
class ComplaintsPage extends StatefulWidget {
  @override
  _ComplaintsPageState createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  List<Complaint> complaints = [
    Complaint(
      id: 'CMP001',
      type: 'Driver Behavior',
      issue: 'Driver was rude and unhelpful',
      busNumber: '7A',
      status: 'Under Review',
      date: '2024-01-15',
      description:
          'The bus driver was very rude when I asked about the route. He refused to help and was unprofessional.',
    ),
    Complaint(
      id: 'CMP002',
      type: 'Late Arrival',
      issue: 'Bus arrived 30 minutes late',
      busNumber: '8A',
      status: 'Resolved',
      date: '2024-01-12',
      description:
          'Bus 8A was consistently late for the past week, causing me to miss my classes.',
    ),
    Complaint(
      id: 'CMP003',
      type: 'AC Not Working',
      issue: 'Air conditioning system failed',
      busNumber: '7A',
      status: 'In Progress',
      date: '2024-01-10',
      description:
          'The AC in bus 7A has not been working for the past 3 days. Very uncomfortable during hot weather.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaints',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Complaint Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Register new complaints or view existing ones',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    'Register Complaint',
                    Icons.add_circle_outline,
                    Colors.orange[600]!,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterComplaintPage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    'View Complaints',
                    Icons.list_alt,
                    Colors.blue[600]!,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewComplaintsPage(complaints: complaints),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Recent Complaints Preview
            Text(
              'Recent Complaints',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),

            Expanded(
              child: complaints.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No complaints found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your registered complaints will appear here',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: complaints.length > 3 ? 3 : complaints.length,
                      itemBuilder: (context, index) {
                        return _buildComplaintPreviewCard(complaints[index]);
                      },
                    ),
            ),

            // View All Button
            if (complaints.length > 3)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 16),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewComplaintsPage(complaints: complaints),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.indigo[700],
                    side: BorderSide(color: Colors.indigo[700]!),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'View All Complaints',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(icon, size: 28, color: color),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintPreviewCard(Complaint complaint) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getStatusColor(complaint.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              _getComplaintIcon(complaint.type),
              color: _getStatusColor(complaint.status),
              size: 20,
            ),
          ),
          title: Text(
            complaint.issue,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Bus ${complaint.busNumber}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('•', style: TextStyle(color: Colors.grey[400])),
                  SizedBox(width: 8),
                  Text(
                    complaint.date,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(complaint.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              complaint.status,
              style: TextStyle(
                color: _getStatusColor(complaint.status),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return Colors.green[600]!;
      case 'in progress':
        return Colors.blue[600]!;
      case 'under review':
        return Colors.orange[600]!;
      case 'rejected':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  IconData _getComplaintIcon(String type) {
    switch (type.toLowerCase()) {
      case 'driver behavior':
        return Icons.person_outline;
      case 'late arrival':
        return Icons.schedule;
      case 'ac not working':
        return Icons.ac_unit;
      case 'cleanliness':
        return Icons.cleaning_services;
      case 'route issue':
        return Icons.map;
      default:
        return Icons.report_problem;
    }
  }
}

// Register Complaint Page
class RegisterComplaintPage extends StatefulWidget {
  @override
  _RegisterComplaintPageState createState() => _RegisterComplaintPageState();
}

class _RegisterComplaintPageState extends State<RegisterComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _busNumberController = TextEditingController();

  String? _selectedComplaintType;
  List<String> _complaintTypes = [
    'Driver Behavior',
    'Late Arrival',
    'AC Not Working',
    'Cleanliness',
    'Route Issue',
    'Bus Condition',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Complaint',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange[600],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'File a Complaint',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please provide details about your complaint',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 24),

              // Complaint Type Dropdown
              Text(
                'Complaint Type *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedComplaintType,
                  hint: Text('Select complaint type'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  items: _complaintTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedComplaintType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a complaint type';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),

              // Bus Number
              Text(
                'Bus Number *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _busNumberController,
                decoration: InputDecoration(
                  hintText: 'Enter bus number (e.g., 7A)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.directions_bus),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the bus number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Issue Summary
              Text(
                'Issue Summary *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _issueController,
                decoration: InputDecoration(
                  hintText: 'Brief summary of the issue',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLength: 100,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide an issue summary';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Detailed Description
              Text(
                'Detailed Description *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Provide detailed description of the complaint...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
                maxLines: 5,
                maxLength: 500,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a detailed description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Submit Button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitComplaint();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Submit Complaint',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitComplaint() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600]),
              SizedBox(width: 8),
              Text('Success'),
            ],
          ),
          content: Text(
            'Your complaint has been registered successfully. You will receive a confirmation with complaint ID shortly.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to complaints page
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.orange[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _issueController.dispose();
    _descriptionController.dispose();
    _busNumberController.dispose();
    super.dispose();
  }
}

// View Complaints Page
class ViewComplaintsPage extends StatefulWidget {
  final List<Complaint> complaints;

  ViewComplaintsPage({required this.complaints});

  @override
  _ViewComplaintsPageState createState() => _ViewComplaintsPageState();
}

class _ViewComplaintsPageState extends State<ViewComplaintsPage> {
  String _selectedFilter = 'All';
  List<String> _filters = [
    'All',
    'Under Review',
    'In Progress',
    'Resolved',
    'Rejected',
  ];

  @override
  Widget build(BuildContext context) {
    List<Complaint> filteredComplaints = _selectedFilter == 'All'
        ? widget.complaints
        : widget.complaints
              .where((complaint) => complaint.status == _selectedFilter)
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Complaints',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue[600],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Complaints',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${filteredComplaints.length} complaint(s) found',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  bool isSelected = _selectedFilter == filter;
                  return Container(
                    margin: EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      selectedColor: Colors.blue[100],
                      checkmarkColor: Colors.blue[600],
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.blue[600] : Colors.grey[700],
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),

            // Complaints List
            Expanded(
              child: filteredComplaints.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No complaints found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _selectedFilter == 'All'
                                ? 'You haven\'t registered any complaints yet'
                                : 'No $_selectedFilter complaints found',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredComplaints.length,
                      itemBuilder: (context, index) {
                        return _buildComplaintCard(filteredComplaints[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplaintCard(Complaint complaint) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ComplaintDetailsPage(complaint: complaint),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        complaint.id,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          complaint.status,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getStatusColor(complaint.status),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        complaint.status,
                        style: TextStyle(
                          color: _getStatusColor(complaint.status),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // Issue Title
                Text(
                  complaint.issue,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 8),

                // Type and Bus Info
                Row(
                  children: [
                    Icon(
                      _getComplaintIcon(complaint.type),
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 4),
                    Text(
                      complaint.type,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.directions_bus,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Bus ${complaint.busNumber}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Date and Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filed on ${complaint.date}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    Text(
                      'Tap to view details →',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return Colors.green[600]!;
      case 'in progress':
        return Colors.blue[600]!;
      case 'under review':
        return Colors.orange[600]!;
      case 'rejected':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  IconData _getComplaintIcon(String type) {
    switch (type.toLowerCase()) {
      case 'driver behavior':
        return Icons.person_outline;
      case 'late arrival':
        return Icons.schedule;
      case 'ac not working':
        return Icons.ac_unit;
      case 'cleanliness':
        return Icons.cleaning_services;
      case 'route issue':
        return Icons.map;
      default:
        return Icons.report_problem;
    }
  }
}

// Complaint Details Page
class ComplaintDetailsPage extends StatelessWidget {
  final Complaint complaint;

  ComplaintDetailsPage({required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaint Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _getStatusColor(complaint.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getStatusColor(complaint.status),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(complaint.status),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          complaint.status,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        complaint.id,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(complaint.status),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    complaint.issue,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Complaint Info
            _buildInfoSection('Complaint Information', [
              _buildInfoRow('Type', complaint.type, Icons.category),
              _buildInfoRow(
                'Bus Number',
                complaint.busNumber,
                Icons.directions_bus,
              ),
              _buildInfoRow('Date Filed', complaint.date, Icons.calendar_today),
            ]),
            SizedBox(height: 24),

            // Description
            _buildInfoSection('Description', [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Text(
                  complaint.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ),
            ]),
            SizedBox(height: 24),

            // Actions
            if (complaint.status.toLowerCase() == 'under review' ||
                complaint.status.toLowerCase() == 'in progress')
              Container(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showUpdateDialog(context, complaint);
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Request Update'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.indigo[700],
                    side: BorderSide(color: Colors.indigo[700]!),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, Complaint complaint) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text('Request Update'),
          content: Text(
            'Would you like to request an update on your complaint ${complaint.id}? We will notify the transport office to provide you with the latest status.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessSnackBar(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[700],
                foregroundColor: Colors.white,
              ),
              child: Text('Send Request'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Update request sent successfully!'),
          ],
        ),
        backgroundColor: Colors.green[600],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return Colors.green[600]!;
      case 'in progress':
        return Colors.blue[600]!;
      case 'under review':
        return Colors.orange[600]!;
      case 'rejected':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }
}

// Complaint Data Model
class Complaint {
  final String id;
  final String type;
  final String issue;
  final String busNumber;
  final String status;
  final String date;
  final String description;

  Complaint({
    required this.id,
    required this.type,
    required this.issue,
    required this.busNumber,
    required this.status,
    required this.date,
    required this.description,
  });
}
