import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:network_layer_provider/ContactFetch/ContactFetchPage.dart';
import 'package:network_layer_provider/providers/album_detais_provider.dart';
import 'package:provider/provider.dart';

bool USE_FIRESTORE_EMULATOR = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlbumProvider>(
            create: (context) => AlbumProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyNavigation(),
      ),
    );
  }
}

class MyNavigation extends StatelessWidget {
  const MyNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: true,
        right: true,
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25.0),
            MaterialButton(
                color: Colors.blueAccent,
                height: 60.0,
                elevation: 2.3,
                colorBrightness: Brightness.light,
                minWidth: MediaQuery.of(context).size.width,
                child: Text(
                  'Goto Contact Fetch Page',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ContactsPage()));
                }),
          ],
        ),
      ),
    );
  }
}
