import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/view/widgets/custom_card.dart';

import '../../../controller/user_controller.dart';
import '../../../model/user_model.dart';
import '../../../provider/root_provider.dart';
import '../../../style/custom_style.dart';

class TechnicianReportPage extends StatefulWidget {
  const TechnicianReportPage({Key? key}) : super(key: key);
  static const routeName = '/index/report';
  @override
  State<TechnicianReportPage> createState() => _TechnicianReportPageState();
}

class _TechnicianReportPageState extends State<TechnicianReportPage> {
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
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  'Technician List.',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
              ],
            ),
            StreamBuilder<List<UserModel>>(
                stream: UserController(firebaseUser.uid).readTechnician(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: CustomStyle.primarycolor,
                    );
                  } else {
                    if (snapshot.hasData) {
                      var technician = snapshot.data!;
                      return ListTechnicianNew(technician: technician);
                    } else {
                      return Text(
                          'Error getting feedback has error ${snapshot.hasError}. Error ${snapshot.error}');
                    }
                  }
                })
          ],
        ),
      )),
    );
  }
}

class ListTechnicianNew extends StatefulWidget {
  const ListTechnicianNew({Key? key, required this.technician})
      : super(key: key);
  final List<UserModel> technician;
  @override
  State<ListTechnicianNew> createState() => _ListTechnicianNewState();
}

class _ListTechnicianNewState extends State<ListTechnicianNew> {
  String? technicianSelected;

  @override
  void initState() {
    var rootProvider = context.read<RootProvider>();
    if (rootProvider.technician != null) {
      technicianSelected = rootProvider.technician!.email;
      // logSuccess('Technician ${technicianSelected!.name}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.technician.length,
        itemBuilder: (context, i) {
          return CustomCard(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.technician[i].name),
              const Icon(FontAwesomeIcons.chevronRight)
            ],
          ));
        });
  }
}
