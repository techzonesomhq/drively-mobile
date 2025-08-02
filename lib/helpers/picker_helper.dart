import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

mixin PickerHelper {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    try {
      var result = await _picker.pickImage(source: ImageSource.gallery);
      if (result == null) return null;
      return File(result.path);
    } catch (e) {
      return null;
    }
  }

  Future<List<File>> pickImages() async {
    try {
      return (await _picker.pickMultiImage()).map((e) => File(e.path)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<DateTime?> pickFullDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
  }) async {
    var result = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1950),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) => _theme(context, child),
    );

    return result ?? initialDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context,
      {TimeOfDay? initialDate}) async {
    var result = await showTimePicker(
      context: context,
      initialTime: initialDate ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
      builder: (BuildContext context, Widget? child) => _theme(context, child),
    );

    return result ?? initialDate;
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    return result != null ? File(result.files.single.path!) : null;
  }
}

MediaQuery _theme(BuildContext context, Widget? child) {
  return MediaQuery(
    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
    child: Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: Theme.of(context).primaryColor,
          onPrimary: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(backgroundColor: Colors.white),
        ),
      ),
      child: child!,
    ),
  );
}
