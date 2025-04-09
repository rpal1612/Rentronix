import 'package:flutter/material.dart';

class RentalHistoryScreen extends StatefulWidget {
  const RentalHistoryScreen({Key? key}) : super(key: key);

  @override
  State<RentalHistoryScreen> createState() => _RentalHistoryScreenState();
}

class _RentalHistoryScreenState extends State<RentalHistoryScreen> {
  String _selectedFilter = 'All';
  String _selectedDateFilter = 'All Time';

  // Sample rental history data
  final List<Map<String, dynamic>> _rentalHistory = [
    {
      "deviceName": "MacBook Pro M2",
      "startDate": "2024-03-01",
      "endDate": "2024-03-15",
      "totalPrice": 21000,
      "status": "Active",
      "icon": Icons.laptop,
    },
    {
      "deviceName": "iPhone 15 Pro",
      "startDate": "2024-02-15",
      "endDate": "2024-02-28",
      "totalPrice": 12000,
      "status": "Completed",
      "icon": Icons.phone_android,
    },
    {
      "deviceName": "Sony A7 III Camera",
      "startDate": "2024-01-10",
      "endDate": "2024-01-20",
      "totalPrice": 15000,
      "status": "Completed",
      "icon": Icons.camera_alt,
    },
    {
      "deviceName": "DJI Mavic Air 2",
      "startDate": "2023-12-20",
      "endDate": "2023-12-27",
      "totalPrice": 10500,
      "status": "Completed",
      "icon": Icons.flight,
    },
    {
      "deviceName": "iPad Pro 12.9",
      "startDate": "2024-03-10",
      "endDate": "2024-03-25",
      "totalPrice": 14000,
      "status": "Pending",
      "icon": Icons.tablet_android,
    },
    {
      "deviceName": "Samsung Galaxy S23",
      "startDate": "2024-02-01",
      "endDate": "2024-02-10",
      "totalPrice": 9000,
      "status": "Cancelled",
      "icon": Icons.phone_android,
    },
  ];

  List<Map<String, dynamic>> get filteredRentals {
    return _rentalHistory.where((rental) {
      // Filter by status
      if (_selectedFilter != 'All' && rental['status'] != _selectedFilter) {
        return false;
      }

      // Filter by date
      if (_selectedDateFilter != 'All Time') {
        final DateTime startDate = DateTime.parse(rental['startDate']);
        final DateTime now = DateTime.now();

        if (_selectedDateFilter == 'Last Month') {
          final DateTime lastMonth = DateTime(now.year, now.month - 1, now.day);
          if (startDate.isBefore(lastMonth)) {
            return false;
          }
        } else if (_selectedDateFilter == 'Last 3 Months') {
          final DateTime lastThreeMonths =
              DateTime(now.year, now.month - 3, now.day);
          if (startDate.isBefore(lastThreeMonths)) {
            return false;
          }
        }
      }

      return true;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF8E24AA), const Color(0xFF9C27B0)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Colors.white), // Changed to white for visibility
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Rental History',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF8E24AA).withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter by:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    // Status filter
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFF8E24AA),
                            width: 1,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedFilter,
                          isExpanded: true,
                          dropdownColor: Colors.grey[900],
                          style: TextStyle(color: Colors.white),
                          underline: SizedBox(),
                          icon: Icon(Icons.arrow_drop_down,
                              color: Color(0xFF8E24AA)),
                          items: <String>[
                            'All',
                            'Active',
                            'Pending',
                            'Completed',
                            'Cancelled'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedFilter = newValue!;
                            });
                          },
                          hint: Text('Status',
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    // Date filter
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFF8E24AA),
                            width: 1,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedDateFilter,
                          isExpanded: true,
                          dropdownColor: Colors.grey[900],
                          style: TextStyle(color: Colors.white),
                          underline: SizedBox(),
                          icon: Icon(Icons.arrow_drop_down,
                              color: Color(0xFF8E24AA)),
                          items: <String>[
                            'All Time',
                            'Last Month',
                            'Last 3 Months'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedDateFilter = newValue!;
                            });
                          },
                          hint: Text('Date',
                              style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Rental history list
          Expanded(
            child: filteredRentals.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 70,
                          color: Color(0xFF8E24AA).withOpacity(0.5),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No rental history found',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Try changing your filters',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredRentals.length,
                    itemBuilder: (context, index) {
                      final rental = filteredRentals[index];
                      final startDate = DateTime.parse(rental['startDate']);
                      final endDate = DateTime.parse(rental['endDate']);
                      final formattedStartDate =
                          '${startDate.day}/${startDate.month}/${startDate.year}';
                      final formattedEndDate =
                          '${endDate.day}/${endDate.month}/${endDate.year}';

                      return Container(
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFF8E24AA).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFF8E24AA).withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  rental['icon'],
                                  color: Color(0xFF8E24AA),
                                  size: 28,
                                ),
                              ),
                              title: Text(
                                rental['deviceName'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                '$formattedStartDate - $formattedEndDate',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(rental['status'])
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _getStatusColor(rental['status']),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  rental['status'],
                                  style: TextStyle(
                                    color: _getStatusColor(rental['status']),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Color(0xFF8E24AA).withOpacity(0.2),
                              thickness: 1,
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Price:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Rs ${rental['totalPrice']}',
                                    style: TextStyle(
                                      color: Color(0xFF8E24AA),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (rental['status'] == 'Active')
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          // Handle extend rental
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Rental extension requested'),
                                              backgroundColor:
                                                  Color(0xFF8E24AA),
                                            ),
                                          );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              color: Color(0xFF8E24AA)),
                                          foregroundColor: Color(0xFF8E24AA),
                                        ),
                                        child: Text('Extend Rental'),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle return device
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Return request submitted'),
                                              backgroundColor:
                                                  Color(0xFF8E24AA),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF8E24AA),
                                          foregroundColor: Colors.white,
                                        ),
                                        child: Text('Return Device'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
