import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black54,
        // backgroundColor: Colors.black12,
        //  primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      ),
      home: homepage(),
    );
  }
}

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String answer = '';
  String equation = '';
  String expression = '';

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        answer = '0';
      } else if (buttonText == 'DEL') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '';
        }
      } else {
        if (buttonText == '=') {
          expression = equation;
          expression = expression.replaceAll('x', '*');
          try {
            Parser p = new Parser();
            Expression e = p.parse(expression);
            ContextModel cm = ContextModel();
            answer = '${e.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            Text('ERROR');
          }
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buttons(
    String b_text,
    Color b_color,
  ) {
    return Container(
      padding: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height * 0.12,
      //  width: MediaQuery.of(context).size.width * 0.05,
      child: SizedBox(
        width: 5,
        child: TextButton(
          child: Text(
            b_text,
            style: TextStyle(
              color: Color.fromARGB(255, 227, 152, 22),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => buttonPressed(b_text),
          style: TextButton.styleFrom(
            backgroundColor: b_color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)
                    // side: BorderSide(color: Colors.black54,width: 5)),
                    ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final App = AppBar(
      title: Text('Calculator'),
    );
    return Scaffold(
      appBar: App,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Text(
                equation,
                style: TextStyle(color: Colors.red, fontSize: 38),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Text(
                answer,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 42,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              // height: (MediaQuery.of(context).size.height -
              //         App.preferredSize.height -
              //         MediaQuery.of(context).padding.top) *
              //     0.5,
              //  width: MediaQuery.of(context).size.width * 1,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                buttons("C", Colors.redAccent),
                                buttons("DEL", Colors.black54),
                                buttons("%", Colors.black54),
                                buttons("/", Colors.black54)
                              ],
                            ),
                            TableRow(
                              children: [
                                buttons("7", Colors.black54),
                                buttons("8", Colors.black54),
                                buttons("9", Colors.black54),
                                buttons("x", Colors.black54)
                              ],
                            ),
                            TableRow(
                              children: [
                                buttons("6", Colors.black54),
                                buttons("5", Colors.black54),
                                buttons("4", Colors.black54),
                                buttons("-", Colors.black54)
                              ],
                            ),
                            TableRow(
                              children: [
                                buttons("3", Colors.black54),
                                buttons("2", Colors.black54),
                                buttons("1", Colors.black54),
                                buttons("+", Colors.black54)
                              ],
                            ),
                            TableRow(
                              children: [
                                buttons("0", Colors.black54),
                                buttons("00", Colors.black54),
                                buttons(".", Colors.black54),
                                buttons("=", Colors.black54),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
