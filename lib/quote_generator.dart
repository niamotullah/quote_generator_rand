import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_generator/controller/quote_provider.dart';
import 'package:quote_generator/view/quote_screen.dart';

class QuoteGenerator extends StatelessWidget {
  const QuoteGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => QuoteProvider()..loadQuotes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Random Quote Generator',
        theme: ThemeData(primarySwatch: Colors.blue),
        darkTheme: ThemeData.dark(),
        home: QuoteScreen(),
      ),
    );
  }
}
