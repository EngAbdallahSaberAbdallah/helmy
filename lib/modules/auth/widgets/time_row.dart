import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/functions.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../cubits/timer_cubit/timer_cubit.dart';
import 'row_with_on_tab_text.dart';

class TimerRow extends StatelessWidget {
  final String mail;

  const TimerRow({
    super.key,
    required this.mail,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResentOTPLoading) {
          loading(context);
        }
        if (state is ResentOTPSuccess) {
          context.read<TimerCubit>().startTimer();
          Navigator.pop(context);
        }
        if (state is ResentOTPError) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<TimerCubit, int>(
        builder: (context, state) {
          final minutes = (state ~/ 60).toString().padLeft(2, '0');
          final seconds = (state % 60).toString().padLeft(2, '0');
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowWithOnTabText(
                firstTextColor: Theme.of(context).primaryColorLight,
                firstText: StringsManager.didNotReceiveVerificationCode,
                secondText: StringsManager.resend,
                onTabTextColor: state != 0
                    ? ColorsManager.primaryTxtDarkGrey
                    : ColorsManager.primaryDarkPurple,
                onTab: state != 0
                    ? null
                    : () {
                        debugPrint('OnTab Work');
                        context
                            .read<AuthBloc>()
                            .add(ResentOTP(mail: mail));
                      },
              ),
              Text(
                '$minutes:$seconds',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: AppSize.s13,
                    color: ColorsManager.primaryDarkPurple),
              )
            ],
          );
        },
      ),
    );
  }
}
