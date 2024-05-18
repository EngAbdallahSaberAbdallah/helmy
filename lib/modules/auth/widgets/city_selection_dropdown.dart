import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components.dart';
import '../../../helpers/validation.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../cubits/get_cities_cubit/get_cities_cubit.dart';
import '../cubits/governorate_and_city_cubit/governorate_and_city_cubit.dart';

class CitySelection extends StatelessWidget {
  final String countryName;
  final TextEditingController countryIdController;
  const CitySelection({super.key, required this.countryName, required this.countryIdController});

  @override
  Widget build(BuildContext context) {
    final cityCubit = context.read<CityCubit>();

    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          BlocBuilder<GetCitiesCubit, GetCitiesState>(
            builder: (context, state) {
              if (state is CitiesLoading) {
                print('list of countries still loading...');
                return BlocBuilder<CityCubit, String?>(
                  builder: (context, selectedCity) {
                    return CustomDropdownButtonFormFiled(
                      validator: (value) =>
                          ValidationHelper.validateCity(context, value),
                      hintText: StringsManager.loading,
                      value: selectedCity,
                      items: const [
                        DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.centerStart,
                          value: StringsManager.loading,
                          child: Text(''),
                        )
                      ],
                      dropDownKey: GlobalKey<FormFieldState<String>>(),
                    );
                  },
                );
              } else if (state is CitiesSuccess) {
                print('list of countries are ${state.citiesData}');
                return BlocBuilder<CityCubit, String?>(
                  builder: (context, selectedCity) {
                    if (countryName != "") {
                      selectedCity = countryName;
                    }
                    return CustomDropdownButtonFormFiled(
                      dropDownKey: GlobalKey<FormFieldState<String>>(),
                      validator: (value) =>
                          ValidationHelper.validateCity(context, value),
                      hintText: StringsManager.chooseGovernorate,
                      value: selectedCity,
                      onChanged: (selectedCity) {
                        // areasCubit.resetArea();
                        cityCubit.selectCity(selectedCity!);
                      },
                      items: state.citiesData.map((governorate) {
                        return DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.centerStart,
                          value: governorate.name!.ar.toString(),
                          child: Text(
                            governorate.name!.ar.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontSize: AppSize.s13),
                          ),
                        );
                      }).toList(),
                    );
                  },
                );
              } else if (state is CitiesError) {
                return BlocBuilder<CityCubit, String?>(
                  builder: (context, selectedCity) {
                    return CustomDropdownButtonFormFiled(
                        dropDownKey: GlobalKey<FormFieldState<String>>(),
                        validator: (value) =>
                            ValidationHelper.validateCity(context, value),
                        hintText: StringsManager.errorWhenLoadingData,
                        // value: selectedCity,
                        items: const [
                          DropdownMenuItem<String>(
                            alignment: AlignmentDirectional.centerStart,
                            value: StringsManager.errorWhenLoadingData,
                            child: Text(''),
                          )
                        ]);
                  },
                );
              } else {
                return BlocBuilder<CityCubit, String?>(
                  builder: (context, selectedCity) {
                    return CustomDropdownButtonFormFiled(
                      dropDownKey: GlobalKey<FormFieldState<String>>(),
                      validator: (value) =>
                          ValidationHelper.validateCity(context, value),
                      hintText: StringsManager.chooseGovernorate,
                      value: selectedCity,
                      onChanged: (selectedCity) {
                        // areasCubit.resetArea();
                        cityCubit.selectCity(selectedCity!);
                      },
                      items: context
                          .read<GetCitiesCubit>()
                          .citiesData
                          .map((governorate) {
                        return DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.centerStart,
                          value: governorate.name!.ar.toString(),
                          child: Text(governorate.name!.ar.toString()),
                        );
                      }).toList(),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
