import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that provides a search functionality.
///
/// This widget is a consumer of a provider, allowing it to reactively
/// rebuild when the provider's state changes.
///
/// It is used within the search feature of the application to present
/// a search interface to the user.
class Search extends ConsumerWidget {
  /// A widget that represents a search feature.
  ///
  /// This widget is used to provide a search functionality in the application.
  ///
  /// {@category Widget}
  /// {@subCategory Search}
  ///
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
