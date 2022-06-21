import 'package:bloc_test/global/widget/global_loader.dart';
import 'package:bloc_test/global/widget/global_text_form_field.dart';
import 'package:bloc_test/mvc/get_module/views/get_screen.dart';
import 'package:bloc_test/mvc/signin_module/bloc/signin_bloc.dart';
import 'package:bloc_test/mvc/signin_module/bloc/signin_event.dart';
import 'package:bloc_test/mvc/signin_module/bloc/signin_state.dart';
import 'package:bloc_test/utils/extention.dart';
import 'package:bloc_test/utils/navigation_service.dart';
import 'package:bloc_test/utils/styles/styles.dart';
import 'package:bloc_test/utils/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormPart extends StatelessWidget {
  FormPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white54,
          child: AutofillGroup(
            child: Column(
              children: [
                Form(
                  key: context.read<SignInBloc>().formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h),
                        child: GlobalTextFormField(
                          controller:
                              context.read<SignInBloc>().loginPhoneNumber,
                          line: 1,
                          hintText: "Phone Number",
                          onChanged: (value) {
                            context.read<SignInBloc>().add(ValidateEvent());
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputType: TextInputType.number,
                          maxlength: 11,
                          validator: (value) {
                            if (value!.trim().isEmpty)
                              return "Enter Phone number";
                            else if (value.phoneValid(value.toString()) ==
                                false)
                              return "Enter Valid Phone Number ";
                            else
                              return null;
                          },
                        ),
                      ),
                      BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 15.h),
                            child: GlobalTextFormField(
                              controller:
                                  context.read<SignInBloc>().loginPassword,
                              obscureText: state.passwordShow,
                              line: 1,
                              onChanged: (value) {
                                context.read<SignInBloc>().add(ValidateEvent());
                              },
                              hintText: "Enter Password",
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputType: TextInputType.text,
                              suffixIcon: InkWell(
                                  onTap: () {
                                    context
                                        .read<SignInBloc>()
                                        .add(PasswordShowEvent());
                                  },
                                  child: Icon(
                                    state.passwordShow
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Color(0xffbcbcbc),
                                  )),
                              validator: (value) {
                                if (value!.trim().isEmpty)
                                  return "Enter Password";
                                else
                                  return null;
                              },
                            ),
                          );
                        },
                      ),
                      BlocConsumer<SignInBloc, SignInState>(
                          builder: (context, state) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 15.h),
                          child: InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              context
                                  .read<SignInBloc>()
                                  .add(SignInSubmitEvent());
                            },
                            child: Container(
                              width: 372.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: state.isValidated
                                    ? Colors.red
                                    : Color(0xffbcbcbc),
                              ),
                              child: Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                      }, listener: (context, state) {
                        if (state.allPostStatus.isLoading) {
                          ViewUtil.showAlertDialog(content: GlobalLoader());
                        } else if (state.allPostStatus.isError) {
                          Navigation.pop(context);
                        } else if (state.allPostStatus.isSuccess) {
                          GetScreen().pushAndRemoveUntil(context);
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
