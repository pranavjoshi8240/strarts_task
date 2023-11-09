import 'package:flutter/material.dart';
import 'Reusable_Image_With_Shimmer.dart';

class ReusableProfileImage extends StatelessWidget {
  final String image;
  final void Function()? onTap;

  const ReusableProfileImage({
    super.key,
    required this.image, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: 62,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54.withOpacity(0.2),
            blurRadius: 3.0,
            offset: Offset(0.0, 3))
      ], shape: BoxShape.circle, color: Colors.white),
      child: ReusableImageWithShimmer(
        url: image,
        height: 60,
        placeholderUrl: 'assets/images/no_image.png',
        boxFit: BoxFit.cover,
        isCircle: true, onTap: onTap,
      ),
    );
  }
}
