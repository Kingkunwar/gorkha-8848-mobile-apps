class Failure {
  String? message;

  Failure({
    this.message,
  });

  Failure.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? json['msg'] ?? "Something went wrong.";
  }
}

class Success {
  String? message;
  Success({
    this.message,
  });

  Success.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
