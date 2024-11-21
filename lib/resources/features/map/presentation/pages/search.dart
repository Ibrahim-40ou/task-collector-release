import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasks_collector/resources/core/sizing/size_config.dart';
import 'package:tasks_collector/resources/core/widgets/back_button.dart';
import 'package:tasks_collector/resources/core/widgets/button.dart';
import 'package:tasks_collector/resources/core/widgets/text.dart';
import 'package:tasks_collector/resources/core/widgets/text_form_field.dart';
import 'package:tasks_collector/resources/features/map/presentation/state/bloc/map/functionality/map_functionality_bloc.dart';

import '../../../../core/utils/common_functions.dart';

@RoutePage()
class SearchPage extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _search = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CommonFunctions().darkModeCheck(context);
    return BlocProvider<MapFBloc>(
      create: (context) => MapFBloc(),
      child: BlocBuilder<MapFBloc, MapFStates>(
        builder: (BuildContext context, MapFStates state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state is MapFInitial) {
              _focusNode.requestFocus();
            }
          });
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(2.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(
                      backgroundColor:
                          isDarkMode ? null : Colors.black.withOpacity(0.2),
                      iconColor: isDarkMode ? null : Colors.white,
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      controller: _search,
                      labelText: 'search'.tr(),
                      focusNode: _focusNode,
                      search: () {
                        context.read<MapFBloc>().add(
                              FetchPlaces(placeName: _search.text),
                            );
                      },
                      isSearch: true,
                      maxLines: 1,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _search.clear();
                        },
                        icon: Icon(
                          Iconsax.close_circle,
                          size: 4.w,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    state is PlacesFetchFailure
                        ? Expanded(
                            child: Center(
                              child: CustomText(
                                text: CommonFunctions()
                                    .handleErrorMessage(state.failure),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              itemCount: state is PlacesFetched
                                  ? state.placesInformation.length
                                  : state is PlacesFetchLoading
                                      ? 3
                                      : 0,
                              itemBuilder: (BuildContext context, int index) {
                                if (state is PlacesFetchLoading) {
                                  return CustomButton(
                                    function: () {},
                                    disabled: true,
                                    height: 6.h,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          size: 6.w,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        SizedBox(width: 2.w),
                                        Shimmer.fromColors(
                                          baseColor: const Color(0xFFCCCCCC),
                                          highlightColor: Colors.white,
                                          child: Container(
                                            width: 30.w,
                                            height: 1.h,
                                            color: const Color(0xFFCCCCCC),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                } else if (state is PlacesFetched) {
                                  return CustomButton(
                                    function: () {
                                      context.router.popForced(state
                                          .placesInformation[index]
                                          .coordinates);
                                    },
                                    height: 6.h,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          size: 6.w,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        SizedBox(width: 2.w),
                                        SizedBox(
                                          width: 88.w,
                                          child: CustomText(
                                            text: state.placesInformation[index]
                                                .place.placeName,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: Divider(
                                    color: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .color,
                                    height: 0.5.h,
                                  ),
                                );
                              },
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
