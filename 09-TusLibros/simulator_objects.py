from datetime import datetime


class AuthenticatorSimulator:

    def authenticate(self, aClientId, aPassword):
        idDatabase = {"Valid ID": "Valid Password", "Another Valid ID": "Another Valid Password"}
        return (aClientId in idDatabase) and (idDatabase[aClientId] == aPassword)

class ClockSimulator:

    def __init__(self):
        self.time = datetime.now()

    def getTime(self):
        return self.time

    def goForward(self, aTimeDelta):
        self.time += aTimeDelta

class MerchantProcessor:

    def validateCreditCardExpiration(self, aCreditCardExpirationDate):
        month = int(aCreditCardExpirationDate[0:2])
        year = int(aCreditCardExpirationDate[2:])
        currentYear, currentMonth, currentDay = str(datetime.now().date()).split("-")
        if int(year) > int(currentYear):
            return 0
        if int(year) == int(currentYear) and int(month) >= int(currentMonth):
            return 0
        return 1

    def validateCreditCardNumber(self, aCreditCardNumber):
        invalidNumber = "1111111111111111"
        if aCreditCardNumber == invalidNumber:
            return 1
        return 0

    def processPayment(self, aCreditCardNumber, aCreditCardExpirationDate, aTransactionAmount):
        if self.validateCreditCardExpiration(aCreditCardExpirationDate) == 1:
            return "1|CREDIT_CARD_EXPIRED"
        if self.validateCreditCardNumber(aCreditCardNumber) == 1:
            return "1|INVALID_CREDIT_CARD_NUMBER"
        return "0|OK"