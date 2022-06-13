import 'package:flutter/material.dart';
import 'package:technician_app/src/controller/service_controller.dart';
import 'package:technician_app/src/model/service_model.dart';
import 'package:technician_app/src/view/widgets/create_button.dart';
import 'package:technician_app/src/view/widgets/custom_card.dart';

import '../../../style/custom_style.dart';

class ServiceListPage extends StatefulWidget {
  const ServiceListPage({Key? key}) : super(key: key);
  static const routeName = '/home/services';
  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
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
                  Navigator.of(context).pushNamed(ServiceListPage.routeName);
                })
              ],
            ),
            StreamBuilder<List<Service>>(
                stream: ServiceController().read(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      var services = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: services.length,
                          itemBuilder: (context, i) {
                            return CustomCard(
                                child: Column(
                              children: [
                                Text(services[i].name),
                                Text(services[i].price.toString()),
                              ],
                            ));
                          });
                    } else {
                      return Text('Error getting services ${snapshot.error}');
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Text('Error getting services');
                  }
                })
          ],
        ),
      )),
    );
  }
}
