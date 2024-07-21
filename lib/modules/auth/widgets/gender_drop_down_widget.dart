// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../app/components.dart';
// import '../../../app/functions.dart';
// import '../../../resources/colors_manager.dart';
// import '../../../resources/strings_manager.dart';
// import '../../../resources/styles_manager.dart';
// 
// import '../cubits/gender_cubit/gender_cubit.dart';
// import '../cubits/gender_cubit/gender_state.dart';

// class GenderDropDownWidget extends StatelessWidget {
//   const GenderDropDownWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const MandatoryText(
//             title: StringsManager.gender,
//             bottomPadding: 13,
//             topPadding: 31,
//           ),
//           SizedBox(
//             height: 51,
//             child: BlocBuilder<GenderCubit, GenderState>(
//               builder: (context, state) {
//                 return DropdownButtonFormField2<Gender>(
//                   iconStyleData: const IconStyleData(
//                       icon: Icon(
//                     Icons.keyboard_arrow_down_rounded,
//                     color: ColorsManager.primaryBlue,
//                   )),
//                   dropdownStyleData: DropdownStyleData(
//                     maxHeight: calcHeight(172, context),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(14),
//                       color:
//                           // isDark ? ColorsManager.secondaryBgDark :
//                           ColorsManager.primaryOffWhite,
//                     ),
//                     scrollbarTheme: ScrollbarThemeData(
//                       radius: const Radius.circular(40),
//                       thickness: MaterialStateProperty.all(6),
//                       thumbVisibility: MaterialStateProperty.all(true),
//                     ),
//                   ),
//                   menuItemStyleData: const MenuItemStyleData(
//                     padding: EdgeInsets.symmetric(horizontal: 16),
//                   ),
//                   decoration: InputDecoration(
//                       focusedBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: ColorsManager.borderGrey, width: 0.7)),
//                       enabledBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: ColorsManager.borderGrey, width: 0.7)),
//                       disabledBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: ColorsManager.borderGrey, width: 0.7)),
//                       errorStyle: getRegularStyle(color: ColorsManager.trans),
//                       errorBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: ColorsManager.secondaryBgDarkOpacity50,
//                               width: 1),
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(6))),
//                       contentPadding: const EdgeInsets.only(
//                           left: 12,
//                           top: 12,
//                           bottom: 12),
//                       hintStyle: getRegularStyle(
//                         color: ColorsManager.primaryTxt1LightGrey,
//                         fontSize: 14,
//                       ).copyWith(
//                         letterSpacing: 0.3,
//                       )),
//                   isExpanded: true,
//                   value: state.selectedGender,
//                   onChanged: (gender) {
//                     context.read<GenderCubit>().selectGender(gender!);
//                   },
//                   items: Gender.values.map((gender) {
//                     return DropdownMenuItem<Gender>(
//                       value: gender,
//                       child: Text(
//                         genderToString(gender),
//                         style: Theme.of(context)
//                             .textTheme
//                             .headlineSmall
//                             ?.copyWith(
//                                 fontSize: calculateResponsiveTextSize(
//                                     context, 13)),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
