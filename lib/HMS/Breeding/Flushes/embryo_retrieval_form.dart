import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import  'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/HMS/Training/update_training.dart';
import 'package:horse_management/Network_Operations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/HMS/my_horses/services/add_horse_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:horse_management/HMS/Training/training_detail_page.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils.dart';
import 'utils/flushes_services_json.dart';


class add_flushes extends StatefulWidget{
  final token;
  add_flushes(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_flushes(token);
  }

}
class _add_flushes extends State<add_flushes>{
  final token;
  _add_flushes(this.token,);
  String ddvalue,selected_horse, selected_vet, selected_success;
  DateTime Select_date = DateTime.now();
  int selected_horse_id=0, selected_vet_id=0;
  bool selected_success_id;
  List<String> horse_name =[], vet=[], success=['Yes', 'No'];
  var flushes_response;
  TextEditingController embryos,comments;

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  bool flushes_loaded=false;
  bool update_flushes_visibility;

  @override
  void initState() {
    this.embryos=TextEditingController();
    this.comments=TextEditingController();
    // local_db=sqlite_helper();
    Utils.check_connectivity().then((result){
      if(result){
        FlushesServicesJson.flushesdropdowns(token).then((response){
          if(response!=null){
            print(response);
            setState(() {
              flushes_response=json.decode(response);
              for(int i=0;i<flushes_response['horseDropDown'].length;i++)
                horse_name.add(flushes_response['horseDropDown'][i]['name']);
              for(int i=0;i<flushes_response['vetDropDown'].length;i++)
                vet.add(flushes_response['vetDropDown'][i]['name']);
              flushes_loaded=true;
              update_flushes_visibility=true;
            });
          }
        });
      }else{
        print("Network Not Available");
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Embryo Retrieval Form"),),
        body:  Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    initialValue: {
                      'date': DateTime.now(),
                      'accept_terms': false,
                    },
                    autovalidate: true,
                    child: Column(children: <Widget>[
//
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: Visibility(
                          visible: flushes_loaded,
                          child: FormBuilderDropdown(
                            attribute: "Horse",
                            validators: [FormBuilderValidators.required()],
                            hint: Text("Horse"),
                            items:horse_name!=null?horse_name.map((horse)=>DropdownMenuItem(
                              child: Text(horse),
                              value: horse,
                            )).toList():[""].map((name) => DropdownMenuItem(
                                value: name, child: Text("$name")))
                                .toList(),
                            style: Theme.of(context).textTheme.body1,
                            decoration: InputDecoration(labelText: "Horse",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                this.selected_horse=value;
                                this.selected_horse_id=horse_name.indexOf(value);
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                        child:  FormBuilderDateTimePicker(
                          onChanged: (value){
                            this.Select_date=value;
                          },
                          attribute: "date",
                          style: Theme.of(context).textTheme.body1,
                          inputType: InputType.date,
                          validators: [FormBuilderValidators.required()],
                          format: DateFormat("dd-MM-yyyy"),
                          decoration: InputDecoration(labelText: "Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Vet",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Vet"),
                          items: vet!=null?vet.map((trainer)=>DropdownMenuItem(
                            child: Text(trainer),
                            value: trainer,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Vet",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              this.selected_vet=value;
                              this.selected_vet_id=vet.indexOf(value);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderDropdown(
                          attribute: "Success?",
                          validators: [FormBuilderValidators.required()],
                          hint: Text("Success?"),
                          items: success!=null?success.map((trainer)=>DropdownMenuItem(
                            child: Text(trainer),
                            value: trainer,
                          )).toList():[""].map((name) => DropdownMenuItem(
                              value: name, child: Text("$name")))
                              .toList(),
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(labelText: "Success?",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              if(value == "Yes")
                                selected_success_id = true;
                              else if(value == "No")
                                selected_success_id = false;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          keyboardType: TextInputType.number,
                          controller: embryos,
                          attribute: "Embryos",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Embryos",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:16,left: 16,right: 16),
                        child: FormBuilderTextField(
                          //keyboardType: TextInputType.number,
                          controller: comments,
                          attribute: "Comments",
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: "Comments",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                borderSide: BorderSide(color: Colors.teal, width: 1.0)
                            ),
                          ),

                        ),
                      ),
//
                      MaterialButton(
                        onPressed: (){
                          if (_fbKey.currentState.validate()) {
                            FlushesServicesJson.add_flushes(null,token,0,flushes_response['horseDropDown'][selected_horse_id]['id'],Select_date, flushes_response['vetDropDown'][selected_vet_id]['id'],selected_success_id,embryos.text, comments.text ).then((response){
                              setState(() {
                                var parsedjson  = jsonDecode(response);
                                if(parsedjson != null){
                                  if(parsedjson['isSuccess'] == true){
                                    print("Successfully data saved");
                                  }else
                                    print("not saved");
                                }else
                                  print("json response null");
                              });
                            });
                          }
                        },
                        child: Text("Save",style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.teal,
                      ),
                    ],
                    ),
                  ),
                ]
            ),
          ),
        ));

  }

}