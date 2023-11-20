import 'package:flutter/material.dart';
import 'package:network_layer_provider/providers/album_detais_provider.dart';
import 'package:network_layer_provider/view/HomePage.dart';
import 'package:provider/provider.dart';

bool USE_FIRESTORE_EMULATOR = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlbumProvider>(
            create: (context) => AlbumProvider(context)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(
          title: 'Api Call',
        ),
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
          ],
        ),
      ),
    );
  }
}
