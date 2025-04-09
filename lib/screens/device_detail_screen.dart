// import 'package:flutter/material.dart';
// import 'package:rentronix/widget/payment_gateway_widget.dart';
// class DeviceDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> device;
//   const DeviceDetailScreen({Key? key, required this.device}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: CustomScrollView(
//         slivers: [
//           // App Bar with Image
//           SliverAppBar(
//             expandedHeight: 300,
//             pinned: true,
//             backgroundColor: Colors.black,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(device["image"]),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.7),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             leading: IconButton(
//               icon: Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.5),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(Icons.arrow_back, color: Colors.white),
//               ),
//               onPressed: () => Navigator.pop(context),
//             ),
//             actions: [
//               IconButton(
//                 icon: Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.5),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.favorite_border, color: Colors.white),
//                 ),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.5),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.share, color: Colors.white),
//                 ),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//           // Device Details
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Device Name and Price
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           device["name"],
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       // a. Price
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: Colors.purple,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           "\Rs.${device["price"]}/day",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   // b. Owner details
//                   Container(
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade900,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: AssetImage(device["ownerImage"] ?? "assets/images/profile_image.png"),
//                           radius: 24,
//                         ),
//                         SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 device["ownerName"] ?? "Device Owner",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Icon(Icons.star, color: Colors.amber, size: 16),
//                                   SizedBox(width: 4),
//                                   Text(
//                                     "${device["ownerRating"] ?? 4.5}",
//                                     style: TextStyle(color: Colors.white70),
//                                   ),
//                                   SizedBox(width: 8),
//                                   Text(
//                                     "${device["ownerLocation"] ?? 'Location'}",
//                                     style: TextStyle(color: Colors.white70),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         // IconButton(
//                         //   icon: Icon(Icons.message, color: Colors.white),
//                         //   onPressed: () {},
//                         // ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Device description
//                   Text(
//                     "Description",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     device["description"] ?? "No description available.",
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                       height: 1.5,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // c. Feedback section
//                   Text(
//                     "Feedback",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   // Review summary
//                   Row(
//                     children: [
//                       Text(
//                         "${device["rating"] ?? 4.8}",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 36,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: List.generate(5, (index) {
//                                 return Icon(
//                                   index < (device["rating"] ?? 4).floor()
//                                       ? Icons.star
//                                       : Icons.star_border,
//                                   color: Colors.amber,
//                                   size: 20,
//                                 );
//                               }),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               "${device["reviewCount"] ?? 24} reviews",
//                               style: TextStyle(color: Colors.white70),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   // Review list (sample)
//                   if ((device["reviews"] as List?)?.isNotEmpty ?? false)
//                     ...List.generate(
//                       (device["reviews"] as List).length > 2 ? 2 : (device["reviews"] as List).length,
//                           (index) => _buildReviewItem(device["reviews"][index]),
//                     )
//                   else
//                     _buildSampleReview(),
//
//                   TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       "See all reviews",
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                   SizedBox(height: 100), // Space for bottom button
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       // d. Rent now button
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.black,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 8,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: ElevatedButton(
//           onPressed: () {
//             _showDepositDialog(context);
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.purple,
//             padding: EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child: Text(
//             "Rent Now",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildReviewItem(Map<String, dynamic> review) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade900,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage(review["userImage"] ?? "assets/images/default_avatar.png"),
//                 radius: 16,
//               ),
//               SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     review["userName"] ?? "User",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: List.generate(5, (index) {
//                       return Icon(
//                         index < (review["rating"] ?? 5).floor()
//                             ? Icons.star
//                             : Icons.star_border,
//                         color: Colors.amber,
//                         size: 14,
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Text(
//                 review["date"] ?? "2 days ago",
//                 style: TextStyle(color: Colors.white60, fontSize: 12),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(
//             review["comment"] ?? "Great device, would recommend!",
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSampleReview() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade900,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.blueGrey,
//                 child: Text("JD", style: TextStyle(color: Colors.white)),
//                 radius: 16,
//               ),
//               SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "John Doe",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: List.generate(5, (index) {
//                       return Icon(
//                         index < 5 ? Icons.star : Icons.star_border,
//                         color: Colors.amber,
//                         size: 14,
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//               Spacer(),
//               Text(
//                 "3 days ago",
//                 style: TextStyle(color: Colors.white60, fontSize: 12),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Text(
//             "This device worked perfectly for my project. Great condition and the owner was very helpful with setup.",
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// void _showDepositDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Colors.grey[900],
//         title: Text(
//           "Deposit Required",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "You need to pay the deposit amount to proceed with the rental.",
//               style: TextStyle(color: Colors.white70),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Deposit Amount: ₹${(device["price"] * 2).toInt()}",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               "(Equivalent to 2 days rental)",
//               style: TextStyle(color: Colors.white70, fontSize: 12),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             child: Text(
//               "Cancel",
//               style: TextStyle(color: Colors.white70),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.purple,
//             ),
//             child: Text("Proceed to Pay"),
//             onPressed: () {
//               Navigator.of(context).pop();
//               _showPaymentGateway(context);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
// void _showPaymentGateway(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => Container(
//       height: MediaQuery.of(context).size.height * 0.75,
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: PaymentGatewayWidget(
//         amount: (device["price"] * 2).toInt(),
//         onPaymentComplete: () {
//           _showBookingConfirmation(context);
//         },
//       ),
//     ),
//   );
// }
//
// void _showBookingConfirmation(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Colors.grey[900],
//         title: Column(
//           children: [
//             Icon(
//               Icons.check_circle,
//               color: Colors.green,
//               size: 60,
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Booking Confirmed!",
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               "Your booking for ${device["name"]} has been confirmed.",
//               style: TextStyle(color: Colors.white70),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Order ID: RX${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10)}",
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//         actions: [
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.purple,
//               minimumSize: Size(double.infinity, 45),
//             ),
//             child: Text("OK"),
//             onPressed: () {
//               Navigator.of(context).pop();
//               Navigator.of(context).pop(); // Go back to home screen
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
import 'package:flutter/material.dart';
import 'package:rentronix/widget/payment_gateway_widget.dart';

class DeviceDetailScreen extends StatelessWidget {
  final Map<String, dynamic> device;
  const DeviceDetailScreen({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(device["image"]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite_border, color: Colors.white),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.share, color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
          ),
          // Device Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Device Name and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          device["name"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // a. Price
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "\Rs.${device["price"]}/day",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // b. Owner details
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(device["ownerImage"] ?? "assets/images/profile_image.png"),
                          radius: 24,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                device["ownerName"] ?? "Device Owner",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    "${device["ownerRating"] ?? 4.5}",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "${device["ownerLocation"] ?? 'Location'}",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.message, color: Colors.white),
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Device description
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    device["description"] ?? "No description available.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  // c. Feedback section
                  Text(
                    "Feedback",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  // Review summary
                  Row(
                    children: [
                      Text(
                        "${device["rating"] ?? 4.8}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < (device["rating"] ?? 4).floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20,
                                );
                              }),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${device["reviewCount"] ?? 24} reviews",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Review list (sample)
                  if ((device["reviews"] as List?)?.isNotEmpty ?? false)
                    ...List.generate(
                      (device["reviews"] as List).length > 2 ? 2 : (device["reviews"] as List).length,
                          (index) => _buildReviewItem(device["reviews"][index]),
                    )
                  else
                    _buildSampleReview(),

                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See all reviews",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      // d. Rent now button
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            _showDepositDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "Rent Now",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(review["userImage"] ?? "assets/images/default_avatar.png"),
                radius: 16,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review["userName"] ?? "User",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < (review["rating"] ?? 5).floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 14,
                      );
                    }),
                  ),
                ],
              ),
              Spacer(),
              Text(
                review["date"] ?? "2 days ago",
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            review["comment"] ?? "Great device, would recommend!",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleReview() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text("JD", style: TextStyle(color: Colors.white)),
                radius: 16,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "John Doe",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < 5 ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 14,
                      );
                    }),
                  ),
                ],
              ),
              Spacer(),
              Text(
                "3 days ago",
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "This device worked perfectly for my project. Great condition and the owner was very helpful with setup.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Move these methods inside the class
  void _showDepositDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            "Deposit Required",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "You need to pay the deposit amount to proceed with the rental.",
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 10),
              Text(
                "Deposit Amount: ₹${(device["price"] * 2).toInt()}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "(Equivalent to 2 days rental)",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white70),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: Text("Proceed to Pay"),
              onPressed: () {
                Navigator.of(context).pop();
                _showPaymentGateway(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showPaymentGateway(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: PaymentGatewayWidget(
          amount: (device["price"] * 2).toInt(),
          onPaymentComplete: () {
            _showBookingConfirmation(context);
          },
        ),
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              SizedBox(height: 10),
              Text(
                "Booking Confirmed!",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your booking for ${device["name"]} has been confirmed.",
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Order ID: RX${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10)}",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 45),
              ),
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to home screen
              },
            ),
          ],
        );
      },
    );
  }
}