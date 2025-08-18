import 'package:flutter/material.dart';

class FeeReceiptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fee Receipt',
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
              'Fee Receipt',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Annual Bus Transportation Fee',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),

            // Receipt Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.grey[50]!],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Receipt Header
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.indigo[700],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.school,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'VIT CHENNAI',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            'Transport Department',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.green[600]!,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'RECEIPT',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Student Details Section
                    _buildSectionHeader('Student Details'),
                    SizedBox(height: 12),
                    _buildDetailRow('Name', 'MIR'),
                    _buildDetailRow('Registration No.', 'JUCSE14 3F'),
                    _buildDetailRow('Course', 'B.Tech CSE'),
                    _buildDetailRow('Academic Year', '2024-2025'),

                    SizedBox(height: 20),

                    // Bus Details Section
                    _buildSectionHeader('Bus Details'),
                    SizedBox(height: 12),
                    _buildDetailRow('Bus Number', '7A'),
                    _buildDetailRow('Route', 'Tambaram - Velachery - VIT'),

                    // AC/NON AC Bus Type - Bold notation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bus Type:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.blue[600]!,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            'AC BUS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Fee Details Section
                    _buildSectionHeader('Fee Details'),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        children: [
                          _buildFeeDetailRow('Annual Bus Fee (AC)', '₹ 24,000'),
                          Divider(color: Colors.grey[400]),
                          _buildFeeDetailRow('Processing Fee', '₹ 500'),
                          Divider(color: Colors.grey[400]),
                          _buildFeeDetailRow(
                            'Total Amount',
                            '₹ 24,500',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Payment Details Section
                    _buildSectionHeader('Payment Details'),
                    SizedBox(height: 12),
                    _buildDetailRow('Payment Date', '15 Aug 2024'),
                    _buildDetailRow('Transaction ID', 'TXN2024080001'),
                    _buildDetailRow('Payment Mode', 'Online'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.green[600]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green[600],
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'PAID',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24),

                    // QR Code Section
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'QR Code for Verification',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  size: 60,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'QR CODE',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Scan to verify receipt authenticity',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Footer
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'This is a computer generated receipt',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Valid for Academic Year 2024-2025',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Download Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _downloadReceipt(context);
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
                    Icon(Icons.download, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'Download Receipt',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Additional Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue[600], size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Important Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      '• Keep this receipt safe for verification purposes\n'
                      '• Bus pass will be issued separately\n'
                      '• Fee is non-refundable once academic year starts\n'
                      '• For queries, contact Transport Office',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.5,
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

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.indigo[700]!, width: 2),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.indigo[700],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeDetailRow(
    String label,
    String amount, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              color: isTotal ? Colors.grey[800] : Colors.grey[700],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              color: isTotal ? Colors.green[700] : Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _downloadReceipt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.download, color: Colors.indigo[700]),
              SizedBox(width: 8),
              Text('Download Receipt'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select download format:'),
              SizedBox(height: 16),
              ListTile(
                dense: true,
                leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text('PDF Format'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Handle PDF download
                  _showDownloadSuccess(context, 'PDF');
                },
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.image, color: Colors.blue),
                title: Text('Image Format (PNG)'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Handle image download
                  _showDownloadSuccess(context, 'PNG');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showDownloadSuccess(BuildContext context, String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Receipt downloaded as $format successfully!'),
          ],
        ),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
