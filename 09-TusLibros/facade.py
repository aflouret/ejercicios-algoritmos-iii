from cart import Cart
from cashier import Cashier
from datetime import datetime, date, time, timedelta


class Facade:

    def __init__(self, aCatalog, aCashier, aClock):
        self.catalog = aCatalog
        self.clock = aClock
        self.cashier = aCashier
        self.cartsById = {}
        self.cartsLastUpdateTime = {}

    def createCart(self, aClientId, aPassword):

        authenticationResult = self.authenticate(aClientId, aPassword)
        if authenticationResult == False:
            raise Exception("Invalid ID")

        cartId = len(self.cartsById)
        cart = Cart(self.catalog)
        self.cartsById[cartId] = cart

        self.updateCartTime(cartId)

        return cartId

    def listCart(self, aCartId):

        if aCartId not in self.cartsById:
            raise Exception("There are no carts with that ID")
        cart = self.cartsById[aCartId]

        self.updateCartTime(aCartId)
        return cart.listCart()

    def addToCart(self, aCartId, aBookIsbn, aBookQuantity):
        if aCartId not in self.cartsById:
            raise Exception("There are no carts with that ID")

        self.updateCartTime(aCartId)
        cart = self.cartsById[aCartId]
        cart.addToCart(aBookIsbn, aBookQuantity)
        self.cartsById[aCartId] = cart

    def checkOutCart(self, aCartId, aCreditCardNumber, aCreditCardExpirationDate, aCreditCardOwnerName):
        if aCartId not in self.cartsById:
            raise Exception("There are no carts with that ID")
        self.updateCartTime(aCartId)
        cart = self.cartsById[aCartId]
        self.cashier.checkOutCart(cart, aCreditCardNumber, aCreditCardExpirationDate)



    def authenticate(self, aClientId, aPassword):
        idDatabase = {"Valid ID": "Valid Password", "Another Valid ID": "Another Valid Password"}
        return (aClientId in idDatabase) and (idDatabase[aClientId] == aPassword)

    def updateCartTime(self, aCartId):
        currentTime = self.clock.getTime()
        if aCartId in self.cartsLastUpdateTime and currentTime > self.cartsLastUpdateTime[aCartId] + timedelta(
                minutes=30):
            raise Exception("Cart expired")
        self.cartsLastUpdateTime[aCartId] = currentTime


class ClockSimulator:

    def __init__(self):
        self.time = datetime.now()

    def getTime(self):
        return self.time

    def goForward(self, aTimeDelta):
        self.time += aTimeDelta