import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'entities.g.dart';
part 'entities_generated.dart';

final _zlib = ZLibCodec();

List<int> decodeData(dynamic value) => decodeDataNullable(value)!;

List<int>? decodeDataNullable(dynamic value) {
  if (value is String) {
    final compressedBytes = base64Decode(value);
    // TODO: This is a dirty, we assume that it's ZLIB and if it fails to decode
    // it was not compressed. We don't have access to the compression type in
    // here.
    final bytes = _try(
      () => Uint8List.fromList(_zlib.decode(compressedBytes)),
      orElse: () => compressedBytes,
    );
    final byteData = ByteData.view(bytes.buffer);
    return List.generate(
      (byteData.lengthInBytes / 4).floor(),
      (i) => byteData.getUint32(i * 4, Endian.little),
    );
  } else if (value is List) {
    return value.cast<int>();
  } else if (value == null) {
    return null;
  } else {
    throw Exception('Unknown data type: ${value.runtimeType}');
  }
}

T _try<T>(T Function() f, {required T Function() orElse}) {
  try {
    return f();
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    return orElse();
  }
}
