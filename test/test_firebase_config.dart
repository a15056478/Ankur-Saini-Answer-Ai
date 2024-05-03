import 'package:answers_ai/main.dart';
import 'package:answers_ai/model/chat/chat_detail.dart';
import 'package:answers_ai/model/error/api_response_error.dart';
import 'package:answers_ai/model/prams/chat/add_chat_params.dart';
import 'package:answers_ai/model/prams/chat/chat_history_params.dart';
import 'package:answers_ai/model/prams/chat/chat_list_params.dart';
import 'package:answers_ai/model/prams/login/login_user_params.dart';
import 'package:answers_ai/model/prams/signup/create_user_params.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

/// FirebaseConfig class to handle database operations on Firestore
class FakeFierbaseConfig {
  // Intsantiating database
  final db = FakeFirebaseFirestore();

  /// Function to register new user
  Future<Either<ApiReponseError, bool>> createUser(
      {required CreateUserParams params}) async {
    final docRef = db.collection("users").doc(params.userInfo.email);
    final userExists = await docRef.get().then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          return true;
        } else {
          return false;
        }
      },
      onError: (e) => true,
    );
    if (!userExists) {
      final user = <String, String>{
        "email": params.userInfo.email,
        "token": params.userInfo.token,
        "last_login": DateTime.now().toString(),
      };
      db.collection("users").doc(params.userInfo.email).set(user);
      return const Right(true);
    }
    return Left(ApiReponseError(message: 'User already exists'));
  }

  /// Function to search a user for login
  Future<Either<ApiReponseError, bool>> loginUser(
      {required LoginUserParams params}) async {
    try {
      final docRef = db.collection("users").doc(params.userInfo.email);
      final response = await docRef.get().then(
        (DocumentSnapshot doc) {
          if (doc.exists) {
            final data = doc.data() as Map<String, dynamic>;
            dprint(data['email'] + data['token']);

            if (data['email'] == params.userInfo.email &&
                data['token'] == params.userInfo.token) {
              return true;
            } else {
              return false;
            }
          }
          return false;
        },
        onError: (e) => false,
      );
      return response
          ? Right(response)
          : Left(
              ApiReponseError(
                message: 'Something went wrong',
              ),
            );
    } catch (e) {
      return Left(
        ApiReponseError(
          message: 'Something went wrong',
        ),
      );
    }
  }

  /// Function to get chat history by chatId
  Future<Either<ApiReponseError, List<ChatDetail>>> getChat({
    required ChatListParams params,
  }) async {
    try {
      final collectionRef = db.collection(params.user.email);
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await collectionRef.doc(params.chatId).get();

      final data = snapshot.data()!['chats'] as List<dynamic>;

      return Right(data
          .map((e) => ChatDetail(
                content: e['content'],
                timestamp: e['time_stamp'].toDate(),
                userResponse: e['user_response'],
                role: e['role'],
              ))
          .toList());
    } catch (e) {
      return Left(ApiReponseError(message: 'Something went wrong'));
    }
  }

  /// Function to add new chat in the list
  Future<Either<ApiReponseError, bool>> addChat({
    required AddChatParams params,
  }) async {
    try {
      dprint(params.chatId);
      final chatData = <String, dynamic>{
        "content": params.chat.content,
        "time_stamp": params.chat.timestamp,
        "user_response": params.chat.userResponse,
        "role": params.chat.role,
      };
      var collection = db.collection(params.user.email);
      if (params.isFirstChat) {
        collection
            .doc(params.chatId)
            .set({
              'chats': FieldValue.arrayUnion([chatData])
            })
            .then((_) => dprint('Added'))
            .catchError(
              (error) => Left(
                ApiReponseError(
                  message: 'Unable to insert chat',
                ),
              ),
            );
      } else {
        collection
            .doc(params.chatId)
            .update({
              'chats': FieldValue.arrayUnion([chatData])
            })
            .then((_) => dprint('Added'))
            .catchError(
              (error) => Left(
                ApiReponseError(
                  message: 'Unable to insert chat',
                ),
              ),
            );
      }
      return const Right(true);
    } catch (e) {
      return Left(
        ApiReponseError(
          message: 'Something went wrong',
        ),
      );
    }
  }

  /// Function to get id list of old chats
  Future<Either<ApiReponseError, List<String>>> getChatHistoryList({
    required ChatHistoryParams params,
  }) async {
    try {
      final collectionRef = db.collection(params.user.email);
      QuerySnapshot querySnapshot = await collectionRef.get();
      var list = querySnapshot.docs;
      return Right(list.map((e) => e.id.toString()).toList());
    } catch (e) {
      return Left(
        ApiReponseError(
          message: 'Something went wrong',
        ),
      );
    }
  }
}
