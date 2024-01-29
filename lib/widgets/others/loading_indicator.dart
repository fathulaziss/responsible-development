import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:responsible_development/common/colors.dart';
import 'package:responsible_development/common/styles.dart';
import 'package:responsible_development/provider/utility_provider.dart';
import 'package:responsible_development/widgets/cards/card_custom.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key, this.color, this.size}) : super(key: key);

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRing(
        size: size ?? 32,
        lineWidth: 3,
        color: color ?? AppColor.primary,
      ),
    );
  }
}

class LoadingIndicatorBounce extends StatelessWidget {
  const LoadingIndicatorBounce({Key? key, this.color, this.size})
      : super(key: key);

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        size: size ?? 25,
        color: color ?? AppColor.primary,
      ),
    );
  }
}

class LoadingIndicatorDefault extends StatelessWidget {
  const LoadingIndicatorDefault({super.key, this.message = 'Mohon Tunggu'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilityProvider>(
      builder: (context, utilityProvider, _) {
        return CardCustom(
          backgroundColor: utilityProvider.isDarkTheme ||
                  MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.grey.shade700
              : Colors.white,
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.44,
            horizontal: MediaQuery.of(context).size.width * 0.22,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const LoadingIndicatorBounce(size: 20, color: Colors.orange),
              Text(
                message,
                style: textStyle.bodyMedium!.copyWith(
                  color: utilityProvider.isDarkTheme ||
                          MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
