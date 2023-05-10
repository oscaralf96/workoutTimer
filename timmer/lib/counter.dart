import 'package:flutter/material.dart';
/*                       GestureDetector(
                        onTap: () {
                          if (!_isRunning) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      // title: const Text('AlertDialog Title'),
                                      content: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: const [
                                              Text("hours"),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("minutes"),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("seconds"),
                                            ],
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 200,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ListWheelScrollView
                                                      .useDelegate(
                                                          onSelectedItemChanged:
                                                              (value) => {
                                                                    newHours =
                                                                        value,
                                                                  },
                                                          itemExtent: 50,
                                                          perspective: 0.01,
                                                          diameterRatio: 2,
                                                          physics:
                                                              const FixedExtentScrollPhysics(),
                                                          childDelegate:
                                                              ListWheelChildBuilderDelegate(
                                                                  childCount:
                                                                      24,
                                                                  builder:
                                                                      (context,
                                                                          index) {
                                                                    return DisplayTile(
                                                                        number:
                                                                            index);
                                                                  })),
                                                ),
                                                Expanded(
                                                  child: ListWheelScrollView
                                                      .useDelegate(
                                                          onSelectedItemChanged:
                                                              (value) => {
                                                                    newMinutes =
                                                                        value,
                                                                  },
                                                          itemExtent: 50,
                                                          perspective: 0.01,
                                                          diameterRatio: 2,
                                                          physics:
                                                              const FixedExtentScrollPhysics(),
                                                          childDelegate:
                                                              ListWheelChildBuilderDelegate(
                                                                  childCount:
                                                                      60,
                                                                  builder:
                                                                      (context,
                                                                          index) {
                                                                    return DisplayTile(
                                                                        number:
                                                                            index);
                                                                  })),
                                                ),
                                                Expanded(
                                                  child: ListWheelScrollView
                                                      .useDelegate(
                                                          onSelectedItemChanged:
                                                              (value) => {
                                                                    newSeconds =
                                                                        value,
                                                                  },
                                                          itemExtent: 50,
                                                          perspective: 0.01,
                                                          diameterRatio: 2,
                                                          physics:
                                                              const FixedExtentScrollPhysics(),
                                                          childDelegate:
                                                              ListWheelChildBuilderDelegate(
                                                                  childCount:
                                                                      60,
                                                                  builder:
                                                                      (context,
                                                                          index) {
                                                                    return DisplayTile(
                                                                        number:
                                                                            index);
                                                                  })),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () => {
                                            setDuration(Duration(
                                                hours: newHours,
                                                minutes: newMinutes,
                                                seconds: newSeconds)),
                                            Navigator.pop(context, 'OK')
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ));
                          }
                        },
                        child: Text(
                          '$hours:$minutes:$seconds',
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: 60),
                        ),
                      ) */