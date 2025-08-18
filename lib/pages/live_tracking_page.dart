import 'package:flutter/material.dart';
import '../models/route_stop.dart';

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
