import 'package:flutter/material.dart';
import 'package:technician_app/src/style/custom_style.dart';

class UploadAvatar extends StatelessWidget {
  final String? profilePic;

  final Function() onTap;

  const UploadAvatar({
    required this.onTap,
    required this.profilePic,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CircleAvatar(
          backgroundColor:
              profilePic != null ? null : CustomStyle.secondaryColor,
          backgroundImage:
              profilePic != null ? Image.network(profilePic!).image : null,
          radius: 50,
          child: profilePic == null
              ? const Icon(
                  Icons.perm_identity,
                  color: Colors.white,
                )
              : null
          // backgroundImage: Image.asset(
          //   'assets/images/splashimage.png',
          //   fit: BoxFit.cover,
          // ).image,
          ),
      Positioned(
          top: 70,
          left: 70,
          child: GestureDetector(
            onTap: onTap,
            child: const CircleAvatar(
              radius: 15,
              backgroundColor: CustomStyle.primarycolor,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: CustomStyle.primarycolor,
                child: Icon(
                  Icons.arrow_upward,
                  size: 18,
                ),
              ),
            ),
          ))
    ]);
  }
}
