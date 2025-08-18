import 'package:flutter/material.dart';

class RegisterComplaintPage extends StatefulWidget {
  @override
  _RegisterComplaintPageState createState() => _RegisterComplaintPageState();
}

class _RegisterComplaintPageState extends State<RegisterComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _busNumberController = TextEditingController();

  String? _selectedComplaintType;
  List<String> _complaintTypes = [
    'Driver Behavior',
    'Late Arrival',
    'AC Not Working',
    'Cleanliness',
    'Route Issue',
    'Bus Condition',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Complaint',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.orange[600],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'File a Complaint',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please provide details about your complaint',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 24),

              // Complaint Type Dropdown
              Text(
                'Complaint Type *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedComplaintType,
                  hint: Text('Select complaint type'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  items: _complaintTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedComplaintType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a complaint type';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),

              // Bus Number
              Text(
                'Bus Number *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _busNumberController,
                decoration: InputDecoration(
                  hintText: 'Enter bus number (e.g., 7A)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.directions_bus),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the bus number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Issue Summary
              Text(
                'Issue Summary *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _issueController,
                decoration: InputDecoration(
                  hintText: 'Brief summary of the issue',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLength: 100,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide an issue summary';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Detailed Description
              Text(
                'Detailed Description *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Provide detailed description of the complaint...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
                maxLines: 5,
                maxLength: 500,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a detailed description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Submit Button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitComplaint();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Submit Complaint',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitComplaint() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600]),
              SizedBox(width: 8),
              Text('Success'),
            ],
          ),
          content: Text(
            'Your complaint has been registered successfully. You will receive a confirmation with complaint ID shortly.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to complaints page
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.orange[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _issueController.dispose();
    _descriptionController.dispose();
    _busNumberController.dispose();
    super.dispose();
  }
}
