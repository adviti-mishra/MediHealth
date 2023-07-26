import 'package:flutter/material.dart';
import 'package:practice_app/utils/color_shades.dart';

class MediAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MediAppBar({Key? key, required this.importedKey}) : super(key: key);
  final GlobalKey<ScaffoldState> importedKey;

  void navigatetoMenu(GlobalKey<ScaffoldState> scaffoldKey) {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorShades.primaryColor1,
      leading: IconButton(
        onPressed: () {
          navigatetoMenu(importedKey);
        },
        icon: Icon(
          Icons.menu,
          color: ColorShades.primaryColor4,
          size: 40,
        ),
      ),
      centerTitle: true,
      title: Text(
        'MediHealth',
        style: TextStyle(
          color: ColorShades.primaryColor4,
          fontSize: 40,
          fontFamily: 'Tahoma',
          fontWeight: FontWeight.w700,
        ),
      ),
      toolbarHeight: 60,
      actions: [
        Column(
          children: [
            Icon(
              Icons.help_outline,
              color: ColorShades.primaryColor4,
              size: 30,
            ),
            Text(
              "Help",
              style: TextStyle(
                color: ColorShades.primaryColor4,
              ),
            )
          ],
        ),
        const SizedBox(width: 20)
      ],
    );
  }

  @override
  Size get preferredSize => const Size(100, 60);
}
