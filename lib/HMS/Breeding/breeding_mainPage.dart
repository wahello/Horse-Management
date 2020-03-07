import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'BreedingControl/breeding_control_list.dart';
import 'BreedingSales/breeding_sales.dart';
import 'BreedingServices/breeding_services.dart';

import 'EmbryoStock/embryo_stock_list.dart';
import 'Flushes/flushes_list.dart';
import 'SemenStocks/semen_stocks.dart';
import 'Semen_Collection/semen_collection_list.dart';


class breeding_Category extends StatefulWidget{
  String token;
  breeding_Category(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profile_Page_State(token);
  }
}


class _Profile_Page_State extends State<breeding_Category>{
  String token;
  _Profile_Page_State(this.token);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Breeding"),

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
                    title: Text("Breeding Control"),
                    subtitle: Text("Control services"),
                    leading: Icon(Icons.settings,size: 40,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () async{
                      SharedPreferences prefs= await SharedPreferences.getInstance();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>breeding_control_list(prefs.getString("token"))));
                    },
                  ),
                  ListTile(
                    title: Text("Breeding Services"),
                    subtitle: Text("All services about breeding"),
                    leading: Icon(Icons.build,size: 40, color: Colors.black,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>breeding_services(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Breeding Sale"),
                    subtitle: Text("Sales"),
                    leading: Icon(Icons.attach_money,size: 40, color: Colors.green,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>breeding_sales(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Semen Stock"),
                    subtitle: Text("Add Semen"),
                    leading: Icon(Icons.all_inclusive,size: 40,color: Colors.amberAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      //Navigator.push(context,MaterialPageRoute(builder: (context)=>semen_stocks(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Embryo Stock"),
                    subtitle: Text("Add Embryo"),
                    leading: Icon(Icons.local_florist,size: 40,color: Colors.redAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>embryo_stock_list(token)));
                    },
                  ),
                  ListTile(
                    title: Text("Flushes"),
                    subtitle: Text("Add Flushes"),
                    leading: Icon(Icons.flag,size: 40, color: Colors.lightGreenAccent,),
                    trailing: Icon(Icons.arrow_right),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>flushes_list(token)));
                    },
                  ),
    ListTile(
    title: Text("Semen Collection"),
    subtitle: Text("Semen Collection"),
    leading: Icon(Icons.store,size: 40, color: Colors.blueAccent,),
    trailing: Icon(Icons.arrow_right),
    onTap: (){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>semen_collection_list(token)));
    },
    )
                ],
              ),
            ),
          ],
        )
    );
  }

}