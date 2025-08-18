import 'package:flutter/material.dart';
import 'complaints_details_page.dart';
import 'package:vit_bus/models/complaint.dart';

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
