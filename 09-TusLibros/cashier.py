from ticket import Ticket

class Cashier:

    def __init__(self, aCatalog, aMerchantProcessor):
        self.sales = []
        self.catalog = aCatalog
        self.merchantProcessor = aMerchantProcessor
        self.totalAmount = 0

    def checkOutCart(self, aCart, aCreditCardNumber, aCreditCardExpirationDate):
        if aCart.isEmpty():
            raise Exception("Empty cart cannot be checked out")

        transactionResult = self.merchantProcessor.processPayment(aCreditCardNumber, aCreditCardExpirationDate, aCart.totalAmount)

        if transactionResult[0] == "1":
            raise Exception()

        self.sales = aCart.listCart()
        ticket = Ticket.generate(aCart.totalAmount(), aCart.listCart())
        aCart.emptyCart()
        return ticket

    def numberOfBooksSold(self):
        return len(self.sales)

    def numberOfCopiesSold(self, aBook):
        return self.sales.count(aBook)



