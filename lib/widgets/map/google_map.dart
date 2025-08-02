import 'package:app/consts/app_consts.dart';
import 'package:app/helpers/converter_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  final LatLng? latLng;
  final Function(LatLng)? onTap;
  final double topPadding;
  final bool enableTap;
  final double height;
  final double? width;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool zoomEnabled;
  final double zoom;
  final bool customIcon;

  const CustomGoogleMap({
    this.latLng,
    this.onTap,
    this.topPadding = 0,
    this.enableTap = false,
    this.height = 200,
    this.width,
    this.myLocationEnabled = true,
    this.myLocationButtonEnabled = true,
    this.zoomEnabled = true,
    this.zoom = 14,
    this.customIcon = false,
    super.key,
  });

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap>
    with ConverterHelper {
  late GoogleMapController googleMapController;

  LatLng get _target => widget.latLng ?? const LatLng(AppConsts.defaultLat, AppConsts.defaultLon);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height.h,
      width: widget.width == null ? double.infinity : widget.width!.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: GoogleMap(
          initialCameraPosition:
              CameraPosition(zoom: widget.zoom, target: _target),
          // onMapCreated: (_) => setState(() => googleMapController = _),
          onMapCreated: (__) async {
            setState(() {
              googleMapController = __;
            });
            if (widget.customIcon) {
              var icon = await convertAssetToBitmap(
                'assets/icons/location_icon.png',
                width: 40,
              );
              setState(() {
                markers.add(Marker(
                  markerId: const MarkerId('icon'),
                  position: _target,
                  icon: icon,
                ));
              });
            } else {
              setState(() {
                markers.add(
                    Marker(markerId: const MarkerId(''), position: _target));
              });
            }
          },
          myLocationEnabled: widget.myLocationEnabled,
          myLocationButtonEnabled: widget.myLocationButtonEnabled,
          onTap: widget.enableTap
              ? (__) async => await _selectNewLocation(__)
              : null,
          // markers: {Marker(markerId: const MarkerId(''), position: _target)},
          markers: markers,
          padding: EdgeInsets.only(top: widget.topPadding.h),
          zoomControlsEnabled: widget.zoomEnabled,
          zoomGesturesEnabled: widget.zoomEnabled,
        ),
      ),
    );
  }

  Future<void> _selectNewLocation(LatLng __) async {
    if (widget.onTap != null) {
      widget.onTap!(__);
      await googleMapController.animateCamera(CameraUpdate.newLatLng(__));
    }
  }
}
