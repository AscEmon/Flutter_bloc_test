import 'package:bloc_test/mvc/get_module/bloc/get_event.dart';
import 'package:bloc_test/mvc/get_module/bloc/get_state.dart';
import 'package:bloc_test/mvc/get_module/bloc/get_bloc.dart';
import 'package:bloc_test/mvc/signin_module/views/signin_screen.dart';
import 'package:bloc_test/utils/extention.dart';
import 'package:bloc_test/utils/navigation_service.dart';
import 'package:bloc_test/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetScreen extends StatelessWidget {
  const GetScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetBloc>(context).add(GainedEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GetScreen",
        ),
        actions: [
          InkWell(
            onTap: () => SignInScreen().push(context),
            child: Icon(Icons.login),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<GetBloc, GetState>(
              builder: (context, state) {
                if (state.allGetStatus.isSuccess) {
                  return ListView.builder(
                    itemCount: state.couponDataList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: KColor.fill.color,
                        title: Text(
                          state.couponDataList[index].offerText ?? "",
                        ),
                        subtitle:
                            Text(state.couponDataList[index].offerCode ?? ""),
                        trailing: Column(
                          children: [
                            Text("validity"),
                            Text(state.couponDataList[index].validity ?? ""),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state.allGetStatus.isLoading) {
                  return SizedBox(
                    height: context.height / 1.2,
                    child: centerCircularProgress(),
                  );
                } else {
                  return SizedBox(
                    height: 0,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
