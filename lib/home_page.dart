import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercrud/add_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _data = [];
  bool _isLoading = true;

  Future _getData() async {
    try {
      final res = await http
          .get(Uri.parse('http://192.168.232.225/crudflutter/public/'));
      if (res.statusCode == 200) {
        final siswa = jsonDecode(res.body);
        setState(() {
          _data = siswa;
          _isLoading = false;
        });
      }
    } catch (e) {
      stderr.writeln(e);
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(title: const Text('Home Page')),
            body: ListView.builder(
                itemCount: _data.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_data[index]['nama']),
                      subtitle: Text(_data[index]['alamat']),
                    ),
                  );
                })),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddPage()));
              },
              child: const Icon(Icons.add),
            ),
          );
  }
}
