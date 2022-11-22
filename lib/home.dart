

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   Future  SendMessage({required String title, required String body}) async {
  

    var respons = await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: {
      'content-type': 'application/json',
      "Authorization":
          'key=AAAAHvzZJlk:APA91bEeCWMN61GVeJWTTs8aWGQry5Ua3SmdwXNZTGqs1nZfJwjgz62JtDnHRUsNPbwJLP6SoSxYNnvp9ryg4N-tG7BsaqiqVyMq5DWyshd7YWqFsNe4JwpdwtOrjDKcaW590Febc-So'
    },
      body:jsonEncode( {
        "registration_ids": [
          "cImmEFj2RC-arCIwy_VFKl:APA91bHi5kpHmUAnvM9oO3ZWHDOxGd7umFjwkzLlQN6UUDq1rHbB5bITCHCLab5ZMT0GcrvRF7jyzDRButEUMPCr4bVjX1g1Fxf9oC_e6Alpte-ahCHzbM2nnIE1VMY2W6EnhAvexT0q"
        ],
        "notification": {
          "body": body,
          "title": title,
          "android_channel_id": "pushnotificationapp",
          "sound": false
        },
      },
      ),
      
    );

    if(respons.statusCode==200){
      print("Message is success");
    }else{
      print("No sened");
    }
  }

  TextEditingController title=TextEditingController();
  TextEditingController body=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextField(
              controller: title,
              decoration: InputDecoration(hintText: "Title"),
             

            ),
            SizedBox(height: 20,),
            TextField(
              controller: body,
              decoration: InputDecoration(hintText: "Body"),
             

            ),
            Center(
             child: ElevatedButton(
                      onPressed: () async  {
                         await SendMessage(
                            title: title.text, body: body.text);


                            print("successs");
                      },
                      child: Text('send')),
            )
          ],
        ),
      ),
    );
  }
}