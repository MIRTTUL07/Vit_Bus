import 'package:flutter/material.dart';

class DriverDetailsSheet extends StatelessWidget {
  final String driverName;
  final String licenseNumber;
  final String contactNumber;

  const DriverDetailsSheet({
    super.key,
    required this.driverName,
    required this.licenseNumber,
    required this.contactNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6, // ✅ Limit height
      ),
      child: SingleChildScrollView(
        // ✅ Make it scrollable
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // ✅ Use minimum space needed
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Driver Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[700],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.person, "Name", driverName),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.badge, "License No.", licenseNumber),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.phone, "Contact", contactNumber),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                label: const Text('Close'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo[600], size: 20),
        const SizedBox(width: 12),
        Text(
          "$title: ",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}
