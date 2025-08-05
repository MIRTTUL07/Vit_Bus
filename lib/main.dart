import 'package:flutter/material.dart';

void main() {
  runApp(BusTrackingApp());
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
  String studentId = "24BRS1438";
  String busNumber = "7A";
  String busStatus = "Reached";
  String busLocation = "Mogapair";
  String timeAgo = "1m ago";
  int _selectedIndex = 0;

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
        title: Text('Student Dashboard'),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.person_outline),
          ),
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
                    // Navigate to live tracking
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Bus Schedule',
                  Icons.schedule,
                  Colors.orange,
                  () {
                    // Navigate to schedule
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
                    // Navigate to route map
                  },
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Support',
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

// Placeholder pages for menu items
class TrackBusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_bus, size: 64, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Track Bus',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Live bus tracking will appear here'),
        ],
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
