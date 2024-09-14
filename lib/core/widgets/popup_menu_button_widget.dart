import 'package:flutter/material.dart';

class PopupMenuItemModel {
  final String? title;
  final int? colorValue;
  final Widget? widget;

  const PopupMenuItemModel({this.title, this.colorValue, this.widget});
}

class PopUpMenuButtonWidget extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final String? title;
  final Widget? icon;
  final double? widthSize;
  const PopUpMenuButtonWidget(
      {required this.menuList,
      this.title,
      this.icon,
      this.widthSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopupMenuButton(
      itemBuilder: ((context) => menuList),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xff212121),
      elevation: 0,
      // initialValue: menuList[0],
      position: PopupMenuPosition.under,

      constraints: BoxConstraints(
          minWidth: widthSize == null ? size.width * .6 : widthSize!,
          maxWidth: widthSize == null ? size.width * .6 : widthSize!),
      offset: const Offset(0, 10),
      padding: const EdgeInsets.only(left: 24, right: 24),
      icon: icon,
      child: Container(
        height: size.height * .05,
        width: widthSize == null ? size.width * .6 : widthSize!,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: const Color(0xff212121),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title!,
              style: const TextStyle(color: Color(0xffbdbdbd)),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Color(0xffffca28),
            ),
          ],
        ),
      ),
    );
  }
}

class PopUpMenuColorButtonWidget extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final String? title;
  final Widget? icon;
  final int? colorValue;
  final double? widthSize;
  const PopUpMenuColorButtonWidget(
      {required this.menuList,
      this.title,
      this.icon,
      this.colorValue,
      this.widthSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return PopupMenuButton(
      itemBuilder: ((context) => menuList),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xff212121),
      elevation: 0,
      // initialValue: menuList[0],
      position: PopupMenuPosition.under,

      constraints: const BoxConstraints(minWidth: 50, maxWidth: 50),
      offset: const Offset(0, 10),
      padding: const EdgeInsets.only(left: 2, right: 2),
      // icon: icon,
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: const Color(0xff212121),
            borderRadius: BorderRadius.circular(16)),
        child: CircleAvatar(
          backgroundColor: Color(colorValue!),
        ),
      ),
    );
  }
}

class MenuItem {
  //calculator mode
  static const List<PopupMenuItemModel> calculators = [
    compundInterest,
    // dailyInteres,
    // forexCompound,
  ];

  // calculator time
  static const List<PopupMenuItemModel> time = [
    daily,
    weekly,
    monthly,
    yearly,
  ];

  static const List<PopupMenuItemModel> colors = [
    greyColor,
    lemonColor,
    hookersGreenColor,
    pinkColor,
    brownColor
  ];

  // static const List<String> colors = [
  //   'E7ECEF', //grey
  //   'E4FF1A', //lemon
  //   '507255' // hookers green
  //       'E5446D', //pink
  //   'F2A359' //brow
  // ];

  static const greyColor = PopupMenuItemModel(
    widget: CircleAvatar(backgroundColor: Color(0xffE7ECEF)),
    colorValue: 0xffE7ECEF,
  );
  static const lemonColor = PopupMenuItemModel(
    widget: CircleAvatar(
      backgroundColor: Color(0xffE4FF1A),
    ),
    colorValue: 0xffE4FF1A,
  );
  static const hookersGreenColor = PopupMenuItemModel(
    widget: CircleAvatar(backgroundColor: Color(0xff507255)),
    colorValue: 0xff507255,
  );
  static const pinkColor = PopupMenuItemModel(
    widget: CircleAvatar(backgroundColor: Color(0xffE5446D)),
    colorValue: 0xffE5446D,
  );
  static const brownColor = PopupMenuItemModel(
    widget: CircleAvatar(backgroundColor: Color(0xffF2A359)),
    colorValue: 0xffF2A359,
  );

  // static var grey = PopupMenuItemModel(
  //     widget: Container(
  //   width: 10,
  //   height: 10,
  //   decoration: const BoxDecoration(color: Color(0xffE7ECEF)),
  // ));
  // static var lemon = PopupMenuItemModel(
  //     widget: Container(
  //   width: 10,
  //   height: 10,
  //   decoration: const BoxDecoration(color: Color(0xffE4FF1A)),
  // ));
  // static var hookerGreen = PopupMenuItemModel(
  //     widget: Container(
  //   width: 10,
  //   height: 10,
  //   decoration: const BoxDecoration(color: Color(0xff507255)),
  // ));
  // static var pink = PopupMenuItemModel(
  //     widget: Container(
  //   width: 10,
  //   height: 10,
  //   decoration: const BoxDecoration(color: Color(0xffE5446D)),
  // ));
  // static var brown = PopupMenuItemModel(
  //     widget: Container(
  //   width: 10,
  //   height: 10,
  //   decoration: const BoxDecoration(color: Color(0xffF2A359)),
  // ));

  // calculator mode
  static const compundInterest = PopupMenuItemModel(title: 'Compound Interest');
  // static const dailyInteres = PopupMenuItemModel(title: 'Daily Compound');
  // static const forexCompound = PopupMenuItemModel(title: 'Forex Compound');

  // calculator time
  static const daily = PopupMenuItemModel(title: 'Daily');
  static const weekly = PopupMenuItemModel(title: 'Weekly');
  static const monthly = PopupMenuItemModel(title: 'Monthly');
  static const yearly = PopupMenuItemModel(title: 'Yearly');
}
