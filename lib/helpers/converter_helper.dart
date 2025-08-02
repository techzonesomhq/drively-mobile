import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

mixin ConverterHelper {
  Future<File?> convertLinkToFile(String link) async {
    try {
      /// 1
      var url = Uri.parse(link);
      var response = await http.get(url);

      if (response.statusCode != 200) return null;

      /// 2
      var directory = await getApplicationDocumentsDirectory();
      String name = '${DateTime.now()}${getFileExtension(link)}';
      File file = File(join(directory.path, name));

      /// 3
      await file.writeAsBytes(response.bodyBytes);

      /// 4
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<Uint8List?> convertLinkToBytes(String link) async {
    var file = await convertLinkToFile(link);
    if (file == null) return null;
    img.Image? image;
    if (link.contains('.png')) {
      image = img.decodePng(file.readAsBytesSync());
    } else if (link.contains('.jpg')) {
      image = img.decodeJpg(file.readAsBytesSync());
    } else {
      image = img.decodeImage(file.readAsBytesSync());
    }
    if (image == null) return null;
    var resized = img.copyResize(image, width: 70, height: 70);

    List<int> list = resized.buffer.asUint8List().toList();
    Uint8List bytes = Uint8List.fromList(list);

    return bytes;
  }

  Future<BitmapDescriptor> convertAssetToBitmap(
    String image, {
    required int width,
  }) async {
    try {
      ByteData data = await rootBundle.load('assets/images/$image');
      ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width.w.toInt(),
      );
      ui.FrameInfo fi = await codec.getNextFrame();
      var byteData =
          (await fi.image.toByteData(
            format: ui.ImageByteFormat.png,
          ))!.buffer.asUint8List();

      var bitmap = BitmapDescriptor.fromBytes(byteData);
      return bitmap;
    } catch (e) {
      return BitmapDescriptor.defaultMarker;
    }
  }

  String? convertDateTimeToStringTime({
    required DateTime? dateTime,
    String? placeholder,
    String format = 'yyyy/MM/dd',
  }) {
    if (dateTime == null) return placeholder;
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(dateTime);
  }

  DateTime? convertStringTimeToDateTime({
    required String? time,
    DateTime? placeholder,
    String format = 'yyyy/MM/dd',
  }) {
    if (time == null) return placeholder;
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.parse(time);
  }

  String? convertTimeOfDayToStringTime({
    required TimeOfDay? timeOfDay,
    String? placeholder,
  }) {
    if (timeOfDay == null) return placeholder;
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final min = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$min';
  }

  TimeOfDay? convertStringTimeToTimeOfDay({
    required String? time,
    String format = 'HH:mm',
  }) {
    if (time == null) return null;
    return TimeOfDay(
      hour: int.parse(time.split(':')[0]),
      minute: int.parse(time.split(':')[1]),
    );
  }

  String? cutDialFromMobile({required String? mobile, required String? dial}) {
    try {
      if (mobile == null || dial == null) return null;
      return mobile.replaceFirst(dial, '');
    } catch (e) {
      return null;
    }
  }

  LatLng? cutLatLngFromLocationUrl(String? url) {
    try {
      if (url == null) return null;

      String key = 'query=';
      String __ = url;
      int index = __.indexOf(key);
      __ = __.substring(index + key.length);

      index = __.indexOf('&');
      __ = __.substring(0, index);

      List<String> list = __.split('%2C');

      String lat = list[0];
      String lng = list[1];
      return LatLng(double.parse(lat), double.parse(lng));
    } catch (e) {
      return null;
    }
  }

  int getDayNumberFromDateTime(DateTime dateTime) {
    String day =
        Jiffy.parseFromDateTime(dateTime).format(pattern: 'EEEE').toLowerCase();

    switch (day) {
      case 'saturday':
        return 7;
      case 'sunday':
        return 1;
      case 'monday':
        return 2;
      case 'tuesday':
        return 3;
      case 'wednesday':
        return 4;
      case 'thursday':
        return 5;
      case 'friday':
        return 6;
    }
    return -1;
  }

  String? cutTimeToMinuteSecondOnly(String? time) {
    if (time == null) return null;
    return time.length == 8 ? time.substring(0, 5) : time;
  }

  String convertDurationToMinutesSeconds(Duration duration) {
    int seconds = duration.inSeconds;
    return '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  String convertFullTDateToStringDT(String? full, {String? format}) {
    try {
      if (full == null) return '';
      String dateTimeString = full;
      DateTime dateTime = DateTime.parse(dateTimeString);

      return DateFormat(format ?? 'hh:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  DateTime? convertFullTDateToDT(String? full) {
    try {
      if (full == null) return null;
      String dateTimeString = full;
      DateTime dateTime = DateTime.parse(dateTimeString);
      return dateTime;
    } catch (e) {
      return null;
    }
  }

  String? convertDateTimeToISO8601(DateTime? dt) {
    if (dt == null) return null;
    DateTime adjusted = DateTime.utc(dt.year, dt.month, dt.day);
    return adjusted.toIso8601String();
  }

  String getFileExtension(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path;
    int lastDotIndex = path.lastIndexOf('.');

    if (lastDotIndex != -1) {
      return path.substring(lastDotIndex);
    }

    return '';
  }
}
