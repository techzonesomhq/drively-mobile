import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/widgets/style/dotted_divider.dart';

class MyTable extends StatefulWidget {
  final List<Widget> items;
  final int rowCount;
  final double height;

  const MyTable({
    required this.items,
    required this.rowCount,
    required this.height,
    super.key,
  });

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  List<List<Widget>> get items {
    if(widget.rowCount > widget.items.length) return [];
    int columns = 0;
    int mod = widget.items.length % widget.rowCount;
    int divided = widget.items.length ~/ widget.rowCount;
    if (mod == 0) {
      columns = divided;
    } else {
      columns = divided + 1;
    }

    int counter = 0;
    int rowsCounter = 0;

    List<List<Widget>> __ = List<List<Widget>>.generate(columns, (index) => []);

    for (List<Widget> column in __) {
      for (int x = 1; x <= widget.rowCount; x++) {
        if (rowsCounter < widget.rowCount && counter < widget.items.length) {
          column.add(widget.items[counter]);
          rowsCounter++;
          counter++;
        }
      }
      rowsCounter = 0;
    }

    return __;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return _empty;
    return SizedBox(
      width: double.infinity,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return SizedBox(
            height: widget.height.h,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _rowsWithDividers(items[index]),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const DottedDivider(vertical: 0),
        itemCount: items.length,
      ),
    );
  }

  List<Widget> _rowsWithDividers(List<Widget> list) {
    List<Widget> __ = [];

    for (var item in list) {
      int index = list.indexOf(item);
      __.add(Expanded(child: item));
      if (index != list.length - 1) {
        __.add(DottedDivider(axis: Axis.vertical, height: widget.height));
      }
    }
    return __;
  }

  Widget get _empty => const SizedBox.shrink();
}
