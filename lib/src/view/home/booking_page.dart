import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/booking_controller.dart';
import 'package:technician_app/src/helper/dialog_helper.dart';
import 'package:technician_app/src/view/home/booking_description_page.dart';
import 'package:technician_app/src/view/home/chat_page.dart';
import 'package:technician_app/src/view/widgets/create_button.dart';

import '../../controller/user_controller.dart';
import '../../helper/general_helper.dart';
import '../../helper/size_helper.dart';
import '../../model/booking_model.dart';
import '../../model/user_model.dart';
import '../../provider/root_provider.dart';
import '../../style/custom_style.dart';
import '../widgets/custom_card.dart';
import 'customer/booking_create_page.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final bookingController = BookingController();
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();
    var firebaseUser = context.watch<User>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: Column(children: [
          StreamBuilder<UserModel>(
              stream: UserController(firebaseUser.uid).read(rootProvider),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userModel = snapshot.data!;
                  var role = GeneralHelper.getRole(userModel.role);
                  switch (role) {
                    case Role.technician:
                      return buildTechnicianBooking(firebaseUser);
                    case Role.customer:
                      return buildCustomerBooking(firebaseUser);
                    default:
                      return Container();
                  }
                } else {
                  return Text('Error ${snapshot.error}');
                }
              })
        ]),
      ),
    );
  }

  Widget buildTechnicianBooking(User user) {
    var rootProvider = context.read<RootProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<List<Booking>>(
            stream: bookingController.readForTechnician(user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: CustomStyle.primarycolor,
                );
              } else {
                if (snapshot.hasData) {
                  var booking = snapshot.data!;
                  List<Booking> bookingInProgress = [];
                  List<Booking> bookingHistory = [];
                  try {
                    bookingInProgress = booking
                        .where(
                          (element) =>
                              element.status == 'IN PROGRESS' ||
                              element.status == 'WAITING APPROVAL' ||
                              element.status == 'APPROVED',
                        )
                        .toList();
                    bookingHistory = booking
                        .where(
                          (element) => element.status == 'COMPLETED',
                        )
                        .toList();
                  } catch (e) {}
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking.',
                        style: CustomStyle.getStyle(
                            Colors.black, FontSizeEnum.title, FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 42,
                      ),
                      Text(
                        'In Progress',
                        style: CustomStyle.getStyle(
                            Colors.black, FontSizeEnum.title2, FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 150,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: scrollController,
                          child: ListView.builder(
                            itemCount: bookingInProgress.length,
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return SizedBox(
                                  width: SizeHelper(context).scaledWidth() - 64,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          BookingDescriptionPage.routeName,
                                          arguments: {
                                            'booking': bookingInProgress[i],
                                            'role': Role.technician
                                          });
                                    },
                                    child: CustomCard(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  bookingInProgress[i]
                                                      .services[0]
                                                      .name,
                                                  style: CustomStyle.getStyle(
                                                      Colors.white,
                                                      FontSizeEnum.content,
                                                      FontWeight.bold)),
                                              Text(
                                                  bookingInProgress[i]
                                                      .customerName,
                                                  style: CustomStyle.getStyle(
                                                      Colors.white,
                                                      FontSizeEnum.content2,
                                                      FontWeight.normal)),
                                              const SizedBox(
                                                height: 18,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(18)),
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  color: GeneralHelper
                                                      .getTrueColor(
                                                          bookingInProgress[i]
                                                              .status),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () async {},
                                                    icon: const FaIcon(
                                                      FontAwesomeIcons.phone,
                                                      color: Colors.white,
                                                    )),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      var userModel =
                                                          await UserController(
                                                                  user.uid)
                                                              .read(
                                                                  rootProvider)
                                                              .first;
                                                      userModel.chatWith =
                                                          bookingInProgress[i]
                                                              .customerId;
                                                      await UserController(
                                                              user.uid)
                                                          .update(userModel);
                                                      Navigator.of(context).pushNamed(
                                                          ChatPage.routeName,
                                                          arguments: ChatPageArguments(
                                                              peerId:
                                                                  bookingInProgress[
                                                                          i]
                                                                      .customerId,
                                                              peerAvatar: '',
                                                              peerNickname:
                                                                  bookingInProgress[
                                                                          i]
                                                                      .customerName));
                                                    },
                                                    icon: const FaIcon(
                                                      FontAwesomeIcons
                                                          .solidMessage,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                bookingInProgress[i].status ==
                                                        'WAITING APPROVAL'
                                                    ? TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .red[100]),
                                                        onPressed: () {
                                                          DialogHelper.dialogWithAction(
                                                              context,
                                                              'Update appointment',
                                                              'Delete appointment?',
                                                              onPressed:
                                                                  () async {
                                                            await bookingController
                                                                .delete(
                                                                    bookingInProgress[
                                                                        i]);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });
                                                        },
                                                        child: const Text(
                                                            'Decline'))
                                                    : Container(),
                                                bookingInProgress[i].status ==
                                                        'WAITING APPROVAL'
                                                    ? TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .white),
                                                        onPressed: () {
                                                          DialogHelper.dialogWithAction(
                                                              context,
                                                              'Update appointment',
                                                              'Approve appointment?',
                                                              onPressed:
                                                                  () async {
                                                            bookingInProgress[i]
                                                                    .status =
                                                                'APPROVED';
                                                            await bookingController
                                                                .update(
                                                                    bookingInProgress[
                                                                        i],
                                                                    rootProvider);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });
                                                        },
                                                        child: const Text(
                                                            'Approve'))
                                                    : Container(),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                  ));
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        'History',
                        style: CustomStyle.getStyle(
                            Colors.black, FontSizeEnum.title2, FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: bookingHistory.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return CustomCard(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  BookingDescriptionPage.routeName,
                                  arguments: {
                                    'booking': bookingHistory[i],
                                    'role': Role.technician
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(bookingHistory[i].services[0].name,
                                        style: CustomStyle.getStyle(
                                            Colors.white,
                                            FontSizeEnum.content,
                                            FontWeight.bold)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(18)),
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        color: GeneralHelper.getTrueColor(
                                            bookingHistory[i].status),
                                      ),
                                    )
                                  ],
                                ),
                                const FaIcon(
                                  FontAwesomeIcons.chevronRight,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return Text(
                      'Error getting services has error ${snapshot.hasError} Error : ${snapshot.error}');
                }
              }
            }),
      ],
    );
  }

  Widget buildCustomerBooking(User user) {
    var rootProvider = context.read<RootProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Booking.',
              style: CustomStyle.getStyle(
                  Colors.black, FontSizeEnum.title, FontWeight.w900),
            ),
            CreateButton(onPressed: () {
              Navigator.of(context).pushNamed(BookingCreatePage.routeName);
            })
          ],
        ),
        const SizedBox(
          height: 42,
        ),
        StreamBuilder<List<Booking>>(
            stream: bookingController.readForCustomer(user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: CustomStyle.primarycolor,
                );
              } else {
                if (snapshot.hasData) {
                  var booking = snapshot.data!;
                  List<Booking> bookingInProgress = [];
                  List<Booking> bookingHistory = [];
                  try {
                    bookingInProgress = booking
                        .where(
                          (element) =>
                              element.status == 'IN PROGRESS' ||
                              element.status == 'WAITING APPROVAL' ||
                              element.status == 'APPROVED',
                        )
                        .toList();
                    bookingHistory = booking
                        .where(
                          (element) => element.status == 'COMPLETED',
                        )
                        .toList();
                  } catch (e) {}

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'In Progress',
                        style: CustomStyle.getStyle(
                            Colors.black, FontSizeEnum.title2, FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 120,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: scrollController,
                          child: ListView.builder(
                            itemCount: bookingInProgress.length,
                            itemBuilder: (context, i) {
                              return SizedBox(
                                  width: SizeHelper(context).scaledWidth() - 64,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          BookingDescriptionPage.routeName,
                                          arguments: {
                                            'booking': bookingInProgress[i],
                                            'role': Role.customer
                                          });
                                    },
                                    child: CustomCard(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  bookingInProgress[i]
                                                      .services[0]
                                                      .name,
                                                  style: CustomStyle.getStyle(
                                                      Colors.white,
                                                      FontSizeEnum.content,
                                                      FontWeight.bold)),
                                              Text(
                                                  bookingInProgress[i]
                                                      .technicianName,
                                                  style: CustomStyle.getStyle(
                                                      Colors.white,
                                                      FontSizeEnum.content2,
                                                      FontWeight.normal)),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const FaIcon(
                                                      FontAwesomeIcons.phone,
                                                      color: Colors.white,
                                                    )),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      var userModel =
                                                          await UserController(
                                                                  user.uid)
                                                              .read(
                                                                  rootProvider)
                                                              .first;
                                                      userModel.chatWith =
                                                          bookingInProgress[i]
                                                              .technicianId;
                                                      await UserController(
                                                              user.uid)
                                                          .update(userModel);
                                                      Navigator.of(context).pushNamed(
                                                          ChatPage.routeName,
                                                          arguments: ChatPageArguments(
                                                              peerId: bookingInProgress[
                                                                      i]
                                                                  .technicianId,
                                                              peerAvatar: '',
                                                              peerNickname:
                                                                  bookingInProgress[
                                                                          i]
                                                                      .technicianName));
                                                    },
                                                    icon: const FaIcon(
                                                      FontAwesomeIcons
                                                          .solidMessage,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                                  ));
                            },
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            // children: [
                            //   SizedBox(
                            //       width: SizeHelper(context).scaledWidth() - 64,
                            //       child:
                            //           const CustomCard(child: Text('Hello'))),
                            //   SizedBox(
                            //       width: SizeHelper(context).scaledWidth() - 64,
                            //       child:
                            //           const CustomCard(child: Text('Hello'))),
                            // ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        'History',
                        style: CustomStyle.getStyle(
                            Colors.black, FontSizeEnum.title2, FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                        itemCount: bookingHistory.length,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  BookingDescriptionPage.routeName,
                                  arguments: {
                                    'booking': bookingHistory[i],
                                    'role': Role.customer
                                  });
                            },
                            child: CustomCard(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(bookingHistory[i].services[0].name,
                                      style: CustomStyle.getStyle(
                                          Colors.white,
                                          FontSizeEnum.content,
                                          FontWeight.bold)),
                                  const FaIcon(
                                    FontAwesomeIcons.chevronRight,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return Text(
                      'Error getting services has error ${snapshot.hasError} Error : ${snapshot.error}');
                }
              }
            }),
      ],
    );
  }
}
