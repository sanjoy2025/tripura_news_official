import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tripura_news_official_web/rashi_model_new.dart';

class RashiIndiView extends StatefulWidget {
  const RashiIndiView({
    super.key,
    required this.horoscope,
  });

  final Horoscope horoscope;

  @override
  State<RashiIndiView> createState() => _RashiIndiViewState();
}

class _RashiIndiViewState extends State<RashiIndiView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                textAlign: TextAlign.justify,
                widget.horoscope.descriptionDetails ?? '',
                style: GoogleFonts.tiroBangla(
                  color: const Color(0xFFBE88FF),
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
              child: Row(
                children: [
                  Expanded(
                      child: smallCard(
                          number: widget.horoscope.luckyNumber?.details ?? '',
                          title: widget.horoscope.luckyNumber?.title ?? '')),
                  Expanded(
                      child: smallCard(
                          number:
                              widget.horoscope.luckyDirection?.details ?? '',
                          title: widget.horoscope.luckyDirection?.title ?? '')),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
              child: Row(
                children: [
                  Expanded(
                      child: smallCard(
                          number: widget.horoscope.luckyGem?.details ?? '',
                          title: widget.horoscope.luckyGem?.title ?? '')),
                  Expanded(
                      child: smallCard(
                          number: widget.horoscope.luckyColour?.details ?? '',
                          title: widget.horoscope.luckyColour?.title ?? '')),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Text(
                textAlign: TextAlign.justify,
                widget.horoscope.prediction ?? '',
                style: GoogleFonts.tiroBangla(fontSize: 16),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: bigCard(
                widget.horoscope.money?.title ?? "",
                widget.horoscope.money?.rating ?? "",
                widget.horoscope.money?.details ?? "",
                Icons.monetization_on),
          ),
          SliverToBoxAdapter(
            child: bigCard(
                widget.horoscope.family?.title ?? "",
                widget.horoscope.family?.rating ?? "",
                widget.horoscope.family?.details ?? "",
                Icons.family_restroom),
          ),
          SliverToBoxAdapter(
            child: bigCard(
                widget.horoscope.relation?.title ?? "",
                widget.horoscope.relation?.rating ?? "",
                widget.horoscope.relation?.details ?? "",
                Icons.favorite),
          ),
          SliverToBoxAdapter(
            child: bigCard(
                widget.horoscope.occupation?.title ?? "",
                widget.horoscope.occupation?.rating ?? "",
                widget.horoscope.occupation?.details ?? "",
                Icons.work),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 64),
          ),
        ],
      ),
    );
  }

  Widget bigCard(String title, String number, String desc, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
      child: Card(
        color: const Color(0xFF1E1E1E),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color: const Color(0xFFBE88FF),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: GoogleFonts.tiroBangla(
                      color: const Color(0xFF9C9C9C),
                      fontSize: 24,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.star,
                    size: 24,
                    color: Color(0xFFFDCC0D),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    number,
                    style: GoogleFonts.tiroBangla(
                      color: const Color(0xFF9C9C9C),
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                desc,
                style: GoogleFonts.tiroBangla(
                  color: const Color(0xFF9C9C9C),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget smallCard({required String title, required String number}) {
    return Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        //set border radius more than 50% of height and width to make circle
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.tiroBangla(
                    color: const Color(0xFFFDCC0D),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Text(
              number,
              style: GoogleFonts.tiroBangla(
                color: const Color(0xFFE1E1E1),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
