import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:technician_app/src/controller/booking_controller.dart';
import 'package:technician_app/src/controller/time_slot_controller.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/booking_model.dart';
import 'package:technician_app/src/model/time_slot_model.dart';
import 'package:technician_app/src/view/home/customer/services_list_selection_page.dart';
import 'package:technician_app/src/view/home/customer/technician_list_page.dart';

import '../../../provider/root_provider.dart';
import '../../../style/custom_style.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/custom_card.dart';

class BookingCreatePage extends StatefulWidget {
  const BookingCreatePage({Key? key}) : super(key: key);
  static const routeName = '/index/createbooking';
  @override
  State<BookingCreatePage> createState() => _BookingCreatePageState();
}

class _BookingCreatePageState extends State<BookingCreatePage> {
  final formKey = GlobalKey<FormState>();
  final timeSlotController = TimeSlotController();
  final bookingController = BookingController();
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
        userId: '')
  ];
  DateTime _focusedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.twoWeeks;
  DateTime? _selectedDay;
  bool daySelected = false;
  RootProvider? rootProvider;
  // List<LabBookingModel> _getEventsForDay(DateTime? day,
  //     {List<LabBookingModel>? list}) {
  //   // Implementation example
  //   return day == null ? [] : list ?? [];
  // }
  @override
  void initState() {
    rootProvider = context.read<RootProvider>();
    super.initState();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (rootProvider == null) {
      return;
    }
    if (!isSameDay(_selectedDay, selectedDay) &&
        rootProvider?.technician != null) {
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
    var technicianId = rootProvider?.technician;
    if (technicianId == null) return;
    timeSlotController
        .readForBooking(_selectedDay!, technicianId.id)
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
    var rootProvider = context.watch<RootProvider>();
    final firebaseUser = context.watch<User>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    BackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      'Create Booking.',
                      style: CustomStyle.getStyle(
                          Colors.black, FontSizeEnum.title, FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                CustomOutlinedCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(rootProvider.technician == null
                          ? 'Select Technician'
                          : rootProvider.technician!.name),
                      const FaIcon(FontAwesomeIcons.chevronRight)
                    ],
                  ),
                  onTap: () async {
                    await Navigator.of(context)
                        .pushNamed(TechnicianListPage.routeName);
                    _getSelectedDays();
                  },
                ),
                const SizedBox(
                  height: 48,
                ),
                CustomOutlinedCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(rootProvider.services.isEmpty
                            ? 'Select services'
                            : rootProvider.services.toString()),
                      ),
                      const FaIcon(FontAwesomeIcons.chevronRight)
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ServiceListPageSelection.routeName);
                  },
                ),
                const SizedBox(
                  height: 48,
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
                const SizedBox(
                  height: 48,
                ),
                GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: timeSlots.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        if (timeSlots[i].isBooked == false) {
                          setState(() {
                            timeSlots[i].isSelected = !timeSlots[i].isSelected;
                            // logInfo('hei ${timeSlots[i].isBooked}');
                            // if (timeSlots[i].isSelected = true) {
                            //   for (var i = 0; i < timeSlots.length; i++) {
                            //     if (timeSlots[i].isBooked == false) {
                            //       timeSlots[i].isSelected = false;
                            //     }
                            //   }
                            // }
                          });
                        }
                      },
                      child: Card(
                          color: timeSlots[i].isBooked
                              ? CustomStyle.secondaryColor.withOpacity(0.2)
                              : timeSlots[i].isSelected
                                  ? CustomStyle.primarycolor
                                  : CustomStyle.secondaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                timeSlots[i].time,
                                style: CustomStyle.getStyle(Colors.white,
                                    FontSizeEnum.content2, FontWeight.normal),
                              ),
                            ],
                          )),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 4 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                ),
                const SizedBox(
                  height: 48,
                ),
                Row(
                  children: [
                    Text(
                      'TOTAL : RM ${rootProvider.total.toString()}',
                      style: CustomStyle.getStyle(
                          Colors.black, FontSizeEnum.content2, FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: AuthButton(
                          viewState: rootProvider.viewState,
                          onPressed: () async {
                            List<TimeSlot> selectedTimeSlots = [];
                            // if (rootProvider != null) return;
                            if (rootProvider.technician == null) return;

                            if (rootProvider.services.isEmpty) return;

                            for (var i = 0; i < timeSlots.length; i++) {
                              if (timeSlots[i].isSelected == true) {
                                timeSlots[i].date = _focusedDay;
                                timeSlots[i].isBooked = true;
                                timeSlots[i].userId = firebaseUser.uid;
                                selectedTimeSlots.add(timeSlots[i]);
                              }
                            }

                            if (selectedTimeSlots.isEmpty) return;
                            var bookingModel = Booking(
                                customerName:
                                    rootProvider.userModel?.name ?? '',
                                customerId: firebaseUser.uid,
                                estimateTime:
                                    DateTime.now().add(const Duration(days: 2)),
                                id: '',
                                services: rootProvider.services,
                                dateTime: DateTime.now(),
                                timeSlot: [],
                                total: rootProvider.total,
                                requests: [],
                                status: 'WAITING APPROVAL',
                                isFeedback: false,
                                feedbackId: '',
                                technicianId: rootProvider.technician!.id,
                                technicianName: rootProvider.technician!.name,
                                phoneNumberTechnician:
                                    rootProvider.technician!.phoneNumber);
                            var bookingResult = await bookingController.create(
                                bookingModel, rootProvider);

                            if (bookingResult == null) return;

                            for (var i = 0; i < selectedTimeSlots.length; i++) {
                              selectedTimeSlots[i].bookingId = bookingResult.id;
                              selectedTimeSlots[i].technicianId =
                                  rootProvider.technician!.id;
                              logSuccess(
                                  'Time Slots ${selectedTimeSlots[i].toMap()}');
                            }

                            await Future.forEach<TimeSlot>(selectedTimeSlots,
                                (item) async {
                              await timeSlotController.create(item);
                            });
                            bookingModel.timeSlot = selectedTimeSlots;
                            await bookingController.update(
                                bookingModel, rootProvider);
                            logSuccess('Booking Model ${bookingModel.toMap()}');
                            rootProvider.resetNotifier();
                            Navigator.of(context).pop();
                          },
                          color: CustomStyle.primarycolor,
                          child: const Text('Create')),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
