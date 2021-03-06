import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Breeding/Semen_Collection/semen_collection_details.dart';
import 'package:horse_management/HMS/Breeding/Semen_Collection/update_semen_collection.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/HMS/Training/update_training.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:horse_management/animations/fadeAnimation.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../Utils.dart';
import 'add_semen_collection.dart';

class semen_collection_list extends StatefulWidget{
  String token;

  semen_collection_list(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _semen_collection_list_state(token);
  }

}
class _semen_collection_list_state extends State<semen_collection_list>{
  String token;
  var horse_list;
  var siemen_col_list=[];
  var temp=['',''];
  bool isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Semen Collections")),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>add_semen_collection(token)));
          },
        ),
        body: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: (){
                return  Utils.check_connectivity().then((result){
                  if(result){
                    ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                    pd.show();
                    network_operations.get_all_semen_collection(token).then((response){
                      pd.dismiss();
                      if(response!=null){
                        setState(() {
                          isvisible=true;
                          siemen_col_list=json.decode(response);
                          // print('Training list Length'+training_list.length.toString());
                        });

                      }else{
                        Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Semen Collection List Not Found"),
                        ));
                        setState(() {
                          isvisible=false;
                        });
                      }
                    });
                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Network not Available"),
                    ));
                  }
                });
              },
              child: Visibility(
                visible: isvisible,
                child: ListView.builder(itemCount:siemen_col_list!=null?siemen_col_list.length:temp.length,itemBuilder: (context,int index){
                  return Column(
                    children: <Widget>[
                      Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.20,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            icon: Icons.edit,
                            color: Colors.blue,
                            caption: 'Update',
                            onTap: () async {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>update_semen_collection(token,siemen_col_list[index])));
                            },
                          ),
                        ],
                        actions: <Widget>[
                          IconSlideAction(
                            icon: Icons.visibility_off,
                            color: Colors.red,
                            caption: 'Hide',
                            onTap: () async {
                              network_operations.change_semen_collection_visibility(token, siemen_col_list[index]['semenCollectionId']).then((response){
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.green ,
                                    content: Text('Visibility Changed'),
                                  ));
                                  setState(() {
                                    siemen_col_list.removeAt(index);
                                  });

                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor:Colors.red ,
                                    content: Text('Failed'),
                                  ));
                                }
                              });
                            },
                          ),
                        ],
                        child: FadeAnimation(2.0,
                        ListTile(
                            title: Text(siemen_col_list!=null?siemen_col_list[index]['horseName']['name']:''),
                            trailing: Text(siemen_col_list!=null?siemen_col_list[index]['date'].toString().replaceAll("T00:00:00",''):''),
                            //subtitle: Text(training_list!=null?get_training_type_by_id(training_list[index]['trainingType']):''),
                            leading: Image.asset("assets/horse_icon.png"),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => semen_collection_details_page(siemen_col_list[index])));

                            },
                          ),
                        ),


                      ),
                      Divider(),
                    ],

                  );

                }),
              ),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }
  _semen_collection_list_state(this.token);
}