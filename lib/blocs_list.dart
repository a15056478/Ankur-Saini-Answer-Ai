import 'package:answers_ai/presentation/blocs/chat/chat%20history%20list/chat_history_list_bloc.dart';
import 'package:answers_ai/presentation/blocs/chat/current%20chat/current_chat_bloc.dart';
import 'package:answers_ai/presentation/blocs/internet%20connectivity/internet_connectivity_bloc.dart';
import 'package:answers_ai/presentation/blocs/onboarding/create%20user/create_user_bloc.dart';
import 'package:answers_ai/presentation/blocs/onboarding/login%20user/login_user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:answers_ai/domain/di/get_it.dart' as get_it;

class AppBlocs {
  AppBlocs();

  List<BlocProvider> blocs = [
    BlocProvider<LoginUserBloc>(
      create: (context) => get_it.getItInstance<LoginUserBloc>(),
    ),
    BlocProvider<CreateUserBloc>(
      create: (context) => get_it.getItInstance<CreateUserBloc>(),
    ),
    BlocProvider<CurrentChatBloc>(
      create: (context) => get_it.getItInstance<CurrentChatBloc>(),
    ),
    BlocProvider<ChatHistoryListBloc>(
      create: (context) => get_it.getItInstance<ChatHistoryListBloc>(),
    ),
    BlocProvider<InternetConnectivityBloc>(
      create: (context) => get_it.getItInstance<InternetConnectivityBloc>(),
    ),
  ];
}
