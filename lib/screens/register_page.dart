
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/Auth_cubit/auth_cubit.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/widgets/coustom_button.dart';
import 'package:chat_app/widgets/coustomtextformfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static String id = '/registerpage';

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    bool isLoading = false;
    GlobalKey<FormState> formstate = GlobalKey();
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Registerloding) {
            isLoading = true;
          } else if (state is RegisterSuccess) {
            isLoading = false;
            Navigator.pushNamed(context, ChatPage.id, arguments: email);
          } else if (state is RegisterFailure) {
            isLoading = false;
            showSnackBar(context, state.errtext);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: formstate,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 75,
                      ),
                      Image.asset(
                        'assets/images/scholar.png',
                        height: 100,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Scholer Chat',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontFamily: 'pacifico'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 75,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Coustomtextformfield(
                        hintText: 'Email',
                        onChange: (data) {
                          email = data;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Coustomtextformfield(
                        hintText: 'Password',
                        abscureText: true,
                        onChange: (data) {
                          password = data;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CoustomButton(
                        text: 'Register',
                        onTap: () async {
                          if (formstate.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context)
                                .registerUser(email, password);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already have an accont?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              ' Login',
                              style: TextStyle(
                                color: Color(0xffc7ede6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
