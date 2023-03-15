import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API extends StatefulWidget {
  const API({Key? key}) : super(key: key);

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  List<dynamic> data = [];
  List<Album> albums = [];

  void getData() async {
    //http package
    await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'))
        .then((value) {
      data = jsonDecode(value.body);
      for (int i = 0; i < data.length; i++) {
        albums.add(Album.fromJson(data[i]));
      }
      print(albums[0].title);
      setState(() {

      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: albums.length==10? const Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(albums[index].title),
          );
        },
      ),
    );
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map jsonData) {
    return Album(
        userId: jsonData['userId'],
        id: jsonData['id'],
        title: jsonData['title']);
  }
}
