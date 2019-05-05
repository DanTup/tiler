import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'entities.g.dart';
part 'entities_generated.dart';

final _zlib = ZLibCodec();

List<int> decodeData(dynamic value) {
  if (value is String) {
    // TODO: We shouldn't assume zlib?
    final compressedBytes = base64Decode(value);
    final bytes = Uint8List.fromList(_zlib.decode(compressedBytes));
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
