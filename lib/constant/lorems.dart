import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class LoremIpsumWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        generateLoremIpsum(50), // Generate Lorem Ipsum text with 50 words
      ),
    );
  }

  String generateLoremIpsum(int numWords) {
    final wordList = generateWordPairs().take(numWords).map((pair) => pair.first);
    return wordList.join(' ');
  }
}