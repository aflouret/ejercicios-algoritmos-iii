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
        ticket = Ticket.generate(aCart.totalAmount(), aCart.listCart())
        aCart.emptyCart()
        return ticket

    def numberOfBooksSold(self):
        return len(self.sales)

    def numberOfCopiesSold(self, aBook):
        return self.sales.count(aBook)

class Ticket:

    @classmethod
    def generate(cls, aTotalAmount, aListOfBooks):
        listOfBooksByQuantity = {book: aListOfBooks.count(book) for book in aListOfBooks}
        return cls(aTotalAmount, listOfBooksByQuantity)

    def __init__(self, aTotalAmount, aListOfBooksByQuantity):
        self._totalAmount = aTotalAmount
        self._listOfBooksByQuantity = aListOfBooksByQuantity

    def totalAmount(self):
        return self._totalAmount

    def listOfBooksByQuantity(self):
        return self._listOfBooksByQuantity

