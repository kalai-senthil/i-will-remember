import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remainder/stores/app_store.dart';
import 'package:remainder/utils.dart';
import 'dart:math' show pi;

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final selectedDate = context.read<AppStore>().selectedDate;
        final daysToShow = context.read<AppStore>().daysToShow;
        return Column(
          children: [
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: RichText(
                    text: TextSpan(
                        text: Utils.months[selectedDate.month].padRight(5),
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          fontSize: 35,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Utils.darkPrimaryColor,
                            ),
                            text: formatDate(selectedDate, [yyyy]),
                          )
                        ]),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context
                          .read<AppStore>()
                          .setSelectedDateToView(DateViewEnum.now),
                      icon: const Icon(
                        Icons.refresh_rounded,
                      ),
                    ),
                    IconButton(
                      onPressed: () => context
                          .read<AppStore>()
                          .setSelectedDateToView(DateViewEnum.prev),
                      icon: Transform.rotate(
                        angle: pi / 2,
                        child: const Icon(
                          Icons.arrow_drop_down_rounded,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => context
                          .read<AppStore>()
                          .setSelectedDateToView(DateViewEnum.next),
                      icon: Transform.rotate(
                        angle: -pi / 2,
                        child: const Icon(
                          Icons.arrow_drop_down_rounded,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: daysToShow
                  .map(
                    (e) => Observer(
                      builder: (context) {
                        final hasMarked =
                            context.read<AppStore>().calendarView[e] != null;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: Utils.borderRadiusRoundedFull,
                            color: hasMarked
                                ? Utils.darkPrimaryColor
                                : Utils.lightPrimaryColor,
                          ),
                          child: SizedBox.fromSize(
                            size: const Size.square(50),
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Center(
                                child: Text(
                                  e,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        hasMarked ? Colors.white : Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
