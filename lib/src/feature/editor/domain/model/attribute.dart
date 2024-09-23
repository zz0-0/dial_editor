import 'package:dial_editor/src/feature/editor/domain/model/connection.dart';
import 'package:flutter/material.dart';

/// Represents an attribute in the editor domain model.
/// 
/// This class is used to define various attributes that can be applied
/// to elements within the editor. Attributes can include styles, formatting,
/// and other properties that modify the appearance or behavior of the content.
class Attribute {
  /// A global key that uniquely identifies the [EditableTextState] widget.
  /// This key can be used to access the state of the [EditableText] widget
  /// for operations such as focusing, clearing, or manipulating the text.
  final key = GlobalKey<EditableTextState>();
  /// A map that holds the connections associated with the attribute.
  /// 
  /// The keys are strings representing the connection identifiers, and the 
  /// values
  /// are `Connection` objects that contain the details of each connection.
  Map<String, Connection> connections = {};
}
