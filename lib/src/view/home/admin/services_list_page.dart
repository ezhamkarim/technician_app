import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technician_app/src/controller/service_controller.dart';
import 'package:technician_app/src/helper/dialog_helper.dart';
import 'package:technician_app/src/model/service_model.dart';
import 'package:technician_app/src/view/home/admin/services_create_page.dart';
import 'package:technician_app/src/view/widgets/create_button.dart';
import 'package:technician_app/src/view/widgets/custom_card.dart';

import '../../../style/custom_style.dart';

class ServiceListPage extends StatefulWidget {
  const ServiceListPage({Key? key}) : super(key: key);
  static const routeName = '/index/services';
  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  final serviceController = ServiceController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      'Services.',
                      style: CustomStyle.getStyle(
                          Colors.black, FontSizeEnum.title, FontWeight.bold),
                    ),
                  ],
                ),
                CreateButton(onPressed: () {
                  Navigator.of(context).pushNamed(ServicesCreatePage.routeName);
                })
              ],
            ),
            StreamBuilder<List<Service>>(
                stream: serviceController.read(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: CustomStyle.primarycolor,
                    );
                  } else {
                    if (snapshot.hasData) {
                      var services = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: services.length,
                          itemBuilder: (context, i) {
                            return CustomCard(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      services[i].name,
                                      style: CustomStyle.getStyle(
                                          Colors.white,
                                          FontSizeEnum.content2,
                                          FontWeight.w400),
                                    ),
                                    Text(
                                      services[i].price.toString(),
                                      style: CustomStyle.getStyle(
                                          Colors.white,
                                          FontSizeEnum.content3,
                                          FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              ServicesCreatePage.routeName,
                                              arguments: services[i]);
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.penToSquare,
                                          color: Colors.white,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          DialogHelper.dialogWithAction(
                                              context,
                                              'Delete',
                                              'Are you sure to delete?',
                                              onPressed: () async {
                                            await serviceController
                                                .delete(services[i]);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.trash,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ],
                            ));
                          });
                    } else {
                      return Text(
                          'Error getting services has error ${snapshot.hasError}');
                    }
                  }
                }),
          ],
        ),
      )),
    );
  }
}
