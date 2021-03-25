import 'dart:io';
import './vaccine.dart';

class Child {
  File photo;
  String name;
  DateTime dob;
  int gender; // 0 for boy , 1 for girl
  List <Vaccine> vaccines_to_be_reminded = [];
  List <Vaccine> vaccines_date_gone = [];
  Map<DateTime, List<dynamic>> events = {};
  Map<DateTime, List<dynamic>> nextDue;

  Child(File image, String name, DateTime dob, int gender) {
    this.dob = dob;
    this.gender = gender;
    this.photo = image;
    this.name = name;
  }
  void makeEvents( List <Vaccine> vaccines_to_be_reminded){
    for(int i = 0 ; i < vaccines_to_be_reminded.length;i++){
      for(int j = 0 ; j < vaccines_to_be_reminded[i].doses.length;j++){
        if(this.events[this.dob.add( Duration(days:vaccines_to_be_reminded[i].doses[j].week*7 ))]==null)
        this.events[this.dob.add( Duration(days:vaccines_to_be_reminded[i].doses[j].week*7 ))] = [vaccines_to_be_reminded[i].code + " - Dose "+ "${vaccines_to_be_reminded[i].doses[j].position}" ] ;
        else {
          this.events[this.dob.add( Duration(days:vaccines_to_be_reminded[i].doses[j].week*7 ))].add(vaccines_to_be_reminded[i].code + " - Dose "+ "${vaccines_to_be_reminded[i].doses[j].position}");
        }
      }
    }
  }
  void getNextDueVaccines(){
   List sortedKeys = this.events.keys.toList()..sort((a,b){
     return(a.compareTo(b));
   });
   DateTime nearest = sortedKeys[0];
   for(var key in events.keys){
     if(key==nearest){
       this.nextDue = {nearest:events[nearest]} ;
       print(nextDue);
     }
   }
 }

}
