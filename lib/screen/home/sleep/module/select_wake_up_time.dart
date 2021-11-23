import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/screen/home/sleep/widget/drop_down_btn.dart';
import 'package:wecare_flutter/view_model/sleep_view_model.dart';

import '../../../../constants/constants.dart';

class SelectWakeUpTime extends StatelessWidget {
  const SelectWakeUpTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final sleepViewModel = Provider.of<SleepViewModel>(context);

    List<String> listHour = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
    ];

    List<String> listMinute = [
      '00',
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '32',
      '33',
      '34',
      '35',
      '36',
      '37',
      '38',
      '39',
      '40',
      '41',
      '42',
      '43',
      '44',
      '45',
      '46',
      '47',
      '48',
      '49',
      '50',
      '51',
      '52',
      '53',
      '54',
      '55',
      '56',
      '57',
      '58',
      '59',
    ];

    List<String> list = ["AM", "PM"];

    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            child: Text(
              "Select wake up time: ",
              style: oBlackTitle,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropDownBtn(
              listItem: listHour,
              dropdownValue: sleepViewModel.dropdownHourValue,
              onValueChanged: (newValue) {
                sleepViewModel.dropdownHourValue = newValue;
              },
            ),
            Text(
              " : ",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: SizeConfig.blockSizeH! * 7,
                color: sleepColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            DropDownBtn(
              listItem: listMinute,
              dropdownValue: sleepViewModel.dropdownMinuteValue,
              onValueChanged: (newValue) {
                sleepViewModel.dropdownMinuteValue = newValue;
              },
            ),
            const SizedBox(
              width: 15,
            ),
            DropDownBtn(
              listItem: list,
              dropdownValue: sleepViewModel.dropdownValue,
              onValueChanged: (newValue) {
                sleepViewModel.dropdownValue = newValue;
              },
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        CustomBTN(
          height: sizeV * 6.5,
          width: sizeH * 60,
          color: sleepColor,
          name: "Calculate bed time",
          textColor: whiteColor,
          onPressed: () {
            Provider.of<SleepViewModel>(context, listen: false)
                .calculateSleepTime();
            Provider.of<SleepViewModel>(context, listen: false)
                .showBestSleepTime = true;
            Provider.of<SleepViewModel>(context, listen: false)
                .showBestWakeupTime = false;
          },
        ),
      ],
    );
  }
}
