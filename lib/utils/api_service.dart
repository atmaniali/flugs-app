import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiRegion {
  Future<List<dynamic>> fetchCountries(region) async {
    final url = Uri.parse("https://restcountries.com/v3.1/region/$region");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('data $data');
      return data;
    } else {
      throw Exception('Failed to load countries');
    }
  }
}

class ApiAlpha {
  Future<List<dynamic>> fetchCountryByAlphabitName(name) async {
    final url = Uri.parse("https://restcountries.com/v3.1/alpha/$name");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Handle if data is a List or a Map
      if (data is List) {
        return data.map((country) {
          return {
            'name': country['name']['common'],
            'flag': country['flags']['png'],
          };
        }).toList();
      } else if (data is Map) {
        return [
          {'name': data['name']['common'], 'flag': data['flags']['png']},
        ];
      } else {
        throw Exception('Unexpected data format');
      }
    } else {
      throw Exception('Failed to load country');
    }
  }
}

class LoadMultipleCountries {
  Future<List<dynamic>> fetchcountrybordersbyname(
    List<String> listborder,
  ) async {
    final alph = ApiAlpha();
    // Fetch all countries in parallel
    final results = await Future.wait(
      listborder.map((abbr) async {
        final data = await alph.fetchCountryByAlphabitName(abbr);
        // fetchCountryByAlphabitName returns a list, take the first country if available
        return data.isNotEmpty ? data.first : null;
      }),
    );
    // Remove any nulls (in case a country wasn't found)
    return results.where((item) => item != null).toList();
  }
}

// https://restcountries.com/v3.1/region/Africa
