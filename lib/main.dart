import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    try {
      this.setState(() {
        data = json.decode(response.body);
      });
    } catch (e) {
      print('Error reading from API');
      print(e);
      print(response.statusCode);
      print(response.reasonPhrase);
      return "error";
    }

    print(data[0]["id"]);
    print(data[0]["title"]);
    print(data[0]["body"]);

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Listviews"), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Text('${data[index]["id"]} > ${data[index]["title"]}'),
          );
        },
      ),
    );
  }
}
