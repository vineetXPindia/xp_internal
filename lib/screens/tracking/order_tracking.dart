import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:xp_internal/constants/colors.dart';

class OrderTracking extends StatefulWidget {
  const OrderTracking({super.key});

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  late GoogleMapController _mapController;
  static const LatLng _initialPos = LatLng(37.7749, -122.4194);
  final Set<Marker> _marker = {
    Marker(
        markerId: MarkerId('initialMarker'),
        position: _initialPos,
        infoWindow: InfoWindow(
          title: 'Order Location',
          snippet: 'This is the initial location of order',
        ))
  };
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: newCardBG,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Track Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            height: screenHeight * 0.1,
            decoration: BoxDecoration(
              color: newCardBG,
            ),
            child: TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search by order id/vehicle no. or xpcn',
                hintStyle: TextStyle(
                    color: Colors.black26, fontSize: screenWidth * 0.04),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.06),
                ),
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _initialPos,
                zoom: 12.0,
              ),
              markers: _marker,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
            ),
          )
        ],
      ),
    );
  }
}

//////////////////////////////////
