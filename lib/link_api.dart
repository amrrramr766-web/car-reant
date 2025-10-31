class LinkApi {
  static const String baseUrl = "https://192.168.1.11:7237/api";

  // Users
  static const String login = "$baseUrl/users/login";
  static const String register = "$baseUrl/users/register";

  // Cars
  static const String getCars = "$baseUrl/car"; // GET => Get all cars
  static const String getCarById = "$baseUrl/car/"; // GET + id => Get car by Id
  static const String addCar = "$baseUrl/car"; // POST => Add new car
  static const String updateCar = "$baseUrl/car/"; // PUT + id => Update car
  static const String deleteCar = "$baseUrl/car/"; // DELETE + id => Delete car

  static const String getReviwe = "$baseUrl/Reviwe"; // GET => Get all cars
  static const String getReviweByCarId =
      "$baseUrl/Reviwe/car/"; // GET => Get all cars
  static const String updateReviwe = "$baseUrl/Reviwe/"; // GET => Get all cars
  static const String deleteReviwe = "$baseUrl/Reviwe/"; // GET => Get all cars

  static const String getAllBooking = "$baseUrl/Booking";
  static const String addBooking = "$baseUrl/Booking";
  static const String getBookingsByUser = "$baseUrl/Booking/GetByUser";

  static const String getBookingById =
      "$baseUrl/Booking/"; // GET => Get all cars

  static const String getOffers = "$baseUrl/Offers"; // GET => Get all offers

  static const String getSuggestions =
      "$baseUrl/Suggestions"; // GET => Get all suggestions

  static const String Search =
      "$baseUrl/Suggestions/Search"; // POST => Send search query
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
