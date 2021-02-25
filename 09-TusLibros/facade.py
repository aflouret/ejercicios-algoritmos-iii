from cart import Cart
from ticket import Ticket
from datetime import timedelta

class Facade:

    def __init__(self, aCatalog, aCashier, aClock, anAuthenticator):
        self.catalog = aCatalog
        self.clock = aClock
        self.cashier = aCashier
        self.authenticator = anAuthenticator
        'database'
        self.cartsByCartId = {}
        self.cartsLastUpdateTimeByCartId = {}
        self.clientIdByCartId = {}
        self.transactionIdByClientId = {}
        self.ticketsByTransactionId = {}

    def createCart(self, aClientId, aPassword):

        authenticationResult = self.authenticator.authenticate(aClientId, aPassword)
        if authenticationResult == False:
            raise Exception("Invalid credentials")

        cartId = len(self.cartsByCartId)
        cart = Cart(self.catalog)
        self.cartsByCartId[cartId] = cart
        self.clientIdByCartId[cartId] = aClientId
        self.updateCartTime(cartId)

        return cartId

    def listCart(self, aCartId):

        if aCartId not in self.cartsByCartId:
            raise Exception("There are no carts with that ID")
        cart = self.cartsByCartId[aCartId]

        self.updateCartTime(aCartId)
        return cart.listCart()

    def addToCart(self, aCartId, aBookIsbn, aBookQuantity):
        if aCartId not in self.cartsByCartId:
            raise Exception("There are no carts with that ID")

        self.updateCartTime(aCartId)
        cart = self.cartsByCartId[aCartId]
        cart.addToCart(aBookIsbn, aBookQuantity)
        self.cartsByCartId[aCartId] = cart

    def checkOutCart(self, aCartId, aCreditCardNumber, aCreditCardExpirationDate, aCreditCardOwnerName):
        if aCartId not in self.cartsByCartId:
            raise Exception("There are no carts with that ID")
        self.updateCartTime(aCartId)
        cart = self.cartsByCartId[aCartId]
        ticket = self.cashier.checkOutCart(cart, aCreditCardNumber, aCreditCardExpirationDate)
        transactionId = len(self.ticketsByTransactionId)
        clientId = self.clientIdByCartId[aCartId]
        self.ticketsByTransactionId[transactionId] = ticket
        if clientId in self.transactionIdByClientId:
            self.transactionIdByClientId[clientId].append(transactionId)
        else:
            self.transactionIdByClientId[clientId] = [transactionId]
        return transactionId

    def listPurchases(self, aClientId, aPassword):
        authenticationResult = self.authenticator.authenticate(aClientId, aPassword)
        if authenticationResult == False:
            raise Exception("Invalid credentials")
        transactionIds = self.transactionIdByClientId[aClientId]
        salesReports = [self.ticketsByTransactionId[transactionId] for transactionId in transactionIds]
        totalAmount = 0
        listOfBooks= []
        for report in salesReports:
            totalAmount += report.totalAmount()
            for book, quantity in report.listOfBooksByQuantity().items():
                listOfBooks += [book] * quantity
        return Ticket.generate(totalAmount, listOfBooks)

    def authenticate(self, aClientId, aPassword):
        idDatabase = {"Valid ID": "Valid Password", "Another Valid ID": "Another Valid Password"}
        return (aClientId in idDatabase) and (idDatabase[aClientId] == aPassword)

    def updateCartTime(self, aCartId):
        currentTime = self.clock.getTime()
        if aCartId in self.cartsLastUpdateTimeByCartId and currentTime > self.cartsLastUpdateTimeByCartId[aCartId] + timedelta(
                minutes=30):
            raise Exception("Cart expired")
        self.cartsLastUpdateTimeByCartId[aCartId] = currentTime

