import 'dart:convert';
import 'dart:io';

Future<String> fetch(Uri uri) async {
  final http = HttpClient();
  try {
    final req = await http.getUrl(uri);
    final resp = await req.close();
    return resp.transform(utf8.decoder).join();
  } finally {
    http.close();
  }
}

Future<void> formatFile(File file) async {
  final res =
      await Process.run(Platform.resolvedExecutable, ['format', file.path]);
  if (res.exitCode != 0) {
    throw Exception('${res.stderr}\n\n${res.stdout}'.trim());
  }
}

Future<void> writeFile(File file, String contents) =>
    file.writeAsString('$contents\n');
