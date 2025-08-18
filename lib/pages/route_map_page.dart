import 'package:flutter/material.dart';

class RouteStop {
  final String name;
  final String time;
  final IconData icon;
  final bool isCompleted;
  final bool isCurrent;

  const RouteStop({
    required this.name,
    required this.time,
    required this.icon,
    this.isCompleted = false,
    this.isCurrent = false,
  });
}

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
