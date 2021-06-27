import 'dart:io';
import './vaccine.dart';

File childImage = new File('assets/child.jpg');

class customMaps {
  DateTime date;
  List<dynamic> arr;
  customMaps(DateTime date, List<dynamic> arr) {
    this.date = date;
    this.arr = arr;
  }
  Map<String, dynamic> toJson() => {
        'date': date,
        'arr': arr,
      };
}

class Child {
  File photo;
  String name;
  DateTime dob;
  int gender; // 0 for boy , 1 for girl
  List<Vaccine> vaccines_to_be_reminded = [];
  List<Vaccine> vaccines_date_gone = [];
  Map<DateTime, List<dynamic>> events = {};
  Map<DateTime, List<dynamic>> nextDue = {};

  Child(String name, DateTime dob, int gender, File image) {
    this.dob = dob;
    this.gender = gender;
    print(image==null);
    this.photo = image != null?image :childImage;
    this.name = name;
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> arr = [];
    events.forEach((k, v) {
      customMaps obj = customMaps(k, v);
      arr.add(obj.toJson());
    });

    return {
      "dob": dob,
      "gender": gender,
      'name': name,
      'events': arr,
    };
  }


  Map<DateTime, List<dynamic>> getEventsfromdatabase(List<dynamic> arr ){
    if(arr==null || arr == [])
      return {};
    Map<DateTime, List<dynamic>> events = {} ;
    for(int it = 0;it<arr.length;it++){
      var time = arr[it]['date'];
      var dob = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
      // print(dob);
      events[dob] = arr[it]['arr'];
    }
    return events ;
  }


  void makeEvents(List<Vaccine> vaccines_to_be_reminded) {
    for (int i = 0; i < vaccines_to_be_reminded.length; i++) {
      for (int j = 0; j < vaccines_to_be_reminded[i].doses.length; j++) {
        if (this.events[this.dob.add(Duration(
                days: vaccines_to_be_reminded[i].doses[j].week * 7))] ==
            null)
          this.events[this.dob.add(
              Duration(days: vaccines_to_be_reminded[i].doses[j].week * 7))] = [
            vaccines_to_be_reminded[i].code +
                " - Dose " +
                "${vaccines_to_be_reminded[i].doses[j].position}"
          ];
        else {
          this
              .events[this.dob.add(
                  Duration(days: vaccines_to_be_reminded[i].doses[j].week * 7))]
              .add(vaccines_to_be_reminded[i].code +
                  " - Dose " +
                  "${vaccines_to_be_reminded[i].doses[j].position}");
        }
      }
    }
  }

  void getNextDueVaccines() {
    List sortedKeys = this.events.keys.toList()
      ..sort((a, b) {
        return (a.compareTo(b));
      });
    DateTime nearest = sortedKeys[0];
    // print('Nearest'+nearest.toString());
    for (var key in events.keys) {
      if (key == nearest) {
        this.nextDue = {nearest: events[nearest]};
        print(nextDue);
      }
    }
  }
}
