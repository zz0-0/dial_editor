import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:dial_editor/src/feature/editor/domain/entity/element/inline/inline.dart';
import 'package:dial_editor/src/feature/editor/domain/entity/node.dart';
import 'package:dial_editor/src/feature/editor/util/regex.dart';
import 'package:flutter/material.dart';

class ImageNode extends Inline {
  String url = "";
  String linkText = "Link";
  Image? image;

  ImageNode({
    required super.context,
    required super.rawText,
  }) {
    _parseMarkdownLink(rawText);
    controller.text = rawText;
    controller.addListener(updateTextHeight);
  }

  @override
  Widget render() {
    return _buildImage();
  }

  @override
  double updateTextHeight() {
    if (isEditing) {
      final textPainter = TextPainter(
        text: TextSpan(text: rawText, style: style),
        textDirection: TextDirection.ltr,
      )..layout();

      textHeight = textPainter.height;
    } else {
      if (image != null) {
        final Completer<ui.Image> completer = Completer<ui.Image>();
        image!.image.resolve(ImageConfiguration.empty).addListener(
              ImageStreamListener(
                (ImageInfo info, bool _) => completer.complete(info.image),
              ),
            );
        completer.future.then((value) {
          textHeight = value.height.toDouble();
        });
      }
    }

    return textHeight;
  }

  @override
  void updateText(String newText) {
    rawText = newText;
    final regex = boldRegex;
    text = newText.replaceAll(regex, '').trim();
    updateStyle();
    updateTextHeight();
  }

  @override
  void updateStyle() {}

  @override
  Node createNewLine() {
    return ImageNode(context: super.context, rawText: "");
  }

  @override
  String toString() {
    return rawText;
  }

  void _parseMarkdownLink(String text) {
    final match = imageRegex.firstMatch(text);
    if (match != null) {
      linkText = match.group(1) ?? '';
      url = match.group(2) ?? '';
    } else {
      url = text.trim();
    }
  }

  Widget _buildImage() {
    final match1 = imageUrlPathRegex.firstMatch(url);
    final match2 = imageFilePathRegex.firstMatch(url);

    if (match1 != null) {
      image = Image.network(
        url,
        errorBuilder: (context, error, stackTrace) {
          return Text(
            stackTrace.toString(),
            style: const TextStyle(color: Colors.red),
          );
        },
      );
      textHeight = updateTextHeight();
    } else if (match2 != null) {
      image = Image.file(
        File(url),
        errorBuilder: (context, error, stackTrace) {
          return Text(
            stackTrace.toString(),
            style: const TextStyle(color: Colors.red),
          );
        },
      );
      textHeight = updateTextHeight();
    }
    return image ?? Container();
  }
}
