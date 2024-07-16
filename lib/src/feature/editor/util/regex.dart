final headingRegex = RegExp("^#{1,6}");
final boldRegex = RegExp(r'(\*\*|__)(.*?)\1');
final italicRegex = RegExp(r'(\*|_)(.*?)\1');
final boldItalicRegex = RegExp(r'(\*\*\*|___)(.*?)\1');
final unorderedListRegex = RegExp(r'^[-*]\s');
final orderListRegex = RegExp(r'^\d+\.\s');
final taskListRegex = RegExp(r'^- \[([ xX])\](.*)$');
final strikethroughRegex = RegExp('~~(.*?)~~');
// final imageRegex = RegExp(
//   r'!\[([^\]]*)\]\((https?:\/\/[^\s)]+\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))\)',
// );
final imageUrlPathRegex = RegExp(
  r'^(https?:\/\/[^\s\)]+\.(jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))$',
);
// final imageFileRegex = RegExp(
//     r'!\[([^\]]*)\]\((?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))\)');
final imageFilePathRegex = RegExp(
  r'^(?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))$',
);
final imageRegex = RegExp(
  r'!\[([^\]]*)\]\(((https?:\/\/[^\s\)]+\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))|((?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))))\)',
);
final imageUrlRegex = RegExp(
  r'^(https?:\/\/[^\s\)]+\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico)|(?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico)))$',
);
final linkRegex = RegExp(r'\[(.*?)\]\((.*?)\)');
final urlRegex = RegExp(r'^https?:\/\/[^\s]+$');
final highlightRegex = RegExp('==(.*?)==');
final subscriptRegex = RegExp('~(.*?)~');
final superscriptRegex = RegExp(r'\^(.*?)\^');
final horizontalRuleRegex = RegExp(r'^\s*([-*_]){3,}\s*$');
final emojiRegex = RegExp(':([a-zA-Z0-9_]+):');
final inlineMathRegex = RegExp(r'\$([^\$]*)\$');
final blockMathRegex = RegExp(r'\$\$(.*?)\$\$');
final codeBlockRegex = RegExp(r'^```(?:[^\S\r\n].*)?$');
