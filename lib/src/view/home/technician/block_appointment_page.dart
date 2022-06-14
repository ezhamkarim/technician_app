import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:technician_app/src/helper/dialog_helper.dart';

import '../../../controller/time_slot_controller.dart';
import '../../../model/time_slot_model.dart';
import '../../../provider/root_provider.dart';
import '../../../style/custom_style.dart';

class BlockAppointmentPage extends StatefulWidget {
  const BlockAppointmentPage({Key? key}) : super(key: key);
  static const routeName = '/index/block';
  @override
  State<BlockAppointmentPage> createState() => _BlockAppointmentPageState();
}

class _BlockAppointmentPageState extends State<BlockAppointmentPage> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.twoWeeks;
  DateTime? _selectedDay;
  bool daySelected = false;
  final timeSlotController = TimeSlotController();
  RootProvider? rootProvider;
  List<TimeSlot> timeSlots = [];
  List<TimeSlot> timeSlotsTemplate = [
    TimeSlot(
        id: '',
        technicianId: '',
        time: '9:00 AM',
        date: DateTime.now(),
        isBooked: false,
        bookingId: '',
        userId: ''),
    TimeSlot(
        id: '',
        technicianId: '',
        time: '10:00 AM',
        date: DateTime.now(),
        isBooked: false,
        bookingId: '',
        userId: ''),
    TimeSlot(
        id: '',
        technicianId: '',
        time: '11:00 AM',
        date: DateTime.now(),
        isBooked: false,
        bookingId: '',
        userId: ''),
    TimeSlot(
        id: '',
        technicianId: '',
        time: '12:00 PM',
        date: DateTime.now(),
        isBooked: false,
        bookingId: '',
        userId: ''),
    TimeSlot(
        id: '',
        technicianId: '',
        time: '1:00 PM',
        date: DateTime.now(),
        isBooked: false,
        bookingId: '',
        userId: ''),
    TimeSlot(
        id: '',
        technicianId: '',
        time: '2:00 PM',
        date: DateTime.now(),
        isBooked: false,
        bookingId: '',
        userId: ''),
    TimeSlot(
        id: '',
        technicianId: '',
        time: '3:00 PM',
        date: DateTime.now(),
        isBooked: false,
        bookingId: '',
        userId: ''),
    TimeSlot(
        id: '',
        technicianId: '',
        time: '4:00 PM',
        date: DateTime.now(),
        isBooked: false,
        bookingId: '',
        userId: ''),
    TimeSlot(
        id: '',
        technicianId: '',
        time: '5:00 PM',
        date: DateTime.now(),
        isBooked: false,
        bookingId: '',
        userId: '')
  ];
  @override
  void initState() {
    rootProvider = context.read<RootProvider>();
    super.initState();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      if (_selectedDay != null) {
        daySelected = true;
      }
      // var selectedDayFromDb;
      _getSelectedDays();
      // DatabaseService().listOfLabBookingForADay(selectedDay).listen((event) {
      //   _selectedEvents.value = _getEventsForDay(selectedDay, list: event);
      // });
    }
  }

  void _getSelectedDays() {
    final firebaseUser = context.read<User>();
    timeSlotController
        .readForBooking(_selectedDay!, firebaseUser.uid)
        .listen((event) {
      //logInfo('Event $event Focused Day $focusedDay');
      setState(() {
        List<TimeSlot> tempTemplate = timeSlotsTemplate;
        if (event.isEmpty) {
          for (var element in tempTemplate) {
            element.isBooked = false;
          }
          timeSlots = tempTemplate;
        } else {
          for (var element in tempTemplate) {
            element.isBooked = false;
          }
          for (var i = 0; i < event.length; i++) {
            var index = tempTemplate
                .indexWhere((element) => element.time == event[i].time);

            if (index != -1) {
              tempTemplate[index] = event[i];
            }
          }
          timeSlots = tempTemplate;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Text(
                    'Booked Appointment.',
                    style: CustomStyle.getStyle(
                        Colors.black, FontSizeEnum.title, FontWeight.bold),
                  ),
                ),
              ],
            ),
            TableCalendar(
              availableGestures: AvailableGestures.horizontalSwipe,
              focusedDay: _focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2023, 1, 1),
              calendarFormat: calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    calendarFormat = format;
                  });
                }
              },
            ),
            GridView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: timeSlots.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      for (var timeSlot in timeSlots) {
                        timeSlot.isSelected = false;
                      }
                      timeSlots[i].isSelected = !timeSlots[i].isSelected;
                    });
                  },
                  child: Card(
                      color: timeSlots[i].isSelected
                          ? CustomStyle.primarycolor
                          : timeSlots[i].isBooked
                              ? CustomStyle.secondaryColor.withOpacity(0.2)
                              : CustomStyle.secondaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                timeSlots[i].time,
                                style: CustomStyle.getStyle(Colors.white,
                                    FontSizeEnum.content2, FontWeight.normal),
                              ),
                            ],
                          ),
                          timeSlots[i].isBooked
                              ? Container()
                              : IconButton(
                                  onPressed: () async {
                                    timeSlots[i].date = _focusedDay;
                                    timeSlots[i].isBooked = true;
                                    timeSlots[i].userId = firebaseUser.uid;
                                    timeSlots[i].technicianId =
                                        firebaseUser.uid;
                                    await DialogHelper.dialogWithAction(
                                        context,
                                        'Block Appointment',
                                        'Are you sure to block this time slot?',
                                        onPressed: () async {
                                      await timeSlotController
                                          .create(timeSlots[i]);
                                      Navigator.of(context).pop();
                                    });

                                    _getSelectedDays();
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.stop,
                                    color: Colors.white,
                                  ))
                        ],
                      )),
                );
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
            ),
          ],
        ),
      )),
    );
  }
}
