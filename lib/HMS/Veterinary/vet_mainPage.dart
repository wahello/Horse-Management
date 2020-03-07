import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/health_record_form.dart';

import 'Confirmation/confirmation.dart';
import 'Vet Visits/vet_visit.dart';



class vet_category extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State();
  }

}
class _Profile_Page_State extends State<vet_category>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Veterinary"),
//          actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.arrow_right,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => add_newHorse()),
//              );
//            },
//          )
//        ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text("Confirmation"),
                    subtitle: Text("Add Confirmation"),
                    leading: Icon(Icons.account_balance_wallet,size: 40,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>confirmartion()));
                    },
                  ),
                  ListTile(
                    title: Text("Vet Visit"),
                    subtitle: Text("Add Vet Visit"),
                    leading: Icon(Icons.speaker_notes,size: 40,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>vet_visit()));
                    },
                  ),

                ],
              ),
            ),
          ],
        )
    );
  }

}