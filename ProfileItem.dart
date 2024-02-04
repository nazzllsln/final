import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final Function()? onTap;
  final String name;

  const ProfileItem({Key? key, this.onTap, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
          ],
        ),
      ),
    );
  }
}
