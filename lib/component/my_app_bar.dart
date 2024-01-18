import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: AppBar(
        leadingWidth: 30,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: const Image(
          repeat: ImageRepeat.noRepeat,
          // width: 150,
          image: AssetImage(
            "assets/logo.png",
          ),
          semanticLabel: "Favorite Flyer",
          fit: BoxFit.cover,
          height: 60,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
