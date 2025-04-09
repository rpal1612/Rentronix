import 'package:flutter/material.dart';
import 'package:rentronix/screens/chat_screen.dart';
import 'package:rentronix/screens/profile_page.dart';
import 'rental_history_screen.dart';
import 'feedback_screen.dart';
import 'device_detail_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = '';

  void _handleLocationIconPress() {
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    // Add this function around line 351 (before the build method)


    if (status.isGranted) {
      try {
        final position = await Geolocator.getCurrentPosition();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Location access granted. Your coordinates: ${position.latitude}, ${position.longitude}"),
            backgroundColor: Colors.green,
          ),
        );
        // Here you would typically update the UI with nearby devices
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error getting location: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Location permission denied. Some features may not work."),
          backgroundColor: Colors.orange,
        ),
      );
    } else if (status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Location Permission Required"),
          content: Text("Location permission is required for finding devices near you. Please enable it in settings."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: Text("Open Settings"),
            ),
          ],
        ),
      );
    }
  }

  // Sample data for categories
  final List<Map<String, dynamic>> _categories = [
    {"name": "Phones", "icon": Icons.phone_android},
    {"name": "Laptops", "icon": Icons.laptop},
    {"name": "Televisions", "icon": Icons.tv},
    {"name": "Cameras", "icon": Icons.camera_alt},
    {"name": "Headphones", "icon": Icons.headphones},
    {"name": "Tablets", "icon": Icons.tablet_android},
  ];

  // Sample data for featured items
  final List<Map<String, dynamic>> _featuredItems = [
    {
      "name": "iPhone 15 Pro",
      "price": 1500,
      "period": "day",
      "image": "assets/images/iphone15.jpg",
      "category": "Phones",
      "description": "Latest model smartphone with high-end camera",
      "owner": {"name": "John Doe", "rating": 4.8, "distance": "2.5 km"},
      "feedback": [
        {"user": "Alice", "comment": "Great condition", "rating": 5},
        {"user": "Bob", "comment": "Very responsive owner", "rating": 4.5}
      ]
    },
    {
      "name": "MacBook Pro M3",
      "price": 3500,
      "period": "day",
      "image": "assets/images/macbook.jpeg",
      "category": "Laptops",
      "description": "Powerful laptop for all your computing needs",
      "owner": {"name": "Jane Smith", "rating": 4.9, "distance": "3.2 km"},
      "feedback": [
        {"user": "Charlie", "comment": "Fast performance", "rating": 5},
        {"user": "David", "comment": "Like new condition", "rating": 4.7}
      ]
    },
    {
      "name": "iPad Pro",
      "price": 2000,
      "period": "day",
      "image": "assets/images/ipad.jpeg",
      "category": "Tablets",
      "description": "Premium tablet with stunning display",
      "owner": {"name": "Mike Johnson", "rating": 4.7, "distance": "1.8 km"},
      "feedback": [
        {"user": "Eve", "comment": "Perfect for digital art", "rating": 4.8},
        {"user": "Frank", "comment": "Great battery life", "rating": 4.6}
      ]
    },
    {
      "name": "Canon EOS R5",
      "price": 2500,
      "period": "day",
      "image": "assets/images/camera.jpeg",
      "category": "Cameras",
      "description": "Professional-grade camera for photography enthusiasts",
      "owner": {"name": "Sarah Williams", "rating": 4.6, "distance": "4.1 km"},
      "feedback": [
        {"user": "Grace", "comment": "Amazing image quality", "rating": 4.9},
        {"user": "Henry", "comment": "Well maintained", "rating": 4.5}
      ]
    },
    {
      "name": "Sony WH-1000XM5",
      "price": 800,
      "period": "day",
      "image": "assets/images/headphones.jpeg",
      "category": "Headphones",
      "description": "Premium noise-cancelling headphones",
      "owner": {"name": "Alex Thompson", "rating": 4.7, "distance": "2.9 km"},
      "feedback": [
        {"user": "Ivy", "comment": "Great noise cancellation", "rating": 4.8},
        {"user": "Jack", "comment": "Crystal clear sound", "rating": 4.7}
      ]
    },
    {
      "name": "LG OLED TV",
      "price": 3000,
      "period": "day",
      "image": "assets/images/tv.jpeg",
      "category": "Televisions",
      "description": "4K OLED TV with stunning picture quality",
      "owner": {"name": "Emma Davis", "rating": 4.8, "distance": "3.5 km"},
      "feedback": [
        {"user": "Kevin", "comment": "Amazing picture quality", "rating": 5},
        {"user": "Linda", "comment": "Easy setup", "rating": 4.6}
      ]
    },
  ];

  // Sample data for promotional banners
  final List<Map<String, dynamic>> _banners = [
    {
      "title": "20% Discount on Laptops",
      "subtitle": "Valid until March 31",
      "color": Color(0xFF8E24AA),
    },
    {
      "title": "Free Delivery on First Order",
      "subtitle": "Use code: FIRSTFREE",
      "color": Color(0xFF6A1B9A),
    },
    
    
    {
      "title": "Weekend Special: 30% Off",
      "subtitle": "On all audio equipment",
      "color": Color(0xFF4A148C),
    },
  ];

  // Filtered items based on search and category
  List<Map<String, dynamic>> get _filteredItems {
    return _featuredItems.where((item) {
      // Check if item matches search query
      bool matchesSearch = _searchQuery.isEmpty ||
          item["name"].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item["description"].toLowerCase().contains(_searchQuery.toLowerCase());

      // Check if item matches selected category
      bool matchesCategory = _selectedCategory.isEmpty ||
          item["category"] == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Chat tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      ).then((_) {
        // Reset to Home tab when returning from Chat
        setState(() {
          _selectedIndex = 0;
        });
      });
    }
    // Navigate based on the selected tab
    if (index == 2) {
      // History tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RentalHistoryScreen()),
      ).then((_) {
        // Reset to Home tab when returning from History
        setState(() {
          _selectedIndex = 0;
        });
      });
    } else if (index == 3) {
      // Feedback tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedbackScreen()),
      ).then((_) {
        // Reset to Home tab when returning from Feedback
        setState(() {
          _selectedIndex = 0;
        });
      });
    } else if (index == 4) {
      // Profile tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      ).then((_) {
        // Reset to Home tab when returning from profile
        setState(() {
          _selectedIndex = 0;
        });
      });
    }
  }

  // Function to navigate to device detail screen
  void _navigateToDeviceDetail(Map<String, dynamic> device) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeviceDetailScreen(device: device),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          title: Row(
            children: [
              Icon(Icons.devices, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'RENTRONIX',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.location_on, color: Colors.white),
              onPressed: _handleLocationIconPress,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFF8E24AA), width: 1),
              ),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search for devices...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF8E24AA)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, color: Color(0xFF8E24AA)),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },

              ),
            ),

            // Promotional Banners
            SizedBox(
              height: 150,
              child: PageView.builder(
                itemCount: _banners.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _banners[index]["color"],
                          _banners[index]["color"].withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -20,
                          bottom: -20,
                          child: Icon(
                            Icons.devices,
                            size: 150,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 20,
                          right: 20,
                          bottom: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _banners[index]["title"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                _banners[index]["subtitle"],
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Rent Now',
                                    style: TextStyle(
                                      color: _banners[index]["color"],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
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

            // Categories Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Browse Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Categories Grid
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index]["name"];
                  final isSelected = _selectedCategory == category;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          // Deselect if already selected
                          _selectedCategory = '';
                        } else {
                          // Select the category
                          _selectedCategory = category;
                        }
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFF8E24AA).withOpacity(0.3) : Colors.grey[900],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? Color(0xFF8E24AA) : Color(0xFF8E24AA).withOpacity(0.5),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected ? Color(0xFF8E24AA).withOpacity(0.4) : Color(0xFF8E24AA).withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _categories[index]["icon"],
                              color: isSelected ? Colors.white : Color(0xFF8E24AA),
                              size: 28,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            _categories[index]["name"],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Recommended Devices Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended Devices',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      color: Color(0xFF8E24AA),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Recommended Devices List
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: _featuredItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _navigateToDeviceDetail(_featuredItems[index]),
                    child: Container(
                      width: 160,
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xFF8E24AA).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Device Image
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage(_featuredItems[index]["image"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _featuredItems[index]["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      'Rs ${_featuredItems[index]["price"]}',
                                      style: TextStyle(
                                        color: Color(0xFF8E24AA),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '/${_featuredItems[index]["period"]}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    Text(
                                      ' ${_featuredItems[index]["owner"]["rating"]}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Near You Section with filtering based on category
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedCategory.isEmpty ? 'Near You' : 'Near You - $_selectedCategory',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      if (_selectedCategory.isNotEmpty || _searchQuery.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedCategory = '';
                              _searchQuery = '';
                              _searchController.clear();
                            });
                          },
                          child: Text(
                            'Clear Filters',
                            style: TextStyle(
                              color: Color(0xFF8E24AA),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF8E24AA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Near You Grid with filtering
            _filteredItems.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Color(0xFF8E24AA).withOpacity(0.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No devices found',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Try adjusting your search or category filters',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
                : GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final device = _filteredItems[index];
                return GestureDetector(
                  onTap: () => _navigateToDeviceDetail(device),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xFF8E24AA).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ // Added colon here
                          // Device Image
                          Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: AssetImage(device["image"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF8E24AA),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [ // Added colon here
                                Text(
                                  device["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      'Rs ${device["price"]}',
                                      style: TextStyle(
                                        color: Color(0xFF8E24AA),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '/${device["period"]}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Color(0xFF8E24AA),
                                      size: 12,
                                    ),
                                    Expanded(
                                      child: Text(
                                        ' ${device["owner"]["distance"]}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF8E24AA),
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}