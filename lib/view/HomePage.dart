import 'package:flutter/material.dart';
import 'package:network_layer_provider/network_module/api_response.dart';
import 'package:network_layer_provider/providers/album_detais_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        height: 250,
        padding: EdgeInsets.all(20),
        child: albumTile(context),
      ),
    );
  }

  Widget albumTile(BuildContext context) {
    return Consumer<AlbumProvider>(builder: (context, myModel, chile) {
      if (myModel.album!.status == Status.COMPLETE) {
        return Card(
          elevation: 5.0,
          child: Column(
            children: [
              Text('${myModel.album!.data!.id}'),
              SizedBox(height: 5.0),
              Text('${myModel.album!.data!.userId}'),
              SizedBox(height: 5.0),
              Text('${myModel.album!.data!.title}'),
              SizedBox(height: 5.0),
              Text('${myModel.album!.data!.body}'),
              SizedBox(height: 5.0),
            ],
          ),
        );
      } else if (myModel.album!.status == Status.ERROR) {
        return Text('${myModel.album!.message}');
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
