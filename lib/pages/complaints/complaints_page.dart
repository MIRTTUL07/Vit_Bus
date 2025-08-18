import 'package:flutter/material.dart';
import 'register_complaints_page.dart';
import 'view_complaints_page.dart';
import 'package:vit_bus/models/complaint.dart';

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
