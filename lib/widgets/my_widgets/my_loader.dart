import 'package:flutter/material.dart';

class MyLoader extends StatefulWidget {
  const MyLoader({super.key});

  @override
  State<MyLoader> createState() => _MyLoaderState();
}

class _MyLoaderState extends State<MyLoader> {
  @override
  Widget build(BuildContext context) {
    return const  Center(child: CircularProgressIndicator());
  }
}
