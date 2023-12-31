class APiEndpoint {
  static final baseUrl = "https://book-crud-service-6dmqxfovfq-et.a.run.app";
  static _AuthEndpoints authEndpoints = _AuthEndpoints();
}

class _AuthEndpoints {
  final String registerEmail = "/api/register";
  final String loginEmail = "/api/login";
  final String books = "/api/books";
  final String addBooks = "/api/books/add";
}
