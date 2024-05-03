class ApiReponseError {
  ApiReponseError({
    required this.message,
  });

  factory ApiReponseError.fromJson(Map<String, dynamic> json) =>
      ApiReponseError(
        message: json['message'],
      );
  final String message;

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
