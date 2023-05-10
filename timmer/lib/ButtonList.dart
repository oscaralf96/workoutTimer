/* 
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    List<String> typesOftimers = const ['TABATA', 'EMOM', 'TIMER', 'CUSTOM'];
    var buttonsList = <Widget>[];

    List<Widget> buildButtonsList() {
      for (int i = 0; i < typesOftimers.length; i++) {
        buttonsList.add(ElevatedButton(
            onPressed: () {
              switch (i) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TabataPage()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EMOMPage()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TimerPage(
                              title: "Timer",
                            )),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomPage()),
                  );
                  break;
              }
            },
            child: Text(typesOftimers[i])));
        buttonsList.add(const SizedBox(height: 10));
      }
      return buttonsList;
    }

    return Scaffold(
      /*appBar: AppBar(
        title: Text(title),
      ),*/
      body: Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: buildButtonsList(),
          ),
        ),
      ),
    );
  }
} */