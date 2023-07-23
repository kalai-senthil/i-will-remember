import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/utils.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ).add(
        const EdgeInsets.only(top: 5),
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Observer(
            builder: (context) {
              final isDark = context.read<AppStore>().theme == ThemeEnum.dark;
              return SvgPicture.asset(
                "assets/more_options.svg",
                theme: SvgTheme(
                  currentColor: isDark
                      ? Colors.white
                      : const Color(
                          0xff3a3d4d,
                        ),
                ),
              );
            },
          ),
          Observer(builder: (context) {
            final isDark = context.read<AppStore>().theme == ThemeEnum.dark;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: Utils.borderRadiusRoundedFull,
                color: isDark
                    ? const Color(
                        0xff252c54,
                      )
                    : const Color(
                        0xfff6f6fe,
                      ),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    maxRadius: 18,
                    backgroundImage: NetworkImage(
                      "https://cdn.dribbble.com/userupload/2746192/file/original-263c04f911d1ad2bea69e86010ea7b32.jpg?resize=1200x900&vertical=center",
                    ),
                  ),
                  Icon(
                    Icons.more_vert_rounded,
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
