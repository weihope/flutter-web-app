import 'package:app2/provider/locoleprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LocalizationScreen extends StatefulWidget {
  const LocalizationScreen({super.key});

  @override
  State<LocalizationScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LocalizationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<LocaleProvider>().setLocale(const Locale('en'));
                    },
                    child: Text('EN'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LocaleProvider>().setLocale(const Locale('zh'));
                    },
                    child: Text('CN'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LocaleProvider>().setLocale(const Locale('ja'));
                    },
                    child: Text('JA'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LocaleProvider>().setLocale(const Locale('vi'));
                    },
                    child: Text('VI'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LocaleProvider>().setLocale(const Locale('th'));
                    },
                    child: Text('TH'),
                  ),
                ],
              ),
              Text(AppLocalizations.of(context)!.confirmLogin),
              Text(AppLocalizations.of(context)!.fishingGames),
              Text(AppLocalizations.of(context)!.forgetPassword),
              Text(AppLocalizations.of(context)!.fPWrongInfo),
              Text(AppLocalizations.of(context)!.liveCasino),
              Text(AppLocalizations.of(context)!.previsionGames),
              Text(AppLocalizations.of(context)!.rkMr('hey')),
              Text(AppLocalizations.of(context)!.rkMrs('name')),
              Text(AppLocalizations.of(context)!.rkMs('name')),
            ],
          ),
        ),
      ),
    );
  }
}
