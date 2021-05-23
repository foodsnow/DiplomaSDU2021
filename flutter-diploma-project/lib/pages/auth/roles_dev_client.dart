import 'package:diploma_flutter_app/utils/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class Roles extends StatefulWidget {
  @override
  createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context),
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sizedHeightBox(50),
            mainText('Выберите роль', 28),
            sizedHeightBox(48),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _rolesImages("assets/images/client_image.svg", false),
              sizedWidthBox(48),
              _rolesImages("assets/images/developer_image.svg", true),
            ])
          ],
        ),
      ),
    );
  }

  Widget _rolesImages(String imageUrl, bool type) {
    return SizedBox(
      height: 163,
      width: 122,
      child: IconButton(
        icon: SvgPicture.asset(imageUrl),
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/Step1',
            arguments: type,
          );
        },
      ),
    );
  }
}

class DevClientRolesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Roles();
  }
}
