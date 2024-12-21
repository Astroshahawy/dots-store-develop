mixin ApiUrls {
  //* Base url
  static const baseUrlApi = 'https://dotsapp.co/public/api/vendor/';
  static const keyHeaderToken = 'notRequiresTokenKey';

  //* auth
  static const login = 'login';
  static const employeeLogin = 'employee_login';
  static const logout = 'logout';
  //* offer
  static const offersList = 'dots-package';
  static const cashbackRequest = 'cashback-request';
  static const cashbackOffers = 'cashback-offers';
  static const giveBalance = 'give_balance';
  static const givePoints = 'give_points';
  static const giveMeal = 'give_free_meal';
  static const staticPages = 'https://dotsapp.co/public/api/pages/2';
  //*
  static const unpaidInvoice = 'unpaid-point-invoice-list';
  static const paidInvoice = 'paid-point-invoice-list';

  static const addEmployee = 'add_employee';
  static const listEmployees = 'list_employees';
  static const deleteEmployee = 'delete_employee';

  static const sliderHome = 'slider';

  static const notifications = 'notifications';

  static const confirmCashbackOffer = 'confirm_cashback_offer';

  // static __(int id) => '/$id';
}
