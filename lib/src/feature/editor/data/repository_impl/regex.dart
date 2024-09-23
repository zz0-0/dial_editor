/// A regular expression that matches Markdown headings.
///
/// This regex matches strings that start with one to six hash (`#`) characters,
/// which are used to denote headings in Markdown syntax.
final headingRegex = RegExp('^#{1,6}');

/// A regular expression pattern used to match custom ID headings in the editor.
/// This regex is designed to identify headings that follow a specific format,
/// allowing for custom ID assignments within the markdown content.
final customIdHeadingRegex =
    RegExp(r'^(#{1,6})\s+(.+?)(?:\s+\{#([a-zA-Z0-9\-_]+)\})?$');

/// A regular expression to match bold text in Markdown format.
///
/// This regex captures text enclosed by double asterisks (`**`) or double 
/// underscores (`__`).
///
/// - Example:
///   - `**bold text**`
///   - `__bold text__`
///
/// The first capturing group matches the opening delimiter (`**` or `__`),
/// the second capturing group matches the text in between, and the third
/// capturing group matches the closing delimiter.
final boldRegex = RegExp(r'(\*\*|__)(.*?)\1');

/// A regular expression that matches italic text in Markdown syntax.
///
/// This regex captures text enclosed in either asterisks (*) or 
/// underscores (_).
/// For example, it will match `*italic*` or `_italic_`.
///
/// - The first capturing group `(\*|_)` matches either an asterisk or an underscore.
/// - The second capturing group `(.*?)` matches any characters (non-greedy).
/// - The `\1` refers back to the first capturing group, ensuring the same character is used to close the italic text.
final italicRegex = RegExp(r'(\*|_)(.*?)\1');

/// A regular expression that matches bold and italic text in Markdown.
///
/// This regex looks for text that is enclosed by either triple asterisks 
/// (`***`)
/// or triple underscores (`___`). The matched text can be accessed using the
/// second capture group.
///
/// Example matches:
/// - `***bold and italic***`
/// - `___bold and italic___`
final boldItalicRegex = RegExp(r'(\*\*\*|___)(.*?)\1');

/// A regular expression that matches the beginning of an unordered list item.
///
/// This regex checks for lines that start with either a hyphen (`-`) or an 
/// asterisk (`*`),
/// followed by a whitespace character. It is useful for identifying unordered 
/// list items
/// in markdown text.
final unorderedListRegex = RegExp(r'^[-*]\s');

/// A regular expression that matches an ordered list item in markdown format.
///
/// This regex pattern looks for a sequence of digits followed by a period and 
/// a space.
/// For example, it will match strings like "1. ", "2. ", "10. ", etc.
final orderListRegex = RegExp(r'^\d+\.\s');

/// A regular expression pattern to match task list items in markdown format.
///
/// This pattern matches lines that start with a hyphen followed by a space,
/// an optional checkbox (either checked `[x]` or unchecked `[ ]`), and the 
/// task 
/// description.
///
/// Example matches:
/// - `[ ] Task 1`
/// - `[x] Task 2`
/// - `[X] Task 3`
///
/// The first capture group matches the checkbox state (`x`, `X`, or space),
/// and the second capture group matches the task description.
final taskListRegex = RegExp(r'^- \[([ xX])\](.*)$');

/// A regular expression to match strikethrough text in Markdown format.
///
/// This regex captures text that is enclosed between double tildes (`~~`).
/// For example, the text `~~example~~` would be matched and captured by this 
/// regex.
final strikethroughRegex = RegExp('~~(.*?)~~');
// final imageRegex = RegExp(
//   r'!\[([^\]]*)\]\((https?:\/\/[^\s)]+\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))\)',
// );
/// A regular expression pattern to match image URL paths.
///
/// This regex is used to identify and validate image URLs within the 
/// application.
/// It ensures that the URLs conform to the expected format for image resources.
final imageUrlPathRegex = RegExp(
  r'^(https?:\/\/[^\s\)]+\.(jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))$',
);
// final imageFileRegex = RegExp(
//     r'!\[([^\]]*)\]\((?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))\)');
/// A regular expression to match image file paths.
/// This regex can be used to identify and validate paths that point to image 
/// files
/// within the application.
final imageFilePathRegex = RegExp(
  r'^(?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))$',
);

/// A regular expression pattern used to match image URLs or markdown image 
/// syntax.
/// This can be used to identify and extract image references from a given text.
final imageRegex = RegExp(
  r'!\[([^\]]*)\]\(((https?:\/\/[^\s\)]+\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))|((?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico))))\)',
);

/// A regular expression pattern to match image URLs.
///
/// This regex is used to identify and validate image URLs within the 
/// application.
/// It ensures that the URLs conform to the expected format for images.
final imageUrlRegex = RegExp(
  r'^(https?:\/\/[^\s\)]+\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico)|(?:[a-zA-Z]:)?[\/\\][^\s\/\\]+(?:[\/\\][^\s\/\\]+)*(?:\.(?:jpg|jpeg|png|gif|bmp|webp|svg|tiff|ico)))$',
);

/// A regular expression pattern to match Markdown links.
///
/// This pattern captures the text inside the square brackets `[]`
/// and the URL inside the parentheses `()`.
///
/// Example:
/// ```dart
/// final match = linkRegex.firstMatch('[example](http://example.com)');
/// if (match != null) {
///   print('Text: ${match.group(1)}'); // Outputs: example
///   print('URL: ${match.group(2)}');  // Outputs: http://example.com
/// }
/// ```
final linkRegex = RegExp(r'\[(.*?)\]\((.*?)\)');

/// A regular expression pattern to match URLs starting with "http" or "https".
///
/// This pattern ensures that the URL starts with "http://" or "https://", followed by
/// one or more non-whitespace characters.
///
/// Example matches:
/// - http://example.com
/// - https://example.com
///
/// Example non-matches:
/// - ftp://example.com
/// - http://example com
final urlRegex = RegExp(r'^https?:\/\/[^\s]+$');

/// A regular expression to match text enclosed within double equal signs (==).
///
/// This regex captures any text that is surrounded by double equal signs.
/// For example, it will match `==highlighted text==` and capture `highlighted 
/// text`.
///
/// Usage:
/// ```dart
/// final match = highlightRegex.firstMatch('This is ==highlighted== text.');
/// if (match != null) {
///   print(match.group(1)); // Outputs: highlighted
/// }
/// ```
final highlightRegex = RegExp('==(.*?)==');

/// A regular expression to match text enclosed in tildes (~).
///
/// This regex captures any text between two tildes, including the tildes 
/// themselves.
/// For example, in the string "This is ~subscript~ text", it will match 
/// "~subscript~".
final subscriptRegex = RegExp('~(.*?)~');

/// A regular expression to match superscript text enclosed within caret 
/// symbols (^).
///
/// This regex captures any text that is surrounded by caret symbols. For 
/// example,
/// in the string "E=mc^2^", it will match "2".
///
/// - Example:
///   ```dart
///   final match = superscriptRegex.firstMatch('E=mc^2^');
///   if (match != null) {
///     print(match.group(1)); // Output: 2
///   }
///   ```
final superscriptRegex = RegExp(r'\^(.*?)\^');

/// A regular expression that matches horizontal rules in Markdown text.
///
/// This regex looks for lines that contain three or more of the same character
/// (`-`, `*`, or `_`), optionally surrounded by whitespace. These lines are
/// typically used to create horizontal rules or dividers in Markdown documents.
final horizontalRuleRegex = RegExp(r'^\s*([-*_]){3,}\s*$');

/// A regular expression to match emoji shortcodes in the format `:emoji_name:`.
///
/// This regex captures sequences that start and end with a colon (`:`) and 
/// contain
/// alphanumeric characters or underscores (`_`) in between.
///
/// Example matches:
/// - `:smile:`
/// - `:thumbs_up:`
/// - `:123_emoji:`
final emojiRegex = RegExp(':([a-zA-Z0-9_]+):');

/// A regular expression to match inline mathematical expressions enclosed in 
/// dollar signs.
///
/// This regex captures any content between a pair of dollar signs (`$`).
/// For example, it will match `$math_expression$` and 
/// capture `math_expression`.
///
/// Usage:
/// ```dart
/// final match = inlineMathRegex.firstMatch(r'$E=mc^2$');
/// if (match != null) {
///   print(match.group(1)); // Outputs: E=mc^2
/// }
/// ```
final inlineMathRegex = RegExp(r'\$([^\$]*)\$');

/// A regular expression to match block math expressions enclosed in double 
/// dollar signs.
///
/// This regex captures any content between `$$` and `$$`, including newlines.
///
/// Example:
/// ```dart
/// final match = blockMathRegex.firstMatch('$$E=mc^2$$');
/// if (match != null) {
///   print(match.group(1)); // Outputs: E=mc^2
/// }
/// ```
final blockMathRegex = RegExp(r'\$\$(.*?)\$\$');

/// A regular expression that matches the start of a code block in Markdown.
///
/// This regex checks for lines that start with three backticks (` ``` `).
/// It optionally allows for any non-whitespace characters to follow the 
/// backticks,
/// which can be used to specify the language of the code block.
final codeBlockRegex = RegExp(r'^```(?:[^\S\r\n].*)?$');

/// A regular expression that matches lines starting with a '>' character 
/// followed by one or more characters.
/// This is typically used to identify blockquote lines in markdown text.
final quoteRegex = RegExp('^>.+');
