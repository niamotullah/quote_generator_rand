// controller/quote_provider.dart
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:quote_generator/model/quote.dart';

class QuoteProvider with ChangeNotifier {
  final Dio _dio = Dio();
  final Random _random = Random();
  List<QuoteModel>? _quotes;
  QuoteModel? _currentQuote;
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  QuoteModel? get currentQuote => _currentQuote;

  Future<void> loadQuotes() async {
    if (_quotes != null && _quotes!.isNotEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      const url =
          'https://raw.githubusercontent.com/dwyl/quotes/main/quotes.json';
      final response = await _dio.get(url);
      final List<dynamic> data = jsonDecode(response.data);

      _quotes = data.map((json) => QuoteModel.fromJson(json)).toList();
      _getRandomQuote();
    } catch (e) {
      _error = 'Failed to load quotes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _getRandomQuote() {
    if (_quotes == null || _quotes!.isEmpty) return;

    _currentQuote = _quotes![_random.nextInt(_quotes!.length)];
    notifyListeners();
  }

  Future<void> refreshQuote() async {
    if (_quotes == null || _quotes!.isEmpty) {
      await loadQuotes();
    } else {
      _getRandomQuote();
    }
  }
}
