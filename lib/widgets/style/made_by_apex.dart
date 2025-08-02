import 'package:app/helpers/outapp_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MadeByApex extends StatefulWidget {
  const MadeByApex({super.key});

  @override
  State<MadeByApex> createState() => _MadeByApexState();
}

class _MadeByApexState extends State<MadeByApex> with OutAppHelper {

  final String apexLink = 'https://www.apex.ps/';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'madeWithLoveBy'.tr,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: () async => await launchThisUrl(apexLink),
            child: Text(
              'apex'.tr,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
