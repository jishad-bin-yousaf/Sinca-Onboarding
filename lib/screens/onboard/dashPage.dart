import 'package:animated_onboarding/screens/mainscreen.dart';
import 'package:flutter/material.dart';

class SincaDash extends StatefulWidget {
  const SincaDash({super.key});

  @override
  State<SincaDash> createState() => _SincaDashState();
}

class _SincaDashState extends State<SincaDash> {
  Widget searchArea = Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        width: 250,
        child: TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              hintText: "Search Here...",
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  print("searched");
                },
              )),
        ),
      ),
    ],
  );

  Widget cards = Card(
    elevation: 5,
    child: SizedBox(
      height: 100,
      width: 325,
      child: Text("hello"),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            // Dash(),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  AppbarActions(),
                  Divider(
                    thickness: 2,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        searchArea,
                        Wrap(
                          alignment: WrapAlignment.spaceAround,
                          children: [
                            cards,
                            cards,
                            cards,
                            cards,
                            cards,
                          ],
                        ),
                        Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: [
                            cards,
                            cards,
                            cards,
                            cards,
                            cards,
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class Dash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      width: 80,
      color: Color.fromARGB(255, 11, 51, 78),
      child: ListView(
        padding: EdgeInsets.only(
          top: 10,
        ),
        children: [
          SizedBox(
            height: 30,
            child: OutlinedButton(
              style: const ButtonStyle(
                side: MaterialStatePropertyAll(
                  BorderSide(color: Color.fromARGB(255, 27, 27, 27)),
                ),
              ),
              onPressed: () {
                print("icon clicked");
              },
              child: Icon(
                Icons.settings,
                color: Color.fromARGB(255, 39, 39, 39),
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppbarActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "  SincA v5.2.2",
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 20,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 35,
                  width: 100,
                  child: Image.asset(
                    "images/sinca.png",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 8),
                OutlinedButton(
                  style: const ButtonStyle(
                    side: MaterialStatePropertyAll(
                      BorderSide(color: Color.fromARGB(255, 27, 27, 27)),
                    ),
                  ),
                  onPressed: () {
                    print("icon clicked");
                  },
                  child: Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 39, 39, 39),
                    size: 18,
                  ),
                ),
                SizedBox(width: 8),
                OutlinedButton(
                  style: const ButtonStyle(
                    side: MaterialStatePropertyAll(
                      BorderSide(color: Color.fromARGB(255, 246, 231, 61)),
                    ),
                  ),
                  onPressed: () {
                    print("icon clicked");
                  },
                  child: Icon(
                    Icons.nights_stay_outlined,
                    color: Color.fromARGB(255, 246, 231, 61),
                    size: 18,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  OutlinedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
                      side: MaterialStatePropertyAll(
                        BorderSide(color: Colors.orange),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Mainscreen();
                        },
                      ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.expand_less_outlined,
                          color: Colors.orange[800],
                        ),
                        Text(
                          "BACK",
                          style: TextStyle(
                            color: Colors.orange[800],
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(width: 8),
                  OutlinedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
                      side: MaterialStatePropertyAll(
                        BorderSide(color: Color.fromARGB(255, 4, 178, 62)),
                      ),
                    ),
                    onPressed: () {
                      print("icon clicked");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.list_alt_sharp,
                          color: Color.fromARGB(255, 4, 178, 62),
                          size: 12,
                        ),
                        const Text(
                          "  New Invoice",
                          style: TextStyle(
                            color: Color.fromARGB(255, 4, 178, 62),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
