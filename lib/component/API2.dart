import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API2 extends StatefulWidget {
  const API2({Key? key}) : super(key: key);

  @override
  State<API2> createState() => _API2State();
}

class _API2State extends State<API2> {
  List<dynamic> data = [];
  List<Photo> photo = [];


  void getData() async {
    await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'))
        .then((value) {
      data = jsonDecode(value.body);
      for (int i = 0; i < data.length; i++) {
        photo.add(Photo.fromJson(data[i]));
      }
      setState(() {});
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
        body:photo.length==photo.length? const Center(child: CircularProgressIndicator(),): GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 20,mainAxisSpacing: 20),
            itemCount: photo.length,
            itemBuilder: (context, index) {
              return Image(image: NetworkImage(photo[index].url),);
            }));
  }
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo(
      {required this.url,
      required this.albumId,
      required this.id,
      required this.title,
      required this.thumbnailUrl});

  factory Photo.fromJson(Map jsonData) {
    return Photo(
      url: jsonData['url'],
      albumId: jsonData['albumId'],
      id: jsonData['id'],
      title: jsonData['title'],
      thumbnailUrl: jsonData['thumbnailUrl']
    );
  }
}
