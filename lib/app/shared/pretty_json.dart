import 'dart:convert';

String jsonPretty(Object obj) {
  const encoder = JsonEncoder.withIndent('  ');
  final prettyprint = encoder.convert(obj);
  return prettyprint;
}
