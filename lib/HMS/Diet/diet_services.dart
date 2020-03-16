import 'dart:convert';
import 'dart:io';
import 'package:horse_management/Utils.dart';
import 'package:http/http.dart' as http;


class DietServices {


  static Future<String> newDietList (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/GetAllDiets',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> newDietVisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Diet/DietVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }

  static Future<String> newDietDropDown (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/GetDietById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> newdietById (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/GetDietById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> newDietSave (String createdBy,String token,int dietId,String name,String description,int dietDetailId,int quantity,int dietTimeId,
      int itemTypeId,) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"DietId": 4,
      "Name": "Update Diet API",
      "decription": null,
      "createdBy": "41b19c63-510c-48db-85b5-f745c9132c53",
      "createdOn": "2020-02-28T08:39:23.943",
      "isActive": true,
      "dietDetails": [
        {
          "id": 0,
          "quantity": 1,
          "dietTimeId": null,
          "productTypesId": 4,
          "createdBy": "41b19c63-510c-48db-85b5-f745c9132c53",
          "createdOn": "2020-03-03T09:26:12.933",
          "isActive": true,
        },
      ]
    });
    final response = await http.post(
        'http://192.236.147.77:8083/api/Diet/DietSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> productTypeList (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/GetAllProductTypes',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String>productTypeVisibilty(String token,int id) async{
    Map<String,String> headers = {'Authorization':'Bearer '+token};
    final response = await http.get('http://192.236.147.77:8083/api/Diet/ProductTypeVisibility/'+id.toString(), headers: headers,);
    if(response.statusCode==200){
      return response.body;
    }else
      return null;
  }



  static Future<String> productTypeById (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/GetProductTypeById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> inventoryProductById (String token, int id) async {
    Map<String, String> headers = {'Authorization': 'Bearer '+token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/InventoryGetProductTypeById/'+id.toString(),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> inventoryProductDropDown (String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer ' + token};
    final response = await http.get(
      'http://192.236.147.77:8083/api/Diet/InventoryGetProductTypeById',
      headers: headers,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> productTypeSave (String createdBy,String token,int id,int category,String name,int cost,int unit) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"productTypeId": 0,
      "category": 2,
      "name": "Product Type API",
      "costPerUnit": 120,
      "unit": "1",
      "IsInventory": false,
      "createdBy": "41b19c63-510c-48db-85b5-f745c9132c53",
      "createdOn": "2020-03-06T10:18:37.417",
      "isActive": true
    });
    final response = await http.post(
        'http://192.236.147.77:8083/api/Diet/ProductTypeSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> inventoryProductSave (String createdBy,String token,int id,int inventoryId,int categoryId,int cost) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer '+token
    };
    final body = jsonEncode({	"productTypeId": 0,
      "category": 2,
      "name": "No name",
      "costPerUnit": 120,
      "unit": "1",
      "inventoryId": 2,
      "IsInventory": true,
      "createdBy": "41b19c63-510c-48db-85b5-f745c9132c53",
      "createdOn": DateTime.now(),
      "isActive": true
    });
    final response = await http.post(
        'http://192.236.147.77:8083/api/Diet/InventoryProductTypeSave', headers: headers,
        body: body
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

}