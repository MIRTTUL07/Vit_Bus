import 'package:flutter/material.dart';
import '../pages/complaints/complaints_page.dart';
import 'route_map_page.dart';
import '../widgets/driver_details_sheet.dart';
import 'bus_map.dart';

class HomePage extends StatelessWidget {
  final String studentName;
  final String busNumber;
  final String busStatus;
  final String busLocation;
  final String timeAgo;

  const HomePage({
    super.key,
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.indigo[700],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, $studentName',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Powerful people come from powerful places!',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Your Bus: ',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
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
          const SizedBox(height: 20),

          // Running Status Card
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
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
                      const SizedBox(width: 12),
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
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
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
                      const Spacer(),
                      Text(
                        timeAgo,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red[500], size: 20),
                      const SizedBox(width: 8),
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
          const SizedBox(height: 20),

          // Quick Actions
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
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
                      MaterialPageRoute(
                        builder: (context) => BusMapPage(
                          busNumber: busNumber,
                          trackingUrl:
                              'https://gpsvts.vamosys.com/gps/public/track?vehicleId=qpuwugjkhsgwhylmqfab&maps=track&userID=SBLEHO',
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
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
          const SizedBox(height: 12),
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
              const SizedBox(width: 12),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 8),
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
    Map<String, String> driverInfo = _getDriverInfo(busNumber);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DriverDetailsSheet(
        driverName: driverInfo['name']!,
        licenseNumber: driverInfo['license']!,
        contactNumber: driverInfo['contact']!,
      ),
    );
  }

  Map<String, String> _getDriverInfo(String busNumber) {
    Map<String, Map<String, String>> driverData = {
      '7A': {
        'name': 'Raman Kumar',
        'license': 'TN07DL1234567',
        'contact': '+91-9876543210',
      },
      '1A': {
        'name': 'Suresh Patel',
        'license': 'TN01DL9876543',
        'contact': '+91-9123456789',
      },
      '2B': {
        'name': 'Rajesh Singh',
        'license': 'TN02DL5555555',
        'contact': '+91-9111111111',
      },
    };

    return driverData[busNumber] ??
        {
          'name': 'Driver Information',
          'license': 'Not Available',
          'contact': 'Contact Transport Office',
        };
  }
}
