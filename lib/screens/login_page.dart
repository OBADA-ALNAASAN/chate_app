import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:chat_app/widgets/coustom_button.dart';
import 'package:chat_app/widgets/coustomtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = "/";

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    bool isLoading = false;

    GlobalKey<FormState> formstate = GlobalKey();
    return SafeArea(
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is Loginloding) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            isLoading = false;
            Navigator.pushNamed(context, ChatPage.id, arguments: email);
          } else if (state is LoginFailure) {
            isLoading = false;
            showSnackBar(context, state.errtext);
          }
        },
        builder: (context, state) => ModalProgressHUD(
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
                          'Login',
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
                      onTap: () async {
                        if (formstate.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context)
                              .loginUser(email: email!, password: password!);
                          BlocProvider.of<ChatCubit>(context).getMessages();
                        }
                      },
                      text: 'Login',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an accont?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RegisterPage.id,
                            );
                          },
                          child: const Text(
                            ' Register',
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
        ),
      ),
    );
  }
}
