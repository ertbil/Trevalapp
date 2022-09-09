import 'package:flutter/material.dart';
import 'package:trevalapp/pages/main_page.dart';
import 'package:trevalapp/pages/register_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child :  Travelapp(),));
}

class Travelapp extends StatelessWidget {
const Travelapp({Key? key}) : super(key: key);


@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Student App Demo',
    theme: ThemeData(

      primarySwatch: Colors.blue,
    ),
    home:  const LogInPage(),
  );
}
}

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo_holder.png',
                height: 90,
                width: 90,
              ),
            )
            ,
            Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if(value != null){

                              if(value.isEmpty){
                                return "This Place can not be empty";
                              }else if( usernameController.text != "admin"){
                                return "There is no account";
                              }
                            }
                            return null;
                          },

                          controller: usernameController,
                          decoration: InputDecoration(border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),

                            labelText: "Username",
                            floatingLabelStyle: const TextStyle(
                              height: 4,
                            ),

                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: const Icon(Icons.person),),

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if(value != null){

                                  if(value.isEmpty){
                                    return "This Place can not be empty";
                                  }
                                  else if( passwordController.text != "admin"){
                                    return "There is no account";
                                  }
                                }
                                return null;
                              },
                              controller: passwordController,
                              obscureText: isPasswordHidden,

                              decoration: InputDecoration(border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide.none,
                              ),

                                labelText: "Password",
                                floatingLabelStyle: const TextStyle(
                                  height: 4,
                                ),

                                filled: true,
                                fillColor: Colors.grey[200],
                                prefixIcon: const Icon(Icons.key),
                                suffixIcon: IconButton(
                                  icon: AnimatedCrossFade(
                                    firstChild:const Icon(Icons.remove_red_eye),
                                    secondChild: const Icon(Icons.remove_red_eye_outlined),
                                    crossFadeState: isPasswordHidden ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                    duration: const Duration(milliseconds: 300),
                                  ),

                                  onPressed: () {
                                    setState(() {
                                      isPasswordHidden = !isPasswordHidden;
                                    });

                                    }
                                    )
                                   ),),

                            Row(
                              children: [
                                TextButton(onPressed: (){
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    // false = user must tap button, true = tap outside dialog
                                    builder: (BuildContext dialogContext) {
                                      return  AlertDialog(
                                        title: const Text('Your Password'),
                                        content: Column(
                                        children : const [
                                          Text("Username: admin"),
                                          Text("Password: admin"),
                                          ],
                                        )
                                      );
                                    },
                                  );
                                },child: const Text("Forgotten Password?")
                                ),
                              ],
                            ),

                          ],
                        ),

                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: const Text("Log in"),
                              onPressed: () {
                                final bool? everythingOK = formKey.currentState
                                    ?.validate();

                                if (everythingOK == true) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                        return const MainPage();
                                      }
                                      )
                                  );
                                }
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: const Text("Register"),
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return const RegisterPage();
                                }));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}