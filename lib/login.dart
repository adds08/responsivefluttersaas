import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogIn1 extends StatelessWidget {
  LogIn1({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 471.0, middle: 0.4994),
            Pin(size: 2.0, middle: 0.3521),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 60,
                  runSpacing: 17,
                  children: [{}, {}, {}, {}].map((itemData) {
                    return SizedBox(
                      width: 72.0,
                      height: 0.0,
                      child: Stack(
                        children: <Widget>[
                          Pinned.fromPins(
                            Pin(start: 0.0, end: 0.0),
                            Pin(start: 0.0, end: -1.0),
                            child: SvgPicture.string(
                              _svg_jgi33,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 270.0, middle: 0.499),
            Pin(size: 30.0, middle: 0.2156),
            child: Text(
              'Enter your 4 digit PIn',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 26,
                color: const Color(0xff252057),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 190.0, middle: 0.4991),
            Pin(size: 44.0, start: 82.0),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 126.0, middle: 1.0),
                  Pin(size: 34.0, middle: 0.5),
                  child: Text(
                    '10:00 am',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 28,
                      color: const Color(0xff273d4f),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 44.0, start: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Icon material-acces…' (shape)
                      SvgPicture.string(
                    _svg_btjeh5,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 471.0, middle: 0.4994),
            Pin(size: 367.0, middle: 0.7229),
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 56,
                        runSpacing: 0,
                        children: [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}].map((itemData) {
                          return SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromPins(
                                  Pin(start: 0.0, end: 0.0),
                                  Pin(start: 0.0, end: 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color(0xffffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x29555555),
                                          offset: Offset(0, 4),
                                          blurRadius: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 21.0, end: 47.5),
                  Pin(size: 21.0, end: 33.5),
                  child:
                      // Adobe XD layer: 'Icon material-clear' (shape)
                      SvgPicture.string(
                    _svg_p50tve,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 40.0, end: 43.0),
                  Pin(start: 32.0, end: 8.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 149,
                        runSpacing: 40,
                        children: [
                          {
                            'text': '1',
                          },
                          {
                            'text': '2',
                          },
                          {
                            'text': '3',
                          },
                          {
                            'text': '4',
                          },
                          {
                            'text': '5',
                          },
                          {
                            'text': '6',
                          },
                          {
                            'text': '7',
                          },
                          {
                            'text': '8',
                          },
                          {
                            'text': '9',
                          },
                          {
                            'text': '1',
                          },
                          {
                            'text': '0',
                          },
                          {
                            'text': '',
                          }
                        ].map((itemData) {
                          final text = itemData['text'];
                          return SizedBox(
                            width: 14.0,
                            height: 49.0,
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromPins(
                                  Pin(start: 0.0, end: 0.0),
                                  Pin(start: 0.0, end: 0.0),
                                  child: Text(
                                    text!,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 40,
                                      color: const Color(0xff273d4f),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 142.0, middle: 0.5202),
            Pin(size: 60.0, middle: 0.9866),
            child: Text(
              'Forgot Pin?\n',
              style: TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 26,
                color: const Color(0xff4f4f4f),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 145.0, middle: 0.5194),
            Pin(size: 1.0, end: 37.5),
            child: SvgPicture.string(
              _svg_y8qzol,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 1.0, end: -1.0),
            Pin(size: 60.0, start: 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 4),
                    blurRadius: 7,
                  ),
                ],
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 171.0, start: 40.0),
            Pin(size: 30.0, start: 15.0),
            child:
                // Adobe XD layer: 'UNIVERSUM full color' (shape)
                Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_jgi33 =
    '<svg viewBox="429.5 514.5 72.0 1.0" ><path transform="translate(429.5, 514.5)" d="M 0 0 L 72 0" fill="none" stroke="#707070" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_btjeh5 =
    '<svg viewBox="535.5 93.0 44.0 44.0" ><path transform="translate(532.5, 90.0)" d="M 24.97799301147461 2.999999761581421 C 12.83399772644043 2.999999761581421 2.999999761581421 12.85599899291992 2.999999761581421 24.99999618530273 C 2.999999761581421 37.14399337768555 12.83399772644043 47 24.97799301147461 47 C 37.14399337768555 47 47 37.14399337768555 47 24.99999618530273 C 47 12.85599708557129 37.14399337768555 2.999999761581421 24.97799301147461 2.999999761581421 Z M 24.99999618530273 42.59999847412109 C 15.27599811553955 42.59999847412109 7.399998664855957 34.72399520874023 7.399998664855957 24.99999618530273 C 7.399998664855957 15.27599716186523 15.27599811553955 7.399998664855957 24.99999618530273 7.399998664855957 C 34.72399520874023 7.399998664855957 42.59999847412109 15.27599811553955 42.59999847412109 24.99999618530273 C 42.59999847412109 34.72399520874023 34.72399520874023 42.59999847412109 24.99999618530273 42.59999847412109 Z M 26.09999465942383 13.99999904632568 L 22.79999732971191 13.99999904632568 L 22.79999732971191 27.19999504089355 L 34.34999465942383 34.12999725341797 L 35.99999237060547 31.42399787902832 L 26.09999465942383 25.54999542236328 L 26.09999465942383 13.99999904632568 Z" fill="#273d4f" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_p50tve =
    '<svg viewBox="807.5 702.5 21.0 21.0" ><path transform="translate(800.0, 695.0)" d="M 28.5 9.614999771118164 L 26.38500022888184 7.5 L 18 15.88500022888184 L 9.614999771118164 7.5 L 7.5 9.614999771118164 L 15.88500022888184 18 L 7.5 26.38500022888184 L 9.614999771118164 28.5 L 18 20.11499977111816 L 26.38500022888184 28.5 L 28.5 26.38500022888184 L 20.11499977111816 18 L 28.5 9.614999771118164 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_y8qzol =
    '<svg viewBox="589.5 761.5 145.0 1.0" ><path transform="translate(589.5, 761.5)" d="M 0 0 L 145 0" fill="none" stroke="#868686" stroke-width="2" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
