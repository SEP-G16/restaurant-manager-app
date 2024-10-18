enum OrderStatus{
  Pending, Processing, Complete, Cancelled, Pending_Payment;

  static OrderStatus fromString(String status){
    switch(status){
      case 'Pending':
        return OrderStatus.Pending;
      case 'Processing':
        return OrderStatus.Processing;
      case 'Complete':
        return OrderStatus.Complete;
      case 'Cancelled':
        return OrderStatus.Cancelled;
      case 'Pending_Payment':
        return OrderStatus.Pending_Payment;
      default:
        return OrderStatus.Pending;
    }
  }
}