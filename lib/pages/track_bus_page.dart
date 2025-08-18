import 'package:flutter/material.dart';
import 'live_tracking_page.dart';

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
