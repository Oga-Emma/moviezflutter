import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    required this.heading,
    required this.body,
    Key? key,
    this.addTopPadding = false,
    this.addBottomPadding = false,
    this.showBackground = false,
  }) : super(key: key);

  final String heading;
  final String body;
  final bool addTopPadding;
  final bool addBottomPadding;
  final bool showBackground;

  @override
  Widget build(BuildContext context) {
    var view = Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (addTopPadding) const Gap(15),
        Text(
          heading,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        const Gap(2),
        Text(
          body,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xff5E6B67), fontSize: 12),
        ),
        if (addBottomPadding) const Gap(30),
        // Gap(5),
        // SvgPicture.asset(
        //   Assets.EMPTYSTATE,
        //   height: 150,
        //   width: 200,
        // ),
      ],
    ));
    return SingleChildScrollView(
        physics: const PageScrollPhysics(),
        child: showBackground
            ? Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 30,
                      color: Colors.black.withOpacity(.05),
                    ),
                  ],
                ),
                child: view,
              )
            : view);
  }
}
