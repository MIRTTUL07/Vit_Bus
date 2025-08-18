import 'package:flutter/material.dart';

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

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    // Note: You'll need to add url_launcher dependency to pubspec.yaml
    // For now, showing a dialog as placeholder
    // await launchUrl(launchUri);

    // Placeholder - showing phone number
    print('Calling: $phoneNumber');
    // You can replace this with actual phone call functionality
  }
}
