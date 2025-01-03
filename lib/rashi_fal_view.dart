import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'all_importent_imports.dart';
import 'colorsCode.dart';
import 'rashi_controller.dart';

// import 'package:flutter_tts/flutter_tts.dart'; // Import the Flutter TTS package

class RashiFal extends StatefulWidget {
  const RashiFal({Key? key}) : super(key: key);

  @override
  _RashiFalState createState() => _RashiFalState();
}

class _RashiFalState extends State<RashiFal> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool dainik_seleted = true.obs;
  RxBool weekly_seleted = false.obs;
  RxBool monthly_seleted = false.obs;
  RxBool anuually_seleted = false.obs;
  RxString selectedButton = 'todays'.obs;
  RxString selectedButtonBen = 'দৈনিক'.obs;

  // FlutterTts flutterTts = FlutterTts();
  RashiController rc = Get.put(RashiController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 154, // Set this height
        flexibleSpace: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              height: 154,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        dainik_seleted.value = !dainik_seleted.value;
                        weekly_seleted.value = false;
                        monthly_seleted.value = false;
                        anuually_seleted.value = false;
                        selectedButton.value = "todays";
                        selectedButtonBen.value = "দৈনিক";
                      },
                      child: cardViewTop('দৈনিক', FontAwesomeIcons.calendarDay,
                          selected: dainik_seleted.value),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        dainik_seleted.value = false;
                        weekly_seleted.value = !weekly_seleted.value;
                        monthly_seleted.value = false;
                        anuually_seleted.value = false;
                        selectedButton.value = "weekly";
                        selectedButtonBen.value = "সাপ্তাহিক";
                      },
                      child: cardViewTop(
                          'সাপ্তাহিক', FontAwesomeIcons.calendarWeek,
                          selected: weekly_seleted.value),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        dainik_seleted.value = false;
                        weekly_seleted.value = false;
                        monthly_seleted.value = !monthly_seleted.value;
                        anuually_seleted.value = false;
                        selectedButton.value = "monthly";
                        selectedButtonBen.value = "মাসিক";
                      },
                      child: cardViewTop('মাসিক', FontAwesomeIcons.calendarDays,
                          selected: monthly_seleted.value),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        dainik_seleted.value = false;
                        weekly_seleted.value = false;
                        monthly_seleted.value = false;
                        anuually_seleted.value = !anuually_seleted.value;
                        selectedButton.value = "yearly";
                        selectedButtonBen.value = "বার্ষিক";
                      },
                      child: cardViewTop('বার্ষিক', FontAwesomeIcons.globe,
                          selected: anuually_seleted.value),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     speakText(
            //         "प्रधानमंत्री नरेंद्र मोदी समेत तमाम बड़े देशों के नेताओं ने इजरायल का समर्थन किया है. वहीं ईरान ने हमास को इस हमले के लिए बधाई दी है. उधर, कतर ने इजरा...");
            //   },
            //   child: Text("Speak"),
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       'রাশিফল',
            //       style: GoogleFonts.tiroBangla(fontSize: 24),
            //     ),
            //   ],
            // ),
            // const Divider(),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: <Widget>[
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('mesh', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_meshrashi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('vrishabha', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_brisharasi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('mithun', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_mithunrasi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('karkat', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_karkatrasi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('singha', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_singharasi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('kanya', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_kanyarasi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('tula', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_tularasi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('vrishchik', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_brischikrasi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('dhanu', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_dhanurasi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('makar', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_makarrasi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('kumbh', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_kumbharasi.webp',
                  ),
                  CustomCardView(
                    clickEvent: () {
                      rc.callFunction('meen', selectedButton.value);
                    },
                    imgUrl: 'assets/webp/ic_meenrasi.webp',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to speak text
  // Future<void> speakText(String text) async {
  //   await flutterTts.setLanguage("bn-IN");

  //   var result = await flutterTts.speak(text);
  //   if (result == 1) {
  //     // Speaking started successfully
  //     print("Speaking: $text");
  //   } else {
  //     // There was an error starting speaking
  //     print("Error while speaking: $text");
  //   }
  // }

  Widget cardViewTop(String title, IconData icon, {bool selected = false}) {
    return Card(
      child: Ink(
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 100,
            minHeight: 30,
          ),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: selected == true ? kDarkGreen : kYellow,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: selected == false ? kDarkGreen : kYellow,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(
                icon,
                size: 36,
                color: selected == false ? kDarkGreen : kYellow,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: GoogleFonts.tiroBangla(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: selected == false ? kDarkGreen : kYellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//   Widget cardViewTop(String title, IconData icon, {bool selected = false}) {
//     return Card(
//       child: Ink(
//         child: Container(
//           // constraints: const BoxConstraints.expand(),
//           clipBehavior: Clip.hardEdge,
//           decoration: BoxDecoration(
//             color: selected == true ? kDarkGreen : kYellow,
//             borderRadius: const BorderRadius.all(Radius.circular(12)),
//             border: Border.all(
//               color: selected == false ? kDarkGreen : kYellow,
//             ),
//           ),
//           padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
//           height: 120,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               FaIcon(
//                 icon,
//                 size: 36,
//                 color: selected == false ? kDarkGreen : kYellow,
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Text(
//                 title,
//                 style: GoogleFonts.tiroBangla(
//                   fontSize: 14,
//                   fontWeight: FontWeight.normal,
//                   color: selected == false ? kDarkGreen : kYellow,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomCardView extends StatelessWidget {
  const CustomCardView({
    super.key,
    required this.imgUrl,
    required this.clickEvent,
  });

  final String imgUrl;
  final Function() clickEvent;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: clickEvent, // Handle your callback.
        splashColor: Colors.amber.withOpacity(0.5),
        child: Ink(
          decoration: BoxDecoration(
            color: kYellow,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: kYellow,
            ),
            image: DecorationImage(
              image: AssetImage(imgUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
