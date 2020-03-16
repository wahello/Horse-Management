import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Utils.dart';




class PaddockServices{

  static Future<String> addPaddock(String token,int paddockId, String paddockName, String mainUse, int locationId, String area, bool hasShade, bool hasWater, bool grass, bool otherAnimals, String comments, String createdBy) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token,'Content-Type':'application/json'};
    final body = jsonEncode({"Id":paddockId,"Name":paddockName,"createdBy":createdBy,"createdOn":DateTime.now(), "mainUse":mainUse, "locationId":locationId, "area":area, "hasShade":hasShade, "hasWater":hasWater, "grass":grass, "otherAnimals":otherAnimals, "comments":comments, "isActive":true},toEncodable: Utils.myEncode);
    var response= await http.post("http://192.236.147.77:8083/api/Paddock/PaddockSave",headers: headers,body: body);
    print(response.body);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> getPaddock(String token) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Paddock/GetAllPaddocks', headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
  static Future<String> changePaddockVisibility(String token,int barnId) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Paddock/PaddockVisibility/'+barnId.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }
}