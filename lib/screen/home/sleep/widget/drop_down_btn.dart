import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/view_model/sleep_view_model.dart';

class DropDownBtn extends StatelessWidget {
  final List<String> listItem;
  final String dropdownValue;
  final Function(String? newValue) onValueChanged;
  const DropDownBtn({
    Key? key,
    required this.listItem,
    required this.dropdownValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Container(
      width: sizeH * 14.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: sleepColor,
          width: 1,
        ),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: sleepColor,
          ),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            color: Colors.transparent,
          ),
          menuMaxHeight: sizeV * 48,
          borderRadius: BorderRadius.circular(8),
          onChanged: (newValue) => onValueChanged(newValue),
          items: listItem.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.blockSizeH! * 4,
                  color: sleepColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
