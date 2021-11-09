import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/view_model/weekly_calendar_viewmodel.dart';

class WeeklyCalendar extends StatelessWidget {
  WeeklyCalendar({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

 
  DateTime _initialDate = DateTime.now();

  Future _pickDate(BuildContext context) async {
    DateTime? _selectedDate;

    _selectedDate = await showDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (_selectedDate == null) return;

    var changeDate = context.read<CalendarViewModel>();
    changeDate.changeCalendar(_selectedDate);
    _initialDate = _selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeV! * 6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => _pickDate(context),
            icon: Icon(
              Icons.event_note,
              color: color,
              size: SizeConfig.blockSizeV! * 5,
            ),
          ),
          SizedBox(width: SizeConfig.blockSizeH! * 2),
          Consumer<CalendarViewModel>(
            builder: (context, calendarViewModel, child) => Text(
              calendarViewModel.time,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: SizeConfig.blockSizeV! * 3.4,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
