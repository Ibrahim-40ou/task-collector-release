import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tasks_collector/resources/core/routing/routes.gr.dart';
import 'package:tasks_collector/resources/core/sizing/size_config.dart';
import 'package:tasks_collector/resources/core/widgets/button.dart';
import 'package:tasks_collector/resources/core/widgets/loading_indicator.dart';
import 'package:tasks_collector/resources/core/widgets/text.dart';
import 'package:tasks_collector/resources/core/widgets/text_form_field.dart';

import '../../../../core/widgets/back_button.dart';
import '../state/bloc/map/map_bloc.dart';

@RoutePage()
class MapPage extends StatelessWidget {
  final LatLng currentPosition;
  final bool isForShow;
  late LatLng centerPosition;
  final TextEditingController _search = TextEditingController();

  MapPage({
    super.key,
    required this.currentPosition,
    required this.isForShow,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapBloc>(create: (context) => MapBloc()),
        BlocProvider<PinAnimationCubit>(
            create: (context) => PinAnimationCubit()),
      ],
      child: BlocBuilder<MapBloc, MapStates>(
        builder: (BuildContext context, MapStates state) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              if (state is MapReady) {
                context.read<MapBloc>().add(Refresh());
              }
            },
          );

          return WillPopScope(
            onWillPop: () async {
              context.read<MapBloc>().add(DisposeMap());
              return Future.value(true);
            },
            child: SafeArea(
              child: Scaffold(
                body: Stack(
                  children: [
                    state is MapReady || state is MapInitial
                        ? GoogleMap(
                            myLocationButtonEnabled: isForShow,
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            initialCameraPosition: CameraPosition(
                              target: currentPosition,
                              zoom: 15,
                            ),
                            onMapCreated: (mapController) {
                              context
                                  .read<MapBloc>()
                                  .add(InitializeMap(mapController));
                            },
                            onCameraMove: (CameraPosition position) {
                              context.read<PinAnimationCubit>().moveUp();
                              if (!isForShow) {
                                centerPosition = position.target;
                              }
                            },
                            onCameraIdle: () async {
                              context.read<PinAnimationCubit>().reset();
                              if (!isForShow) {
                                List<Placemark> placeMarks =
                                    await placemarkFromCoordinates(
                                  centerPosition.latitude,
                                  centerPosition.longitude,
                                );
                                _search.text =
                                    '${placeMarks[0].locality} ${placeMarks[0].subAdministrativeArea} ${placeMarks[0].street}';
                              }
                            },
                            markers: {
                              isForShow
                                  ? Marker(
                                      markerId:
                                          const MarkerId('initial_marker'),
                                      position: currentPosition,
                                    )
                                  : Marker(
                                      markerId: const MarkerId('none'),
                                    ),
                            },
                          )
                        : Center(
                            child: CustomLoadingIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                    isForShow
                        ? Container()
                        : state is MapReady
                            ? BlocBuilder<PinAnimationCubit, bool>(
                                builder: (context, state) {
                                return Center(
                                  child: AnimatedPadding(
                                    padding: EdgeInsets.only(
                                      bottom: state ? 7.5.h : 4.5.h,
                                    ),
                                    duration: Duration(milliseconds: 100),
                                    child: SvgPicture.asset(
                                      'assets/images/pin.svg',
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      height: 5.h,
                                      width: 5.h,
                                    ),
                                  ),
                                );
                              })
                            : Container(),
                    Positioned(
                      top: 2.w,
                      left: 2.w,
                      child: CustomBackButton(
                        backgroundColor: Colors.black.withOpacity(0.2),
                        iconColor: Colors.white,
                        function: () {
                          context.read<MapBloc>().add(DisposeMap());
                        },
                      ),
                    ),
                    isForShow
                        ? Container()
                        : Positioned(
                            bottom: 0.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: CustomButton(
                                    height: 6.h,
                                    width: 6.h,
                                    function: () {
                                      context
                                          .read<MapBloc>()
                                          .mapController
                                          ?.animateCamera(
                                            CameraUpdate.newLatLng(
                                                currentPosition),
                                          );
                                    },
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    child: Icon(
                                      Icons.my_location_outlined,
                                      size: 6.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4.w,
                                    horizontal: 2.w,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomField(
                                        controller: _search,
                                        labelText: 'search'.tr(),
                                        isLabelVisible: false,
                                        width: 96.w,
                                        readOnly: true,
                                        onTap: () async {
                                          LatLng? latLng = await context.router
                                              .push<LatLng>(SearchRoute());
                                          if (latLng != null) {
                                            context
                                                .read<MapBloc>()
                                                .mapController
                                                ?.animateCamera(
                                                  CameraUpdate.newLatLng(
                                                      latLng),
                                                );
                                          }
                                        },
                                        color: Colors.black,
                                      ),
                                      SizedBox(height: 1.h),
                                      CustomButton(
                                        height: 6.h,
                                        width: 96.w,
                                        function: () {
                                          context.router
                                              .popForced(centerPosition);
                                        },
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: CustomText(
                                          text: 'confirm location'.tr(),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PinAnimationCubit extends Cubit<bool> {
  PinAnimationCubit() : super(false);

  void moveUp() => emit(true);

  void reset() => emit(false);
}
