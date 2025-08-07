import 'package:flutter/material.dart';
import 'package:quote_generator/controller/quote_provider.dart';
import 'package:provider/provider.dart';
import 'package:quote_generator/widgets/quote_view.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Quote Generator')),
      body: Center(
        child: Consumer<QuoteProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.currentQuote == null) {
              return CircularProgressIndicator();
            }
            if (provider.error != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.error!),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => provider.loadQuotes(),
                    child: const Text('Retry'),
                  ),
                ],
              );
            }
            final currentQuote = provider.currentQuote;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: QuoteView(
                    quote: currentQuote,
                    key: ValueKey(currentQuote),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: provider.refreshQuote,
                  label: const Text('Random Quote'),
                  icon: Icon(Icons.refresh),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
