import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var information = {};

  Future getInformation() async {
    var response = await http.get(
      Uri.parse('https://coderbyte.com/api/challenges/json/json-cleaning'),
      headers: {
        'Content-type': 'application/json; charset-UTF-8',
        'Accept': 'application/json'
      },
    );
    setState(() {
      information = jsonDecode(response.body) as Map;
    });

    // information['name'].removeWhere(
    //     (key, value) => value == '' || value == '-' || value == 'N/A');

    // information.removeWhere(
    //     (key, value) => value == '' || value == '-' || value == 'N/A');

    // information['education'].removeWhere(
    //     (keys, value) => value == '' || value == '-' || value == 'N/A');

    // information['hobbies']
    //     .removeWhere((item) => item == '' || item == '-' || item == 'N/A');

    return 'success';
  }

  cleanJson(data) {
    data.removeWhere(
        (key, value) => value == '' || value == '-' || value == 'N/A');
    data.forEach((k, v) {
      if (v is List) {
        v.removeWhere((value) => value == '-' || value == '' || value == 'N/A');
      } else if (v is Map) {
        v.removeWhere(
            (key, value) => value == '-' || value == '' || value == 'N/A');
      }
    });
    return data;
  }

  @override
  void initState() {
    super.initState();

    getInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('without function'),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 25),
            child: Text(information.toString()),
          ),
          const Text('with function'),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 25),
            child: Text(cleanJson(information).toString()),
          ),
        ],
      )),
    );
  }
}
