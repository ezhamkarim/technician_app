import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/view/home/customer/services_list_selection_page.dart';
import 'package:technician_app/src/view/home/customer/technician_list_page.dart';

import '../../../provider/root_provider.dart';
import '../../../style/custom_style.dart';
import '../../widgets/custom_card.dart';

class BookingCreatePage extends StatefulWidget {
  const BookingCreatePage({Key? key}) : super(key: key);
  static const routeName = '/index/createbooking';
  @override
  State<BookingCreatePage> createState() => _BookingCreatePageState();
}

class _BookingCreatePageState extends State<BookingCreatePage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.watch<RootProvider>();
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
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(TechnicianListPage.routeName);
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
                // Row(
                //   children: [
                //     Expanded(
                //       child: AuthButton(
                //           viewState: rootProvider.viewState,
                //           onPressed: () async {
                //             if (formKey.currentState!.validate()) {
                //               if (widget.service != null) {
                //                 var service = Service(
                //                     id: widget.service!.id,
                //                     name: serviceNameController.text,
                //                     price: double.parse(
                //                         servicePriceController.text),
                //                     isActive: true);
                //                 await ServiceController()
                //                     .update(service, rootProvider)
                //                     .then(
                //                         (value) => Navigator.of(context).pop())
                //                     .catchError((e) {
                //                   logError('Error create services');
                //                   //TODO: Show error dialog
                //                 });
                //               } else {
                //                 var service = Service(
                //                     id: '',
                //                     name: serviceNameController.text,
                //                     price: double.parse(
                //                         servicePriceController.text),
                //                     isActive: true);
                //                 await ServiceController()
                //                     .create(service, rootProvider)
                //                     .then(
                //                         (value) => Navigator.of(context).pop())
                //                     .catchError((e) {
                //                   logError('Error create services');
                //                   //TODO: Show error dialog
                //                 });
                //               }
                //             }
                //           },
                //           color: CustomStyle.primarycolor,
                //           child: Text(
                //               widget.service == null ? 'Create' : 'Update')),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
