import 'dart:convert';

String dataParser(List<int>? dataFromDevice) {
  if (dataFromDevice != null) {
    return utf8.decode(dataFromDevice);
  }
  return "null";
}
