import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tank_mates/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  static final String id = kIdAboutScreen;

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final richTextFontStyle =
      kTextStyleSmall.copyWith(fontSize: kRichTextFontSize);
  final linkFontStyle = kTextStyleSmall.copyWith(
    fontSize: kRichTextLinkFontSize,
    color: kPrimaryColor,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryColor, //change your color here
        ),
        title: Text(
          appName,
          style: kTextStyleHeader,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'About $appName',
                  style: kTextStyleLarge,
                ),
              ),
              Text(
                'Developer',
                style: kTextStyleHeader,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Hi there I\'m Connor, a mobile software developer living just outside of Philadelphia, PA.'
                          ' I got my first taste of coding in 2014. I spent the following summer learning to create my own Android apps.',
                      style: richTextFontStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'In my free time I have combined my passion for writing user friendly and functional applications with my aquarium hobby.'
                          ' I created this app as both a challenge to myself while learning Flutter and'
                          ' to create an aquarium stocking calculator that uses modern day design principles.'
                          ' I plan to continue to work on and release regular updates on Tank Mates.',
                      style: richTextFontStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'If you would like to find out more about my fish keeping journey follow me on ',
                      style: richTextFontStyle,
                    ),
                    TextSpan(
                      text: 'Instagram',
                      style: linkFontStyle,
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.instagram.com/aquatic_coder/');
                        },
                    ),
                    TextSpan(
                      text: ' or ',
                      style: richTextFontStyle,
                    ),
                    TextSpan(
                      text: 'Youtube',
                      style: linkFontStyle,
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.youtube.com/c/TheAquaticCoder');
                        },
                    ),
                  ],
                ),
              ),
              Divider(),
              Text(
                'Support Tank Mates',
                style: kTextStyleHeader,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Thanks for downloading and checking out Tank Mates. Many improvements are planned for the future'
                          ' but I appreciate any feedback or feature requests. If you enjoy this app or see a feature'
                          ' you would like added please leave a rating for this app on the ',
                      style: richTextFontStyle,
                    ),
                    TextSpan(
                      text: 'Play Store or App Store',
                      style: linkFontStyle,
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch(
                              'https://play.google.com/store/apps/details?id=com.loftydevelopment.tank_mates&hl=en_US&gl=US');
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'If you would like to reach out to me direct with an issue or feedback send me an email at ',
                      style: richTextFontStyle,
                    ),
                    TextSpan(
                      text: 'loftydev@gmail.com',
                      style: linkFontStyle,
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('mailto:loftydev@gmail.com');
                        },
                    ),
                    TextSpan(
                      text: ' or post an issue on ',
                      style: richTextFontStyle,
                    ),
                    TextSpan(
                      text: 'Github',
                      style: linkFontStyle,
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://github.com/connorlof/tank_mates/');
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Other ways to support the app can be to share it with a friend or a ',
                      style: richTextFontStyle,
                    ),
                    TextSpan(
                      text: 'small donation to help fund future development',
                      style: linkFontStyle,
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.buymeacoffee.com/aquaticcoder');
                        },
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
