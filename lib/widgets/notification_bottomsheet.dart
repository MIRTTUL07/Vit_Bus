import 'package:flutter/material.dart';

class NotificationBottomSheet extends StatelessWidget {
  final List<String> notifications;

  NotificationBottomSheet({
    this.notifications = const [
      "Bus 7A reached the campus",
      "New policy update available",
      "Complaint resolved: Late bus",
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 300,
      child: Column(
        children: [
          Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[700],
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: notifications.isNotEmpty
                ? ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text(notifications[index]),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No notifications',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
