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
                    InkWell(
                      onTap: () => context
                          .read<AppStore>()
                          .setSelectedDateToView(DateViewEnum.now),
                      child: const Icon(
                        Icons.refresh_rounded,
                      ),
                    ),
                    InkWell(
                      onTap: () => context
                          .read<AppStore>()
                          .setSelectedDateToView(DateViewEnum.prev),
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => context
                          .read<AppStore>()
                          .setSelectedDateToView(DateViewEnum.next),
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 30,
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
                        final isCurrentlyViewing =
                            context.read<AppStore>().calShowViewKey == e;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: Utils.borderRadiusRoundedFull,
                            color: isCurrentlyViewing
                                ? Utils.lightSecondaryColor
                                : hasMarked
                                    ? Utils.darkPrimaryColor
                                    : Utils.lightPrimaryColor,
                          ),
                          child: InkWell(
                            onTap: () {
                              context.read<AppStore>().setCalShowViewKey(e);
                            },
                            child: SizedBox.fromSize(
                              size: const Size.square(50),
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Center(
                                  child: Text(
                                    e,
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w500,
                                      color: isCurrentlyViewing || hasMarked
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
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
