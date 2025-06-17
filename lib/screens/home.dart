import 'package:flugs_app/screens/country.dart';
import 'package:flugs_app/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chip_list/chip_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _regions = [
    'Africa',
    'Asia',
    'Europe',
    'Oceania',
    'Americas',
  ];
  int _selectedRegionIndex = 0;

  final apiRegion = ApiRegion();
  // late final Future<List<dynamic>> countries;

  List<dynamic>? _countries;

  Future<void> _loadcountries() async {
    final data = await apiRegion.fetchCountries(_regions[_selectedRegionIndex]);
    setState(() {
      _countries = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadcountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text(
          'Word Explorer',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.blue),
            tooltip: 'Search',
            onPressed: () {},
          ),
        ],
        leading: Icon(Icons.public, color: Colors.blue),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20.h,
            children: [
              Text(
                'Explore Countries',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              // Chip List
              ChipList(
                listOfChipNames: _regions,
                listOfChipIndicesCurrentlySelected: [_selectedRegionIndex],
                inactiveBorderColorList: [Colors.blue],
                activeBgColorList: [Colors.blue],
                showCheckmark: false,
                extraOnToggle: (index) {
                  setState(() {
                    _selectedRegionIndex = index;
                    _loadcountries();
                  });
                },
              ),
              _countries == null
                  ? CircularProgressIndicator(
                    backgroundColor: Colors.green[200],
                  )
                  :
                  // Text(
                  //   'Countries in Africa: ${_countries!.length}',
                  //   style: TextStyle(fontSize: 14.sp),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _countries!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.r),
                          ),
                          child: ListTile(
                            leading: Image.network(
                              _countries![index]['flags']['png'] ?? '',
                              width: 50.w,
                            ),
                            title: Text(
                              _countries![index]['name']['common'] ??
                                  'Unknown Country',
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_countries![index]['subregion'] ?? 'N/A'} . ${_countries![index]['capital']?.join(', ') ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Population: ${_countries![index]['population'] ?? 'N/A'}',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            // style: ListTileStyle.drawer,
                            onTap:
                                () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => CountryScreen(
                                          country: _countries![index],
                                        ),
                                  ),
                                ),
                          ),
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
