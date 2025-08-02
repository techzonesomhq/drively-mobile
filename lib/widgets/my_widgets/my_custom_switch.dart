import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/helpers/styles_helper.dart';

typedef CustomSwitchCallBack = Function(bool __);

class MyCustomSwitch extends StatefulWidget {
  final bool value;
  final CustomSwitchCallBack callBack;

  const MyCustomSwitch({
    required this.value,
    required this.callBack,
    super.key,
  });

  @override
  State<MyCustomSwitch> createState() => _MyCustomSwitchState();
}

class _MyCustomSwitchState extends State<MyCustomSwitch> with StylesHelper {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.h,
      width: 35.w,
      decoration: BoxDecoration(
        color: widget.value ? null : Colors.grey,
        borderRadius: BorderRadius.circular(50.r),
        gradient: widget.value ? appLinearGradient() : null,
      ),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Switch(
          value: widget.value,
          onChanged: (__) => widget.callBack(__),
          activeTrackColor: Colors.transparent,
          inactiveTrackColor: Colors.transparent,
          activeColor: Colors.white,
          inactiveThumbColor: Colors.white,
        ),
      ),
    );
  }
}
