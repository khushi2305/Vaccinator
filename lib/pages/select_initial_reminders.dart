// import 'package:flutter/material.dart';
// import 'package:vaccinator_two/pages/home.dart';
// import '../data/allVaccines.dart';
// import '../data/vaccine.dart';
// //import 'package:google_fonts/google_fonts.dart';
// import 'package:vaccinator_two/data/child.dart' ;
//
//
//
// class Select_Initial_Reminders extends StatefulWidget {
//   final Child child;
//   const Select_Initial_Reminders(
//       {Key key, this.child})
//       : super(key: key);
//
//   @override
//   _Select_Initial_RemindersState createState() =>
//       _Select_Initial_RemindersState();
// }
//
// class _Select_Initial_RemindersState extends State<Select_Initial_Reminders> {
//
//   @override
//   void initState() {
//     super.initState();
//     for(int index=0 ; index<AllVaccines.allVaccines.length;index++){
//       List <Dose> given = [];
//       List <Dose> toBeGiven = [] ;
//       Vaccine curr_vaccine = AllVaccines.allVaccines[index];
//       for (var dose in curr_vaccine.doses){
//         if(DateTime.now().isAfter(widget.child.dob.add( Duration(days: dose.week*7 ))) ) {
//           given.add(dose);
//         }
//         if(DateTime.now().isBefore(widget.child.dob.add( Duration(days: dose.week*7 ))) ) {
//           toBeGiven.add(dose);
//         }
//       }
//       widget.child.vaccines_date_gone.add(Vaccine(curr_vaccine.name, curr_vaccine.code, curr_vaccine.description,given, curr_vaccine.price));
//       widget.child.vaccines_to_be_reminded.add(Vaccine(curr_vaccine.name, curr_vaccine.code, curr_vaccine.description,toBeGiven, curr_vaccine.price));
//     }
//   }
//   Widget build(BuildContext context) {
//      Map childData = ModalRoute.of(context).settings.arguments;
//
//
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//           child:Text('Done'),
//           onPressed:(){
//             widget.child.makeEvents(widget.child.vaccines_to_be_reminded);
//             Navigator.pop(context);
//             Navigator.pop(context);
//             Navigator.pushReplacementNamed(context, '/home', arguments: {
//               'addedChild': widget.child,
//             });
//           }),
//       body: SingleChildScrollView(
//         physics: ScrollPhysics(),
//         child: Column(
//            //MainAxis columnMainAxisSize.min
//           children: [
//             Container(
//              margin:  EdgeInsets.only(top:50.0),
//               child: Text('List Of Vaccines',
//                    style: // GoogleFonts.lato(
//                   //   textStyle:
//                     TextStyle(
//                       color: Colors.cyan[900],
//                       fontSize: 30.0,
//                       fontWeight: FontWeight.bold,
//                   //  ),
//                   )),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.lightBlue[100],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               padding: const EdgeInsets.only(left:20,top:19.0,bottom: 10),
//               margin : EdgeInsets.only(top: 30,left: 10,right:10),
//               child: Text("List of vaccines the child must have taken till now. In case not, CONTACT YOUR DOCTOR . ",
//                   style:TextStyle(
//                     fontWeight: FontWeight.bold,
//                   )),
//             ),
//             new ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: widget.child.vaccines_date_gone.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Column( //shrinkWrap: true,
//                     // children:  AllVaccines.allVaccines[index].doses.map((item) => new Text(item)).toList()
//                     // for (var dose in AllVaccines.allVaccines[index].doses) Text(item),
//                     children:<Widget>[
//                       for (var dose in widget.child.vaccines_date_gone[index].doses)
//                       new Card(
//                         child: new Container(
//                             padding: new EdgeInsets.all(10.0),
//                             child: new CheckboxListTile(
//                                 activeColor: Colors.green[500],
//                                 dense: true,
//                                 //font change
//                                 title: new Text(
//                                   widget.child.vaccines_date_gone[index].name +  " Dose "  + "${dose.position}" ,
//                                   style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       letterSpacing: 0.5),
//                                 ),
//                                 value: false ,
//                                 subtitle: Text( (() {
//                                   // your code here
//                                   if(dose.isNormal)
//                                     return widget.child.vaccines_date_gone[index].code;
//                                   else
//                                     return  widget.child.vaccines_date_gone[index].code + "\n" + "This dose is only for specific groups ";
//                                 }())
//                                 ),
//                                 onChanged: (bool val) {
//                                   setState(() {
//                                     dose.setReminder = val;
//                                   });
//                                 })),
//                       ),
//                     ],
//
//                   );
//                 }),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.lightBlue[100],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               padding: const EdgeInsets.only(left:20,top:19.0,bottom: 10),
//               margin : EdgeInsets.only(top: 30,left: 10,right:10),
//               child: Text("Reminders for the following vaccines are set. Change reminders as per prescribed by your doctor . ",
//               style:TextStyle(
//                 fontWeight: FontWeight.bold,
//               )),
//             ),
//             new ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: widget.child.vaccines_to_be_reminded.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Column( //shrinkWrap: true,
//                     children:<Widget>[
//                       for (var dose in widget.child.vaccines_to_be_reminded[index].doses)
//                         new Card(
//                           child: new Container(
//                               padding: new EdgeInsets.all(10.0),
//                               child: new CheckboxListTile(
//                                   activeColor: Colors.green[500],
//                                   dense: true,
//                                   //font change
//                                   title: new Text(
//                                     widget.child.vaccines_to_be_reminded[index].name +  " Dose "  + "${dose.position}" ,
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                         letterSpacing: 0.5),
//                                   ),
//                                   value: dose.setReminder,
//                                   onChanged: (bool val) {
//                                     setState(() {
//                                       dose.setReminder = val;
//                                     });
//                                   },
//
//                                 subtitle: Text( (() {
//                                   // your code here
//                                   if(dose.isNormal)
//                                    return  widget.child.vaccines_to_be_reminded[index].code;
//                                   else
//                                    return  widget.child.vaccines_to_be_reminded[index].code + "\n" + "This dose is only for specific groups ";
//                                 }())
//                                   )
//                               ),
//                            ),
//                         ),
//                     ],
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:vaccinator_two/pages/home.dart';
import '../data/allVaccines.dart';
import '../data/vaccine.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:vaccinator_two/data/child.dart';

class Select_Initial_Reminders extends StatefulWidget {
  final Child child;
  const Select_Initial_Reminders({Key key, this.child}) : super(key: key);

  @override
  _Select_Initial_RemindersState createState() =>
      _Select_Initial_RemindersState();
}

class _Select_Initial_RemindersState extends State<Select_Initial_Reminders> {
  @override
  void initState() {
    super.initState();
    for (int index = 0; index < AllVaccines.allVaccines.length; index++) {
      List<Dose> given = [];
      List<Dose> toBeGiven = [];
      Vaccine curr_vaccine = AllVaccines.allVaccines[index];
      for (var dose in curr_vaccine.doses) {
        if (DateTime.now()
            .isAfter(widget.child.dob.add(Duration(days: dose.week * 7)))) {
          given.add(dose);
        }
        if (DateTime.now()
            .isBefore(widget.child.dob.add(Duration(days: dose.week * 7)))) {
          toBeGiven.add(dose);
        }
      }
      widget.child.vaccines_date_gone.add(Vaccine(
          curr_vaccine.name,
          curr_vaccine.code,
          curr_vaccine.description,
          given,
          curr_vaccine.price));
      widget.child.vaccines_to_be_reminded.add(Vaccine(
          curr_vaccine.name,
          curr_vaccine.code,
          curr_vaccine.description,
          toBeGiven,
          curr_vaccine.price));
    }
  }

  Widget build(BuildContext context) {
    Map childData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Text('Done'),
          onPressed: () {
            widget.child.makeEvents(widget.child.vaccines_to_be_reminded);
            // Navigator.pop(context);
            //Navigator.pop(context);
            Navigator.pop(
              context,
              widget.child,
            );
          }),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          //MainAxis columnMainAxisSize.min
          children: [
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Text('List Of Vaccines',
                  style: // GoogleFonts.lato(
                      //   textStyle:
                      TextStyle(
                    color: Colors.cyan[900],
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    //  ),
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 20, top: 19.0, bottom: 10),
              margin: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Text(
                  "List of vaccines the child must have taken till now. In case not, CONTACT YOUR DOCTOR . ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            new ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.child.vaccines_date_gone.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    //shrinkWrap: true,
                    // children:  AllVaccines.allVaccines[index].doses.map((item) => new Text(item)).toList()
                    // for (var dose in AllVaccines.allVaccines[index].doses) Text(item),
                    children: <Widget>[
                      for (var dose
                          in widget.child.vaccines_date_gone[index].doses)
                        new Card(
                          child: new Container(
                              padding: new EdgeInsets.all(10.0),
                              child: new CheckboxListTile(
                                  activeColor: Colors.green[500],
                                  dense: true,
                                  //font change
                                  title: new Text(
                                    widget.child.vaccines_date_gone[index]
                                            .name +
                                        " Dose " +
                                        "${dose.position}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5),
                                  ),
                                  value: false,
                                  subtitle: Text((() {
                                    // your code here
                                    if (dose.isNormal)
                                      return widget
                                          .child.vaccines_date_gone[index].code;
                                    else
                                      return widget.child
                                              .vaccines_date_gone[index].code +
                                          "\n" +
                                          "This dose is only for specific groups ";
                                  }())),
                                  onChanged: (bool val) {
                                    setState(() {
                                      dose.setReminder = val;
                                    });
                                  })),
                        ),
                    ],
                  );
                }),
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 20, top: 19.0, bottom: 10),
              margin: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Text(
                  "Reminders for the following vaccines are set. Change reminders as per prescribed by your doctor . ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            new ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.child.vaccines_to_be_reminded.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    //shrinkWrap: true,
                    children: <Widget>[
                      for (var dose
                          in widget.child.vaccines_to_be_reminded[index].doses)
                        new Card(
                          child: new Container(
                            padding: new EdgeInsets.all(10.0),
                            child: new CheckboxListTile(
                                activeColor: Colors.green[500],
                                dense: true,
                                //font change
                                title: new Text(
                                  widget.child.vaccines_to_be_reminded[index]
                                          .name +
                                      " Dose " +
                                      "${dose.position}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5),
                                ),
                                value: dose.setReminder,
                                onChanged: (bool val) {
                                  setState(() {
                                    dose.setReminder = val;
                                  });
                                },
                                subtitle: Text((() {
                                  // your code here
                                  if (dose.isNormal)
                                    return widget.child
                                        .vaccines_to_be_reminded[index].code;
                                  else
                                    return widget
                                            .child
                                            .vaccines_to_be_reminded[index]
                                            .code +
                                        "\n" +
                                        "This dose is only for specific groups ";
                                }()))),
                          ),
                        ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
