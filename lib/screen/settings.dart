import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_by_dn/dif/drawer.dart';
import 'package:file/local.dart';
import 'package:todo_app_by_dn/dif/local.dart';
import 'package:todo_app_by_dn/provider/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool theme = false;

  void themeScree() {
    theme = local.theme;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeScree();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocaleText(
          'caidat',
          style: GoogleFonts.beVietnamPro(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      drawer: Drawww(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.center,
                width: 400,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            LocaleText(
                              'display',
                              style: GoogleFonts.beVietnamPro(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple),
                            ),
                            LocaleText(
                              'discrip1',
                              style: GoogleFonts.beVietnamPro(
                                color: Colors.deepPurple,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Positioned.fill(
                          child: Consumer<ThemeProvider>(
                              builder: (context, provider, child) {
                            return DropdownButton<String>(
                                value: provider.currentTheme,
                                items: [
                                  DropdownMenuItem<String>(
                                      value: 'light',
                                      child: LocaleText(
                                        'dm1',
                                        style: GoogleFonts.beVietnamPro(
                                            color: Colors.deepPurple),
                                      )),
                                  DropdownMenuItem(
                                      value: 'dark',
                                      child: LocaleText(
                                        'dm2',
                                        style: GoogleFonts.beVietnamPro(
                                            color: Colors.deepPurple),
                                      )),
                                  DropdownMenuItem(
                                      value: 'system',
                                      child: LocaleText(
                                        'dm3',
                                        style: GoogleFonts.beVietnamPro(
                                            color: Colors.deepPurple),
                                      )),
                                ],
                                onChanged: (String? value) {
                                  provider.changeTheme(value ?? 'system');
                                });
                          }),
                        )
                      ],
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.center,
                width: 400,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            LocaleText(
                              'lang',
                              style: GoogleFonts.beVietnamPro(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple),
                            ),
                            LocaleText(
                              'discrip2',
                              style: GoogleFonts.beVietnamPro(
                                color: Colors.deepPurple,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Positioned.fill(child: Consumer<ThemeProvider>(
                            builder: (context, provider, child) {
                          return DropdownButton<String>(
                              value: provider.currentLangugae,
                              items: [
                                DropdownMenuItem<String>(
                                    value: 'VNE',
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/vietnam.png',
                                          height: 40,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'VNE',
                                          style: GoogleFonts.beVietnamPro(
                                              color: Colors.deepPurple),
                                        )
                                      ],
                                    )),
                                DropdownMenuItem(
                                    value: 'ENG',
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/unitedkingdom.png',
                                          height: 40,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'ENG',
                                          style: GoogleFonts.beVietnamPro(
                                              color: Colors.deepPurple),
                                        )
                                      ],
                                    )),
                              ],
                              onChanged: (String? value) {
                                if (value == 'VNE') {
                                  provider.changeLanguage(value!);
                                  LocaleNotifier.of(context)?.change('vi');
                                }
                                if (value == 'ENG') {
                                  provider.changeLanguage(value!);
                                  LocaleNotifier.of(context)?.change('en');
                                }
                              });
                        }))
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
