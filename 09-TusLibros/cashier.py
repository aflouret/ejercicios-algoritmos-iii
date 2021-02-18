from merchant_processor import MerchantProcessor

class Cashier:

    def __init__(self, aCatalog):
        self.sales = []
        self.catalog = aCatalog
        self.totalAmount = 0

    def checkOutCart(self, aCart, aCreditCardNumber, aCreditCardExpirationDate):
        if aCart.isEmpty():
            raise Exception("Empty cart cannot be checked out")

        merchantProcessor = MerchantProcessor()
        transactionResult = merchantProcessor.processPayment(aCreditCardNumber, aCreditCardExpirationDate, aCart.totalAmount)

        if transactionResult[0] == "1":
            raise Exception()

        self.sales = aCart.listCart()
        self.totalAmount = aCart.totalAmount
        aCart.emptyCart()

    def numberOfBooksSold(self):
        return len(self.sales)

    def numberOfCopiesSold(self, aBook):
        return self.sales.count(aBook)