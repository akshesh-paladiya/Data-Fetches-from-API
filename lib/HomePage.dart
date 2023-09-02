import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<User> post = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('API Testing'),
      ),

      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: post.length,
                itemBuilder: (context, index){
                return Container(
                  height: 200,
                  color: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('User Id : ${post[index].userId}',style: TextStyle(fontSize: 16,color: Colors.black),),
                      Text(' Id : ${post[index].id}',style: TextStyle(fontSize: 16,color: Colors.black),),
                      Text('Title: ${post[index].title}',maxLines: 3,style: TextStyle(fontSize: 16,color: Colors.black),),
                      Text('Body: ${post[index].body}', maxLines: 6,style: TextStyle(fontSize: 16,color: Colors.black),),
                    ],
                  ),
                );
                }
            );
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }

  Future<List<User>> getData() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        post.add(User.fromJson(index));
      }
      return post;
    }else{
      return post;
    }
  }
}







