import 'package:flutter/material.dart';
import 'package:vit_bus/models/complaint.dart';

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
