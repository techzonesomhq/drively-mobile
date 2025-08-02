import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/helpers/image_helper.dart';
import 'package:app/widgets/my_widgets/my_shimmer.dart';
import 'package:app/widgets/my_widgets/my_text_field.dart';
import 'package:get/get.dart';

typedef SelectedDropDownCallBack = Function(dynamic _);

class MyDropDownMenu extends StatefulWidget {
  final String hint;
  final dynamic item;
  final List<dynamic> items;
  final SelectedDropDownCallBack callBack;
  final double bottomMargin;
  final bool modalSheet;
  final bool loading;
  final String? suffix;
  final double radius;
  final Function()? customAction;
  final Widget? sheetTitle;
  final bool search;
  final String? searchHint;
  final String? prefixIcon;
  final Color? fillColor;
  final double horMargin;
  final Color? prefixIconColor;
  final bool enabled;

  const MyDropDownMenu({
    required this.hint,
    required this.item,
    required this.items,
    required this.callBack,
    this.bottomMargin = 0,
    this.modalSheet = false,
    this.loading = false,
    this.suffix,
    this.radius = 12,
    this.customAction,
    this.sheetTitle,
    this.search = true,
    this.searchHint,
    this.prefixIcon,
    this.fillColor,
    this.horMargin = 0,
    this.prefixIconColor,
    this.enabled = true,
    super.key,
  });

  @override
  State<MyDropDownMenu> createState() => _MyDropDownMenuState();
}

class _MyDropDownMenuState extends State<MyDropDownMenu> with ImageHelper {
  final Color _black = const Color(0xff282828);

  late TextEditingController searchEditingController;

  @override
  void initState() {
    super.initState();
    searchEditingController = TextEditingController();
  }

  @override
  void dispose() {
    searchEditingController.dispose();
    super.dispose();
  }

  List<dynamic> searchedItems = [];

  bool opened = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          !widget.loading && widget.items.isNotEmpty && widget.enabled
              ? widget.customAction ??
                  () {
                    if (widget.modalSheet) {
                      _openSheet();
                    }
                  }
              : null,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        height: 45.h,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        padding:
            !widget.loading
                ? EdgeInsetsDirectional.only(
                  start: (widget.prefixIcon == null ? 18 : 10).w,
                  end: 12.w,
                )
                : EdgeInsets.zero,
        margin: EdgeInsets.only(
          bottom: widget.bottomMargin.h,
          left: widget.horMargin.w,
          right: widget.horMargin.w,
        ),
        decoration: BoxDecoration(
          color: widget.enabled ? widget.fillColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(widget.radius.r),
          border: Border.all(color: const Color(0xffE1E1E1), width: 1.w),
        ),
        child:
            !widget.loading
                ? !widget.modalSheet
                    ? DropdownButton<dynamic>(
                      onTap: () => setState(() => opened = true),
                      isExpanded: true,
                      hint: Row(
                        children: [
                          _prefix(),
                          Text(
                            widget.hint,
                            style: TextStyle(
                              color: widget.item != null ? _black : Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      dropdownColor: Colors.white,
                      underline: _empty,
                      icon: _icon,
                      value: widget.item,
                      items:
                          widget.items
                              .map<DropdownMenuItem<dynamic>>(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Row(
                                    children: [
                                      _prefix(),
                                      Text(
                                        '${item?.name ?? ''} ${widget.suffix ?? ''}',
                                        style: TextStyle(
                                          color: _black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (item) => widget.callBack(item),
                    )
                    : Row(
                      children: [
                        _prefix(),
                        Expanded(
                          child: Text(
                            widget.item?.name != null
                                ? '${widget.item?.name} ${widget.suffix ?? ''}'
                                : widget.hint,
                            style: TextStyle(
                              color: widget.item == null ? Colors.grey : _black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        _icon,
                      ],
                    )
                : const MyShimmer(height: 45),
      ),
    );
  }

  Widget _prefix() => /*!opened && */
      widget.prefixIcon != null
          ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              appSvgImage(
                'icons/${widget.prefixIcon}',
                width: 22.w,
                color: widget.prefixIconColor,
              ),
              SizedBox(width: 10.w),
            ],
          )
          : _empty;

  Widget get _icon =>
      Icon(Icons.keyboard_arrow_down, color: Colors.black45, size: 20.h);

  List<dynamic> get _listToShow =>
      searchEditingController.text.isEmpty ? widget.items : searchedItems;

  void _openSheet() {
    setState(() => [searchEditingController.clear(), searchedItems.clear()]);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
        side: BorderSide.none,
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, newState) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height - 150,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.sheetTitle != null
                        ? Column(
                          children: [
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widget.sheetTitle!,
                                InkWell(
                                  onTap: () => _pop,
                                  child: CircleAvatar(
                                    radius: 13.h,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 18.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                        : _empty,
                    SizedBox(height: (widget.sheetTitle == null ? 20 : 10).h),
                    widget.search
                        ? MyTextField(
                          controller: searchEditingController,
                          hint: widget.searchHint ?? 'search'.tr,
                          onChanged: (__) {
                            setState(() {
                              searchedItems.clear();
                              for (var item in widget.items) {
                                if ((item.name.toString())
                                    .toLowerCase()
                                    .contains(__.toLowerCase())) {
                                  searchedItems.add(item);
                                }
                              }
                            });
                            _updateStata(newState);
                          },
                        )
                        : _empty,
                    Expanded(
                      child: ListView.separated(
                        itemCount: _listToShow.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap:
                                () => [
                                  widget.callBack(_listToShow[index]),
                                  _pop,
                                ],
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Text(
                              '${_listToShow[index].name ?? ''} ${widget.suffix ?? ''}',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          );
                        },
                        separatorBuilder:
                            (context, index) => Divider(height: 25.h),
                      ),
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

  Widget get _empty => const SizedBox.shrink();

  void get _pop => Navigator.pop(context);

  void _updateStata(StateSetter newState) => newState(() {});
}
