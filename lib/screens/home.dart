import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remainder/ui/home_header.dart';
import 'package:remainder/utils.dart';

class Home extends HookWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: SvgPicture.asset("assets/home.svg"),
              onTap: () {
                selectedIndex.value = 0;
                Navigator.of(context).pop();
              },
              title: const Text("Home"),
            ),
            ListTile(
              onTap: () {
                selectedIndex.value = 1;
                Navigator.of(context).pop();
              },
              leading: const Icon(Icons.interests_rounded),
              title: const Text("Categories"),
            ),
          ],
        ),
      ),
      body: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, val, w) {
                return Utils.homeItems[val];
              },
            ),
          )
        ],
      ),
    );
  }
}
