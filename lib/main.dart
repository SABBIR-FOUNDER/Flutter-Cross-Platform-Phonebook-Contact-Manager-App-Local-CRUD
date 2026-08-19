


import 'package:flutter/cupertino.dart';
import 'package:phonebook/contact_provider.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(create: (_) => ContactProvider(),
    child: const MyApp()
    ),
  );
}

