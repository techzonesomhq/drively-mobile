import 'package:app/controllers/lang_controller.dart';
import 'package:app/controllers/style_controller.dart';
import 'package:app/extensions/opacity_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:app/helpers/image_helper.dart';
import 'package:app/widgets/my_widgets/my_search_field.dart';

typedef MobileCallback = Function(AppIntlCountry);

class MyMobileTextField extends StatefulWidget {
  final TextEditingController controller;
  final MobileCallback mobileCallback;
  final String? dialCode;
  final bool countriesEnabled;
  final double bottomPadding;
  final Function(String)? onSubmitted;
  final List<String>? allowedCountries;
  final Color? fillColor;
  final bool withIcon;
  final double horPadding;

  const MyMobileTextField({
    required this.controller,
    required this.mobileCallback,
    this.dialCode,
    this.countriesEnabled = false,
    this.bottomPadding = 0,
    this.onSubmitted,
    this.allowedCountries,
    this.fillColor,
    this.withIcon = true,
    this.horPadding = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<MyMobileTextField> createState() => _MyMobileTextFieldState();
}

class _MyMobileTextFieldState extends State<MyMobileTextField>
    with ImageHelper {
  late TextEditingController searchEditingController;

  late AppIntlCountry selectedCountry = allowedCountries.firstWhere(
    (element) => element.dialCode == (widget.dialCode ?? '964'),
  );

  List<AppIntlCountry> searchedCountries = [];

  List<AppIntlCountry> get countries => allowedCountries;

  List<AppIntlCountry> get allowedCountries {
    if (widget.allowedCountries == null) return intlCountriesList;

    List<AppIntlCountry> list = [];

    for (var ic in intlCountriesList) {
      for (var ac in widget.allowedCountries!) {
        if (ac == ic.dialCode) {
          int index = list.indexWhere(
            (element) => element.dialCode == ic.dialCode,
          );
          if (index == -1) {
            list.add(ic);
          }
        }
      }
    }
    return list;
  }

  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    searchEditingController = TextEditingController();
    focusNode =
        FocusNode()
          ..addListener(() => setState(() => isFocused = focusNode.hasFocus));
    Future.delayed(
      const Duration(milliseconds: 500),
      () => widget.mobileCallback(selectedCountry),
    );
  }

  @override
  void dispose() {
    searchEditingController.dispose();
    super.dispose();
  }

  late FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LangController>(
      builder: (langC) {
        return GetBuilder<StyleController>(
          builder: (styleC) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: widget.bottomPadding.h,
                right: widget.horPadding.w,
                left: widget.horPadding.w,
              ),
              child: SizedBox(
                height: 45.h,
                child: TextField(
                  focusNode: focusNode,
                  controller: widget.controller,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.grey,
                  style: _textStyle(styleC, black: true),
                  decoration: _buildInputDecoration(styleC, langC),
                  textDirection: TextDirection.ltr,
                  onSubmitted: widget.onSubmitted,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'(^\d*\.?\d{0,2})'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  InputDecoration _buildInputDecoration(
    StyleController styleC,
    LangController langC,
  ) {
    return InputDecoration(
      hintText: '123 456 789',
      filled: widget.fillColor != null,
      fillColor: widget.fillColor,
      hintTextDirection: TextDirection.ltr,
      hintStyle: _textStyle(styleC).copyWith(fontSize: 13.sp),
      contentPadding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
      prefixIcon: _buildPrefixIcon(styleC, langC),
      suffixIcon: _buildSuffixIcon(styleC, langC),
      enabledBorder: _buildOutlineInputBorder(false),
      focusedBorder: _buildOutlineInputBorder(true),
    );
  }

  Widget? _buildPrefixIcon(StyleController styleC, LangController langC) {
    return langC.lang == 'en'
        ? Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 10.w),
          child: InkWell(
            onTap: () => showCountries(styleC, langC),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                Text('+${selectedCountry.dialCode}', style: _textStyle(styleC)),
                SizedBox(width: 8.w),
                _flagImage(selectedCountry.code),
              ],
            ),
          ),
        )
        : _icon();
  }

  Widget? _buildSuffixIcon(StyleController styleC, LangController langC) {
    return langC.lang == 'ar'
        ? Padding(
          padding: EdgeInsetsDirectional.only(end: 20.w, start: 5.w),
          child: InkWell(
            onTap: () => showCountries(styleC, langC),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.keyboard_arrow_down,
                  color: _textStyle(styleC).color,
                  size: 16.h,
                ),
                SizedBox(width: 1.w),
                Text('${selectedCountry.dialCode}+', style: _textStyle(styleC)),
                SizedBox(width: 8.w),
                _flagImage(selectedCountry.code),
              ],
            ),
          ),
        )
        : _icon();
  }

  Widget? _icon() {
    return widget.withIcon
        ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: appSvgImage(
            'icons/mobile_icon',
            color: isFocused ? Theme.of(context).primaryColor : null,
          ),
        )
        : null;
  }

  OutlineInputBorder _buildOutlineInputBorder(bool active) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color:
            active
                ? Theme.of(context).primaryColor
                : const Color(0xff5D5D5D).changeOpacity(0.2),
        width: 1.w,
      ),
    );
  }

  void showCountries(StyleController styleC, LangController langC) {
    if (widget.countriesEnabled) {
      setState(() => searchEditingController.clear());
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          ),
        ),
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: StatefulBuilder(
              builder: (context, myState) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 18.h, width: 18.w),
                          Container(
                            width: 75.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              size: 18.h,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      MySearchField(
                        controller: searchEditingController,
                        onChanged: (searchText) {
                          setState(() {
                            searchedCountries.clear();
                            for (int i = 0; i < countries.length; i++) {
                              if (countries[i].name.toLowerCase().contains(
                                    searchText.toLowerCase(),
                                  ) ||
                                  countries[i].nameAr.toLowerCase().contains(
                                    searchText.toLowerCase(),
                                  ) ||
                                  countries[i].dialCode.contains(
                                    searchText.toLowerCase(),
                                  )) {
                                searchedCountries.add(countries[i]);
                              }
                            }
                            if (searchEditingController.text.isEmpty) {
                              searchedCountries.clear();
                            }
                          });
                          updated(myState);
                        },
                      ),
                      SizedBox(height: 15.h),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children:
                              searchedCountries.isNotEmpty ||
                                      searchEditingController.text.isNotEmpty
                                  ? searchedCountries
                                      .map(
                                        (country_) => countryDetails(
                                          country_,
                                          myState,
                                          styleC,
                                          langC,
                                        ),
                                      )
                                      .toList()
                                  : countries
                                      .map(
                                        (country_) => countryDetails(
                                          country_,
                                          myState,
                                          styleC,
                                          langC,
                                        ),
                                      )
                                      .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }

  Widget countryDetails(
    AppIntlCountry country,
    StateSetter myState,
    StyleController styleC,
    LangController langC,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: InkWell(
        onTap: () {
          setState(() => selectedCountry = country);
          updated(myState);
          Navigator.pop(context);
          widget.mobileCallback(selectedCountry);
        },
        child: Row(
          children: [
            _flagImage(country.code, width: 32),
            SizedBox(width: 7.w),
            Expanded(
              child: Text(
                '+${country.dialCode}      ${langC.lang == 'ar' ? country.nameAr : country.name}',
                style: _textStyle(styleC),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle(
    StyleController styleC, {
    double fontSize = 14,
    bool black = false,
  }) {
    return TextStyle(
      color: black ? Colors.black : const Color(0xff9F9F9F),
      fontSize: fontSize.sp,
      fontWeight: FontWeight.normal,
    );
  }

  Widget _flagImage(String code, {double width = 30}) => Image.asset(
    'assets/flags/${code.toLowerCase()}.png',
    package: 'intl_phone_field',
    width: width.w,
  );

  Future<void> updated(StateSetter updateState) async => updateState(() {});
}
