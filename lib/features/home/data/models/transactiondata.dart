class TransactionData {
  const TransactionData({
    required this.tranxType,
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.isDebit,
  });

  final String tranxType;
  final String title;
  final DateTime dateTime;
  final String amount;
  final bool isDebit;
}
