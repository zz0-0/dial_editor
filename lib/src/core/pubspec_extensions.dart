import 'package:pubspec_parse/pubspec_parse.dart';

extension PubspecExtensions on Pubspec {
  Iterable<String> pathDependencyNames() {
    return dependencies.entries
        .where((entry) => entry.value is PathDependency)
        .map((entry) => entry.key);
  }

  bool containsInRegularOrDevDependencies(String subpath) {
    final subpathLowercase = subpath.toLowerCase();
    return dependencies.entries.any(
          (envEntry) => envEntry.key.toLowerCase().contains(subpathLowercase),
        ) ||
        devDependencies.entries.any(
          (envEntry) => envEntry.key.toLowerCase().contains(subpathLowercase),
        );
  }

  bool containsInRegularOrDevPathDependencies(String subpath) {
    return dependencies.entries
            .where((entry) => entry.value is PathDependency)
            .map((entry) => entry.value as PathDependency)
            .any((pathDependency) => pathDependency.path.contains(subpath)) ||
        devDependencies.entries
            .where((entry) => entry.value is PathDependency)
            .map((entry) => entry.value as PathDependency)
            .any((pathDependency) => pathDependency.path.contains(subpath));
  }

  Iterable<String> dependenciesContainingSubpathInNames(String subpath) {
    return dependencies.entries
        .where((dependency) => dependency.key.contains(subpath))
        .map((e) => e.key);
  }

  bool hasDependency(String name) {
    return dependencies.entries.any((dependency) => dependency.key == name);
  }
}
