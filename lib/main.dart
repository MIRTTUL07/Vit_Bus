import 'package:flutter/material.dart';

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

class BusTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Bus Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BusTrackingDashboard(),
    );
  }
}

class BusTrackingDashboard extends StatefulWidget {
  @override
  _BusTrackingDashboardState createState() => _BusTrackingDashboardState();
}

class _BusTrackingDashboardState extends State<BusTrackingDashboard> {
  String studentName = "MIR";
  String studentId = "JUCSE14 3F";
  String busNumber = "7A";
  String busStatus = "Reached";
  String busLocation = "Mogabari";
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
      DriverDetailsPage(),
      TransportOfficePage(),
      ProfilePage(),
      SettingsPage(),
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
              _buildDrawerItem(Icons.person, 'Driver Details', 2),
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
                  'Welcome...',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrackBusPage()),
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Complaints',
                  Icons
                      .report_problem, // Changed from Icons.schedule to Icons.report_problem
                  Colors.orange,
                  () {
                    // Navigate to complaints
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
                    // Navigate to support
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 80, color: Colors.indigo[700]),
            SizedBox(height: 20),
            Text(
              'Live Tracking',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Bus $busNumber',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.indigo[700],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Map integration will be implemented here',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Features: Real-time location, ETA, Route display',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class DriverDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 64, color: Colors.green),
          SizedBox(height: 16),
          Text(
            'Driver Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Driver information will appear here'),
        ],
      ),
    );
  }
}

class TransportOfficePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_shipping, size: 64, color: Colors.orange),
          SizedBox(height: 16),
          Text(
            'Transport Office',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Transport office details will appear here'),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, size: 64, color: Colors.purple),
          SizedBox(height: 16),
          Text(
            'Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Your profile information will appear here'),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('App settings will appear here'),
        ],
      ),
    );
  }
}
