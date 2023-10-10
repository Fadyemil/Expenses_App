import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 142, 96, 229),
          borderRadius: BorderRadius.circular(120),
        ),
        child: Image.asset(image,
          height: 90,
          width: 70,
        ),
      ),
    );
  }
}
