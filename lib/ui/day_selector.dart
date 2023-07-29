import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/utils.dart';

class DaySelector extends StatelessWidget {
  const DaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final day = Utils.days[index];
          return Observer(builder: (context) {
            final selected =
                context.read<AppStore>().addRemainderDays.contains(day);
            return InkWell(
              onTap: () {
                context.read<AppStore>().selectDayToAddRemainder(day);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selected ? Utils.primaryColor : Colors.transparent,
                    width: 1.5,
                  ),
                  color: Utils.lightPrimaryColor,
                  // boxShadow: Utils.cardShadow,
                  borderRadius: Utils.borderRadiusRoundedCard * 2,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Utils.days[index],
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Material(
                      color: Colors.transparent,
                      borderRadius: Utils.borderRadiusRoundedFull,
                      elevation: 1,
                      shadowColor: Colors.black.withOpacity(.08),
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: selected ? Utils.darkPrimaryColor : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
        itemCount: Utils.days.length,
      ),
    );
  }
}
