import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that represents the table of content in the editor feature.
///
/// This widget is a consumer of the provider framework, allowing it to
/// reactively rebuild when the provider's state changes.
///
/// The `TableOfContent` class extends `ConsumerWidget`, which means it
/// can access the provider's state and update its UI accordingly.
///
/// This widget is typically used to display a structured list of
/// headings or sections within a document, providing easy navigation
/// for the user.
class TableOfContent extends ConsumerWidget {
  /// A widget that represents the table of contents in the editor feature.
  ///
  /// This widget is used to display a structured list of contents, allowing
  /// users to navigate through different sections of the document easily.
  ///
  const TableOfContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
