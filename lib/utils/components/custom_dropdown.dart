import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    required this.selectedValue,
    required this.dropdownValues,
    required this.onDropdownChanged,
  }) : super(key: key);

  final ValueNotifier<String> selectedValue;
  final List<String> dropdownValues;
  final Function(dynamic) onDropdownChanged;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      shadowColor: AppColors.blackColor.withOpacity(.3),
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColors.lightBlackColor.withOpacity(.9),
          border: Border.all(
            color: AppColors.whiteColor.withOpacity(0),
            width: 1.0,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
        ),
        child: Row(
          children: [
            DropdownButton<String>(
              value: selectedValue.value,
              dropdownColor: AppColors.lightBlackColor,
              underline: const SizedBox(),
              iconEnabledColor: AppColors.whiteColor,
              items: dropdownValues
                  .map((String e) => DropdownMenuItem<String>(
                        // ignore: sort_child_properties_last
                        child: SizedBox(
                          width: size.width * .72,
                          child: Text(
                            e,
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        value: e,
                      ))
                  .toList(),
              onChanged: onDropdownChanged,
            ),
          ],
        ),
      ),
    );
  }
}
