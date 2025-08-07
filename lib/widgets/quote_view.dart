import 'package:flutter/material.dart';
import 'package:quote_generator/model/quote.dart';

class QuoteView extends StatelessWidget {
  final QuoteModel? quote;

  const QuoteView({super.key, this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1.5,
          color: Colors.grey.withValues(alpha: 0.7),
        ),
      ),
      child: quote == null
          ? const CircularProgressIndicator()
          : Column(
              children: [
                Text(
                  quote!.text,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                Text(
                  '— ${quote!.author}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
    );
  }
}
