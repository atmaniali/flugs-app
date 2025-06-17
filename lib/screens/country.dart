import 'package:flugs_app/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CountryScreen extends StatefulWidget {
  final dynamic country;
  final double latlngval = 0.0;

  CountryScreen({super.key, required this.country});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<dynamic>? _bordersData;

  List<String> get _borderingCountries =>
      (widget.country?['borders'] as List<dynamic>?)?.cast<String>() ?? [];

  @override
  void initState() {
    super.initState();
    _loadBorderCountries();
  }

  Future<void> _loadBorderCountries() async {
    if (_borderingCountries.isNotEmpty) {
      final loader = LoadMultipleCountries();
      final data = await loader.fetchcountrybordersbyname(_borderingCountries);
      setState(() {
        _bordersData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Country Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 5.h),
          width: double.infinity,
          // height: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              spacing: 20.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.country['name']['common'] ?? 'N/A',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.country['name']['official'] ?? 'N/A',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Spacer(),
                    Image(
                      image: NetworkImage(widget.country['flags']['png'] ?? ''),
                      width: 50.w,
                    ),
                  ],
                ),
                // Basic Information
                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 3.w),
                    borderRadius: BorderRadius.circular(1.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Basic Information:",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GridView.count(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        children: [
                          //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CCA3:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(widget.country['cca3'] ?? 'N/A'),
                            ],
                          ),
                          //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Capital:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(widget.country['capital'][0] ?? 'N/A'),
                            ],
                          ),
                          //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Region:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(widget.country['region'] ?? 'N/A'),
                            ],
                          ),
                          //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Subregion:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(widget.country['subregion'] ?? 'N/A'),
                            ],
                          ),
                          //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Population:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('${widget.country['population']}' ?? 'N/A'),
                            ],
                          ),
                          //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Currency:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${widget.country['currencies'].keys.first} (${widget.country['currencies'][widget.country['currencies'].keys.first]['symbol']})' ??
                                    'N/A',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Location
                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
                  width: double.infinity,
                  height: 300.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 3.w),
                    borderRadius: BorderRadius.circular(1.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 200.h,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              widget.country['latlng'][0].toDouble(),
                              -widget.country['latlng'][1].toDouble(),
                            ),
                            initialZoom: 3.2,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Bordering Countries
                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 3.w),
                    borderRadius: BorderRadius.circular(1.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bordering Countries",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      //
                      if (_borderingCountries.isEmpty)
                        Text('No bordering countries.')
                      else if (_bordersData == null)
                        CircularProgressIndicator()
                      else
                        Wrap(
                          spacing: 8,
                          children:
                              _bordersData!.map<Widget>((country) {
                                return Container(
                                  // margin: EdgeInsets.only(top: 8),
                                  child: Column(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    children: [
                                      Image(
                                        image: NetworkImage(country!['flag']),
                                        width: 100,
                                        height: 100,
                                      ),
                                      Text(
                                        country['name'] ?? 'Unknown',
                                        textAlign: TextAlign.center,
                                      ),
                                      // Chip(
                                      //   label: Text(country['name'] ?? 'Unknown'),
                                      //   avatar:
                                      //       country['flag'] != null
                                      //           ? Image.network(
                                      //             country['flag'],
                                      //             width: 24,
                                      //             height: 24,
                                      //           )
                                      //           : null,
                                      // ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      // SizedBox(height: 20.h),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
