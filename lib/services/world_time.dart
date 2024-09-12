import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; // location name for the UI
  late String url; //location url for api endpoint
  late String time; // the time in that location
  late String flag; // url to an asset flag icon
  late bool isDaytime; // true or false if daytime or not

  WorldTime(this.location, this.flag, this.url);

  Future<void> getTime() async {
    try {
      //make the request
      Uri apiUri = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      http.Response response = await http.get(apiUri);
      Map data = jsonDecode(response.body);
      // print(data['utc_offset']);
      // print(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      // print(datetime);
      // print(offset);

      if (offset.length >= 3) {
        // Default to hours only
        int offsetHours = int.parse(offset.substring(1, 3));
        int offsetMinutes = 0;

        // If offset has minutes, parse them
        if (offset.length >= 6) {
          offsetMinutes = int.parse(offset.substring(4, 6));
        }

        // Create a DateTime object and add/subtract the offset
        DateTime now = DateTime.parse(datetime);
        Duration offsetDuration = Duration(hours: offsetHours, minutes: offsetMinutes);
        if (offset.startsWith('-')) {
          now = now.subtract(offsetDuration);
        } else {
          now = now.add(offsetDuration);
        }

        isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
        time = DateFormat.jm().format(now);

        // print('Current Time: $now');
      } else {
        print('Invalid offset format: $offset');
      }
    } catch (e) {
      time = 'There is some error in the API Request \n error is $e';
      print('Error is $e');
    }
  }
}

