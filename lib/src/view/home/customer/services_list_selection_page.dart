import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/booking_controller.dart';
import 'package:technician_app/src/controller/request_controller.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/booking_model.dart';

import '../../../controller/service_controller.dart';
import '../../../model/request_model.dart';
import '../../../model/service_model.dart';
import '../../../provider/root_provider.dart';
import '../../../style/custom_style.dart';

class ServiceListPageSelection extends StatefulWidget {
  const ServiceListPageSelection(
      {Key? key, this.fromRequest = false, this.booking})
      : super(key: key);
  static const routeName = '/index/createbooking/services';
  final bool fromRequest;
  final Booking? booking;
  @override
  State<ServiceListPageSelection> createState() =>
      _ServiceListPageSelectionState();
}

class _ServiceListPageSelectionState extends State<ServiceListPageSelection> {
  final serviceController = ServiceController();
  final requestController = RequestController();
  final bookingController = BookingController();
  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
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
                  'Services.',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
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
                      if (widget.booking != null) {
                        for (var i = 0;
                            i < widget.booking!.services.length;
                            i++) {
                          services.removeWhere(
                            (element) =>
                                element.id == widget.booking!.services[i].id,
                          );
                        }
                      }
                      return ListServices(services: services);
                    } else {
                      return Text(
                          'Error getting services has error ${snapshot.hasError}');
                    }
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: CustomStyle.primarycolor),
                  onPressed: () async {
                    if (widget.fromRequest && widget.booking != null) {
                      var requests = rootProvider.services;

                      await Future.forEach<Service>(requests, (element) async {
                        var request = Request(
                            id: '',
                            description: element.name,
                            status: 'IN PROGRESS');
                        widget.booking!.requests.add(request);
                        await requestController.create(request);
                      });
                      //  widget.booking!.services.addAll(rootProvider.services);
                      logSuccess('Booking : ${widget.booking!.toMap()}');
                      await bookingController.update(
                          widget.booking!, rootProvider);
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class ListServices extends StatefulWidget {
  const ListServices({Key? key, required this.services}) : super(key: key);
  final List<Service> services;
  @override
  State<ListServices> createState() => _ListServicesState();
}

class _ListServicesState extends State<ListServices> {
  @override
  void initState() {
    var rootProvider = context.read<RootProvider>();
    if (rootProvider.services.isNotEmpty) {
      for (var i = 0; i < rootProvider.services.length; i++) {
        var index = widget.services
            .indexWhere((element) => rootProvider.services[i].id == element.id);

        if (index != -1) {
          widget.services[i].selected = true;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return CustomStyle.primarycolor;
    }

    var rootProvider = context.read<RootProvider>();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.services.length,
        itemBuilder: (context, i) {
          return Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: widget.services[i].selected,
                onChanged: (bool? value) {
                  setState(() {
                    widget.services[i].selected = value!;
                  });

                  if (value == null) {
                    return;
                  }
                  if (value) {
                    try {
                      var serviceObj = rootProvider.services.firstWhere(
                          (element) => element.id == widget.services[i].id);
                    } on StateError {
                      rootProvider.addService = widget.services[i];
                    }
                  } else {
                    try {
                      var serviceObj = rootProvider.services.firstWhere(
                          (element) => element.id == widget.services[i].id);
                      rootProvider.removeService = serviceObj.id;
                    } on StateError {}
                  }
                  //
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.services[i].name),
                  Text('RM ${widget.services[i].price.toString()}'),
                ],
              ),
            ],
          );
        });
  }
}
