import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:horse_management/Utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'currencies_json.dart';


class add_currency extends StatefulWidget{
  final token;

  add_currency(this.token);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _add_currency(token);
  }
}



class _add_currency extends State<add_currency>{
  final token;
  _add_currency(this.token);
  String selected_currency;
  int selected_currency_id=0;

  List<String> currency=[];
  var currency_response;
 
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    Utils.check_connectivity().then((result){
      if(result){
        CurrenciesServices.getCurrencyDropdown(token).then((response){
          if(response!=null){
            print(response);
            setState(() {
              currency_response=json.decode(response);
              for(int i=0;i<currency_response['currencySymbolsDropDown'].length;i++)
                currency.add(currency_response['currencySymbolsDropDown'][i]['name']);

             // stocks_loaded=true;
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
        appBar: AppBar(title: Text("Add Currency"),),
        body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16, top:16),
                          child: Visibility(
                            //visible: stocks_loaded,
                            child: FormBuilderDropdown(
                              attribute: "Currency",
                              validators: [FormBuilderValidators.required()],
                              hint: Text("Currency"),
                              items:currency!=null?currency.map((horse)=>DropdownMenuItem(
                                child: Text(horse),
                                value: horse,
                              )).toList():[""].map((name) => DropdownMenuItem(
                                  value: name, child: Text("$name")))
                                  .toList(),
                              style: Theme.of(context).textTheme.body1,
                              decoration: InputDecoration(labelText: "Currency",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: Colors.teal, width: 1.0)
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  this.selected_currency=value;
                                  this.selected_currency_id=currency.indexOf(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                      child:Padding(
                          padding: const EdgeInsets.all(16),
                          child:MaterialButton(
                            color: Colors.teal,
                            child: Text("Save",style: TextStyle(color: Colors.white),),

                            onPressed: (){
                              if (_fbKey.currentState.validate()) {
                                Utils.check_connectivity().then((result){
                                  if(result){
                                    ProgressDialog pd= ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                    pd.show();
                                    CurrenciesServices.addCurrency(token, 0,selected_currency, null)
                                        .then((respons){
                                      pd.dismiss();
                                      setState(() {
                                        var parsedjson  = jsonDecode(respons);
                                        if(parsedjson != null){
                                          if(parsedjson['isSuccess'] == true){
                                            print("Successfully data updated");
                                          }else
                                            print("not saved");
                                        }else
                                          print("json response null");
                                      });
                                    });
                                  }
                                });
                              }
                            },
                          )
                      )
                  )
                ],
              )
            ]
        )
    );
  }

}

