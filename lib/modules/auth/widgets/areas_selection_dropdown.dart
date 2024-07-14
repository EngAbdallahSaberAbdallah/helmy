import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/components.dart';
import '../../../app/functions.dart';
import '../../../helpers/validation.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../cubits/get_cities_cubit/get_cities_cubit.dart';
import '../cubits/governorate_and_city_cubit/governorate_and_city_cubit.dart';

class AreasSelection extends StatefulWidget {
  final String areaName;
  final String cityName;
  final TextEditingController areaIdController;
  const AreasSelection(
      {Key? key,
      required this.areaName,
      required this.cityName,
      required this.areaIdController})
      : super(key: key);

  @override
  State<AreasSelection> createState() => _AreasSelectionState();
}

class _AreasSelectionState extends State<AreasSelection> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCitiesCubit, GetCitiesState>(
      builder: (context, state) {
        var citiesData = context.read<GetCitiesCubit>().citiesData;
        return Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               MandatoryText(
                title: tr(StringsManager.country),
                bottomPadding: AppSize.s13,
                topPadding: AppSize.s31,
              ),
              BlocBuilder<CityCubit, String?>(
                builder: (context, selectedCity) {
                  return BlocBuilder<AreasCubit, String?>(
                    builder: (context, selectedArea) {
                      List<String> areaItems = buildAreaItems(
                          selectedCity: selectedCity ?? widget.cityName,
                          citiesData: citiesData);

                      if (widget.areaName != '') {
                        if (counter >= 0 && counter <= 1) {
                          counter++;
                          selectedArea = widget.areaName;
                          context
                              .read<AreasCubit>()
                              .selectArea(widget.areaName);
                        }
                        // else {
                        //   if (selectedArea != null || selectedArea != "") {
                        //     selectedArea =
                        //         areaItems.isNotEmpty ? areaItems[0] : "";
                        //   }
                        // }
                      }
                      debugPrint(
                          'Selected Area: $selectedArea and area name is ${widget.areaName}');

                      // rAreaIdController.text = areaItems
                      //     .indexWhere((area) => area == selectedArea)
                      //     .toString();

                      // print(
                      //     'area Id is ${areaItems.indexWhere((area) => area == selectedArea).toString()}');

                      // print('I am Here $selectedArea');
                      // debugPrint('areaItems : ${areaItems[0]} *************');

                      return CustomDropdownButtonFormFiled(
                        dropDownKey: GlobalKey<FormFieldState<String>>(),
                        validator: (value) =>
                            ValidationHelper.validateArea(context, value),
                        value: selectedArea,
                        onChanged: (selectedArea) {
                          // setState(() {
                          context.read<AreasCubit>().selectArea(selectedArea);

                          // final citiesList = citiesData.firstWhere(
                          //   (city) =>
                          //       city.name!.ar.toString() == selectedCity,
                          //   orElse: () =>
                          //       CitiesData(), // Provide a default CitiesData instance
                          // );

                          // List<Areas> area =
                          //     citiesList.areas!.map((area) => area).toList();

                          // rAreaIdController.text = area.isNotEmpty
                          //     ? area
                          //         .firstWhere((element) =>
                          //             element.name!.ar.toString() ==
                          //             selectedArea)
                          //         .id!
                          //         .toString()
                          //     : '0';

                          // print(
                          //     'area ${area.isNotEmpty ? area.firstWhere((element) => element.name!.ar.toString() == selectedArea).id!.toString() : '0'}');

                          // print(
                          //     'area id at area selection is ${area.isNotEmpty ? area.firstWhere((element) => element.name!.ar.toString() == selectedArea).id! : 0}');
                          // debugPrint(
                          //     '${findAreaIdByName(citiesData, selectedArea!)} IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIDDDDDDDDDDD');
                          // });
                        },
                        hintText: tr(StringsManager.chooseCountry),
                        items:
                            // areaItems.isEmpty
                            //     ? null
                            //     :
                            areaItems.map((area) {
                          return DropdownMenuItem<String>(
                            alignment: AlignmentDirectional.centerStart,
                            value: area,
                            child: Text(
                              area,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontSize: AppSize.s12.sp),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../app/components.dart';
// import '../../../app/functions.dart';
// import '../../../helpers/validation.dart';
// import '../../../resources/strings_manager.dart';
// import '../../../resources/values_manager.dart';
// import '../cubits/get_cities_cubit/get_cities_cubit.dart';
// import '../cubits/governorate_and_city_cubit/governorate_and_city_cubit.dart';

// class AreasSelection extends StatefulWidget {
//   final String areaName;
//   final String cityName;
//   const AreasSelection({
//     Key? key,
//     required this.areaName,
//     required this.cityName,
//   }) : super(key: key);

//   @override
//   State<AreasSelection> createState() => _AreasSelectionState();
// }

// class _AreasSelectionState extends State<AreasSelection> {
//   int counter = 0;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GetCitiesCubit, GetCitiesState>(
//       builder: (context, state) {
//         var citiesData = context.read<GetCitiesCubit>().citiesData;
//         return Flexible(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const MandatoryText(
//                 title: StringsManager.governorate,
//                 bottomPadding: AppSize.s13,
//                 topPadding: AppSize.s31,
//               ),
//               BlocBuilder<CityCubit, String?>(
//                 builder: (context, selectedCity) {
//                   return BlocBuilder<AreasCubit, String?>(
//                     builder: (context, selectedArea) {
//                       debugPrint('Selected Area: $selectedArea');

//                       List<String> areaItems = buildAreaItems(
//                           selectedCity: selectedCity, citiesData: citiesData);

//                       debugPrint('areaItems : $areaItems *************');

//                       return CustomDropdownButtonFormFiled(
//                         dropDownKey: GlobalKey<FormFieldState<String>>(),
//                         validator: (value) =>
//                             ValidationHelper.validateArea(context, value),
//                         value: selectedArea,
//                         onChanged: (selectedArea) {
//                           context.read<AreasCubit>().selectArea(selectedArea);
//                           debugPrint(
//                               '${findAreaIdByName(citiesData, selectedArea!)} IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIDDDDDDDDDDD');
//                         },
//                         hintText: StringsManager.chooseArea,
//                         items: areaItems.isEmpty
//                             ? null
//                             : areaItems.map((area) {
//                                 return DropdownMenuItem<String>(
//                                   alignment: AlignmentDirectional.centerStart,
//                                   value: area,
//                                   child: Text(
//                                     area,
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headlineSmall
//                                         ?.copyWith(
//                                             fontSize:
//                                                 calculateResponsiveTextSize(
//                                                     context, AppSize.s13)),
//                                   ),
//                                 );
//                               }).toList(),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GetCitiesCubit, GetCitiesState>(
//       builder: (context, state) {
//         var citiesData = context.read<GetCitiesCubit>().citiesData;
//         return Flexible(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const MandatoryText(
//                 title: StringsManager.city,
//                 bottomPadding: AppSize.s13,
//                 topPadding: AppSize.s31,
//               ),
//               BlocBuilder<CityCubit, String?>(
//                 builder: (context, selectedCity) {
//                   return BlocBuilder<AreasCubit, String?>(
//                     builder: (context, selectedArea) {
//                       debugPrint('Selected Area: $selectedArea');
//
//                       List<String> areaItems = buildAreaItems(
//                           selectedCity: selectedCity ?? widget.cityName,
//                           citiesData: citiesData);
//
//                       if (widget.areaName != '') {
//                         if (counter >= 0 && counter <= 1) {
//                           counter++;
//                           selectedArea = widget.areaName;
//                         } else {
//                           selectedArea = areaItems[0];
//                         }
//                       }
//                       print('I am Here $selectedArea');
//                       debugPrint('areaItems : $areaItems *************');
//
//                       return CustomDropdownButtonFormFiled(
//                         dropDownKey: GlobalKey<FormFieldState<String>>(),
//                         validator: (value) =>
//                             ValidationHelper.validateArea(context, value),
//                         value: selectedArea,
//                         onChanged: (selectedArea) {
//                           setState(() {
//                             context.read<AreasCubit>().selectArea(selectedArea);
//                             final citiesList = citiesData.firstWhere(
//                               (city) =>
//                                   city.name!.ar.toString() == selectedCity,
//                               orElse: () =>
//                                   CitiesData(), // Provide a default CitiesData instance
//                             );
//                             List<Areas> area =
//                                 citiesList.areas!.map((area) => area).toList();
//
//                             rAreaIdController = area.isNotEmpty
//                                 ? area
//                                     .firstWhere((element) =>
//                                         element.name!.ar.toString() ==
//                                         selectedArea)
//                                     .id!
//                                 : 0;
//
//                             print('area ${rAreaIdController}');
//
//                             print(
//                                 'area id at area selection is ${area.isNotEmpty ? area.firstWhere((element) => element.name!.ar.toString() == selectedArea).id! : 0}');
//                             debugPrint(
//                                 '${findAreaIdByName(citiesData, selectedArea!)} IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIDDDDDDDDDDD');
//                           });
//                         },
//                         hintText: StringsManager.chooseArea,
//                         items:
//                             // areaItems.isEmpty
//                             //     ? null
//                             //     :
//                             areaItems.map((area) {
//                           return DropdownMenuItem<String>(
//                             alignment: AlignmentDirectional.centerStart,
//                             value: area,
//                             child: Text(
//                               area,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineSmall
//                                   ?.copyWith(fontSize: AppSize.s12),
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

