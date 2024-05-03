import 'package:answers_ai/data/repository/chat/chat_repo_impl.dart';
import 'package:answers_ai/data/repository/onboarding/onboarding_repo_impl.dart';
import 'package:answers_ai/data/usecase/onboarding/create_user.dart';
import 'package:answers_ai/domain/firebase/firebase_config.dart';
import 'package:answers_ai/domain/reository/chat_repository.dart';
import 'package:answers_ai/domain/reository/onboarding_repository.dart';
import 'package:answers_ai/presentation/blocs/chat/chat%20history%20list/chat_history_list_bloc.dart';
import 'package:answers_ai/presentation/blocs/chat/current%20chat/current_chat_bloc.dart';
import 'package:answers_ai/presentation/blocs/internet%20connectivity/internet_connectivity_bloc.dart';
import 'package:answers_ai/presentation/blocs/onboarding/create%20user/create_user_bloc.dart';
import 'package:answers_ai/presentation/blocs/onboarding/login%20user/login_user_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/usecase/chat/add_chat.dart';
import '../../data/usecase/chat/get_chat.dart';
import '../../data/usecase/chat/get_chat_history.dart';
import '../../data/usecase/onboarding/login_user.dart';

final getItInstance = GetIt.I;

Future<void> init() async {
  getItInstance.registerLazySingleton<FierbaseConfig>(() => FierbaseConfig());

// Repository
  getItInstance.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(fierbaseConfig: getItInstance()));
  getItInstance.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(firebaseConfig: getItInstance()));

// Chat Use case

  getItInstance.registerLazySingleton<AddChat>(
      () => AddChat(chatRepository: getItInstance()));
  getItInstance.registerLazySingleton<GetChat>(
      () => GetChat(chatRepository: getItInstance()));
  getItInstance.registerLazySingleton<GetChatHistory>(
      () => GetChatHistory(chatRepository: getItInstance()));

// Onboarding Use canse
  getItInstance.registerLazySingleton<CreateUser>(
      () => CreateUser(onboardingRepository: getItInstance()));
  getItInstance.registerLazySingleton<LoginUser>(
      () => LoginUser(onboardingRepository: getItInstance()));

// Onbaording blocs
  getItInstance.registerLazySingleton<LoginUserBloc>(
      () => LoginUserBloc(loginUser: getItInstance()));
  getItInstance.registerLazySingleton<CreateUserBloc>(
      () => CreateUserBloc(createUser: getItInstance()));

// Chatbloc
  getItInstance.registerLazySingleton<CurrentChatBloc>(
    () => CurrentChatBloc(
      getChat: getItInstance(),
      addChat: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<ChatHistoryListBloc>(
    () => ChatHistoryListBloc(getChatHistory: getItInstance()),
  );

  //Connectivity bloc
  getItInstance.registerLazySingleton<InternetConnectivityBloc>(
    () => InternetConnectivityBloc(),
  );
}
