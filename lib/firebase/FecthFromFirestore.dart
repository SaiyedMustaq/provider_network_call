import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchFromFireStore extends StatefulWidget {
  FetchFromFireStore({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _FetchFromFireStoreState createState() => _FetchFromFireStoreState();
}

class _FetchFromFireStoreState extends State<FetchFromFireStore> {
  var db;
  List<QuerySnapshot> list = [];
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        modeLoad();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  getData() async {
    db = FirebaseFirestore.instance
        .collection('mobileshop')
        .orderBy('name')
        .limit(5)
        .snapshots();
  }

  queary(String id) async {
    print("id $id");
    FirebaseFirestore.instance.collection('mobileshop').where(id).get().then(
          (QuerySnapshot snapshot) => {
            snapshot.docs.forEach((f) {
              if (id == f.id) {
                print('Name ${f['name']}');
                print('Price ${f['price']}');
                print('Ram ${f['ram']}');
              }
            }),
          },
        );
  }

  void modeLoad() {
    db = FirebaseFirestore.instance
        .collection('mobileshop')
        .orderBy('name')
        .limit(5)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
          stream: db,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              controller: _scrollController,
              children: snapshot.data!.docs.map((document) {
                return InkWell(
                  onTap: () => queary(document.id),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, top: 23, bottom: 23),
                      child: Row(
                        children: [
                          Image.network(
                            document['image'],
                            height: 100,
                            width: 80,
                            fit: BoxFit.contain,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${document['name']}',
                                    style: TextStyle(fontSize: 15.0)),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text('${document['ram']}',
                                    style: TextStyle(fontSize: 15.0)),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: new BoxDecoration(
                                            color: const Color(0xFF66BB6A),
                                            boxShadow: [
                                              new BoxShadow(
                                                offset: Offset(12.2, 15.0),
                                                color: Colors.white,
                                                blurRadius: 10.0,
                                              ),
                                            ]),
                                        child: Text(
                                          '${document['off']}%',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        '₹ ${document['price']}',
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      // child: Center(child: Text(document['price'])),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
