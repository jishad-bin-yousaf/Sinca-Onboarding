import 'package:animated_onboarding/screens/onboard/dashPage.dart';
import 'package:animated_onboarding/screens/onboard/onboard.dart';
import 'package:animated_onboarding/screens/onboard/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class Mainscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SincA Login'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showMainScreen', true);

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Onboard(),
                  ));
                },
                icon: Icon(Icons.logout_outlined))
          ],
        ),
        body: Loginpage());
  }
}

class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 0, 162, 255),
      child: Stack(
        children: [
          Card(
            elevation: 0,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 161, 202, 202),
                      Color.fromARGB(255, 184, 250, 255),
                      Color.fromARGB(255, 0, 166, 255),
                    ],
                  ),
                ),
                child: Center(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      Center(
                        child: Container(
                          height: 500,
                          margin: EdgeInsets.all(25),
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                elevation: 6,
                                child: SizedBox(
                                  width: 400,
                                  height: 450,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Card(
                                        elevation: 0,
                                        margin: EdgeInsets.only(top: 10),
                                        child: Image.asset(
                                          "images/sinca.png",
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 160,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      loginRow,
                                      username,
                                      password(setState),
                                      loginButton,
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return SincaDash();
                                            },
                                          ));
                                          print("Demo Button clicked!!!");
                                        },
                                        child: const Text(
                                          "Demo",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 15, 75, 226),
                                          ),
                                        ),
                                      ),
                                      forgetPassword,
                                      smallScreenIcons,
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

  Widget bottomColumn = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            Icons.desktop_windows_outlined,
            color: Colors.blue,
            size: 40,
          ),
          Icon(
            Icons.android,
            color: Colors.green,
            size: 40,
          ),
          Icon(
            Icons.apple,
            size: 40,
          ),
          Icon(Icons.cloud, color: Colors.blue, size: 40)
        ],
      ),
      Image.asset("images/download.png", height: 44)
    ],
  );

  Widget deviceIMG = Image.asset("images/device.png",
      width: 390, height: 380, fit: BoxFit.fitWidth);

  bool isChecked = false;

  Widget loginRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Card(
        elevation: 0,
        margin: EdgeInsets.only(left: 5),
        child: Text(
          "Login",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //   const Text("Staff Login "),
          //   StatefulBuilder(builder: (context, refresh) {
          //     return Checkbox(
          //       value: isChecked,
          //       onChanged: (value) {
          //         refresh(() {
          //           isChecked = value ?? false;
          //         });
          //       },
          //     );
          //   }),
        ],
      )
    ],
  );

  Widget username = Card(
    margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
    elevation: 5,
    child: TextField(
      onChanged: (value) {
        print("Username : " + value);
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(25, 33, 149, 243)),
        ),
        labelText: "User name",
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 40, 112, 206),
        ),
      ),
    ),
  );
  bool _isHidden = true;

  Widget password(void Function(VoidCallback fn) setState) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
      child: TextFormField(
        // validator: (value) {
        //   if (value == null || value.length <= 6) {
        //     return "should be more than 7 charectors";
        //   } else {
        //     return null;
        //   }
        // },
        obscureText: _isHidden,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(25, 33, 149, 243)),
          ),
          labelText: "Password",
          suffix: InkWell(
            onTap: () {
              _togglePasswordView(setState);
            },
            child: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 40, 112, 206),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView(void Function(VoidCallback fn) setState) {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Widget loginButton = ElevatedButton(
    onPressed: () {
      print("Clicked");
    },
    child: Text(
      "Login",
    ),
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromARGB(255, 15, 75, 226)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      padding: const MaterialStatePropertyAll(
        EdgeInsets.only(
          left: 100,
          right: 100,
          top: 21,
          bottom: 21,
        ),
      ),
    ),
  );

  Widget demoButton = TextButton(
    onPressed: () {
      // Navigator.push(context, MaterialPageRoute(
      //                   builder: (context) {
      //                     return Mainscreen();
      //                   },
      //                 ));
      print("Demo Button clicked!!!");
    },
    child: const Text(
      "Demo",
      style: TextStyle(
        color: Color.fromARGB(255, 15, 75, 226),
      ),
    ),
  );

  Widget forgetPassword = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Do You Have An Account ?",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      TextButton(
        onPressed: () {
          print("SignUp Button clicked!!!");
        },
        child: const Text(
          "Sign Up Now!",
          style: TextStyle(
            color: Color.fromARGB(255, 15, 75, 226),
            //     fontSize: 10,
          ),
        ),
      ),
    ],
  );

  Widget smallScreenIcons = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            Icons.desktop_windows_outlined,
            color: Colors.blue,
            size: 30,
          ),
          Icon(
            Icons.android,
            color: Colors.green,
            size: 30,
          ),
          Icon(
            Icons.apple,
            size: 30,
          ),
          Icon(Icons.cloud, color: Colors.blue, size: 40)
        ],
      ),
      Image.asset(
        "images/download.png",
        height: 34,
      ),
    ],
  );
}
