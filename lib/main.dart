


import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/list_clr.dart';
import 'package:flutter_application_1/views/splash_screen.dart';

import 'package:flutter_application_1/model/data_model.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main()async{
  
await Hive.initFlutter();
if(!Hive.isAdapterRegistered(NotesModelAdapter().typeId))
{
  Hive.registerAdapter(NotesModelAdapter());
}

runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => ColorProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
       home: SplashScreen(),
       
       ),
    );


    
  }
}