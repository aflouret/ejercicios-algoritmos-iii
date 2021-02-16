import unittest


class Cart:

    def __init__(self, aCatalog):
        self.books = []
        self.totalAmount = 0
        self.catalog = aCatalog

    def listCart(self):
        return self.books
    
    def quantity(self):
        return len(self.books)

    def isEmpty(self):
        return self.quantity() == 0

    def addToCart(self, aBook, catalog, aBookQuantity = 1):
        if (aBook in catalog) == False:
            raise Exception("Book not in catalog")
        if aBookQuantity < 1:
            raise Exception("Number of books should be positive")

        for _ in range(aBookQuantity):
            self.books.append(aBook)
            self.totalAmount += self.catalog[aBook]

    def hasBook(self,aBook):
        return aBook in self.books

    def quantityOfBook(self, aBook):
        return self.books.count(aBook)

    def emptyCart(self):
        self.books = []
        self.totalAmount = 0
    

class Cashier:

    def __init__(self, aCatalog):
        self.sales = []
        self.catalog = aCatalog
        self.totalAmount = 0

    def checkOutCart(self, aCart, aCreditCardNumber, aCreditCardExpirationDate):
        if aCart.isEmpty():
            raise Exception("Cart empty cannot be checked out")

        merchantProcessor = MerchantProcessor()
        transactionResult = merchantProcessor.debit(aCreditCardNumber, aCreditCardExpirationDate, aCart.totalAmount)
        if transactionResult == "1|CREDIT_CARD_EXPIRED":
            raise Exception("Credit card expired")
        if transactionResult == "1|INVALID_CREDIT_CARD_NUMBER":
            raise Exception("Invalid credit card number")

        self.sales = aCart.listCart()
        self.totalAmount = aCart.totalAmount
        aCart.emptyCart()

    def numberOfBooksSold(self):
        return len(self.sales)

    def numberOfCopiesSold(self, aBook):
        return self.sales.count(aBook)


class MerchantProcessor:

    def validateCreditCardExpiration(self, aCreditCardExpirationDate):
        month, year = aCreditCardExpirationDate.split("/")
        if int(year) > 2021:
            return 0
        if int(year) == 2021 and int(month) >= 2:
            return 0
        return 1

    def validateCreditCardNumber(self, aCreditCardNumber):
        invalidNumber = "1111111111111111"
        if aCreditCardNumber == invalidNumber:
            return 1
        return 0

    def debit(self, aCreditCardNumber, aCreditCardExpirationDate, aTransactionAmount):
        if self.validateCreditCardExpiration(aCreditCardExpirationDate) == 1:
            return "1|CREDIT_CARD_EXPIRED"
        if self.validateCreditCardNumber(aCreditCardNumber) == 1:
            return "1|INVALID_CREDIT_CARD_NUMBER"
        return "0|OK"

class TestTusLibros(unittest.TestCase):

    def test1_newCartIsEmpty(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        self.assertTrue(newCart.isEmpty())

    def test2_aBookInCatalogCanBeAddedToCart(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aBook = "Un libro"
        newCart.addToCart(aBook, catalog)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.hasBook(aBook))

    def test3_aBookNotInCatalogCanNotBeAddedToCart(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aBook = "Un libro que no esta"

        with self.assertRaises(Exception):
            newCart.addToCart(aBook, catalog)
        self.assertTrue(newCart.isEmpty())
        self.assertFalse(newCart.hasBook(aBook))

    def test4_canAddManyBooksOfSameTitle(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aBook = "Un libro"
        newCart.addToCart(aBook, catalog, 2)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.hasBook(aBook))
        self.assertEqual(newCart.quantity(), 2)

    def test5_canAddManyDifferentBooks(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aBook = "Un libro"
        anotherBook = "Otro libro"
        newCart.addToCart(aBook, catalog, 100)
        newCart.addToCart(anotherBook, catalog, 100)
        self.assertFalse(newCart.isEmpty())
        self.assertEqual(newCart.quantityOfBook(aBook), 100)
        self.assertEqual(newCart.quantityOfBook(anotherBook), 100)
        self.assertEqual(newCart.quantity(), 200)

    def test6_canOnlyAddAPositiveNumberOfBooks(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aBook = "Un libro"
        with self.assertRaises(Exception):
            newCart.addToCart(aBook, catalog, -3)
        self.assertTrue(newCart.isEmpty())
        self.assertFalse(newCart.hasBook(aBook))

    def test7_cannotCheckoutEmptyCart(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aCashier = Cashier(catalog)
        with self.assertRaises(Exception):
            aCashier.checkOutCart(newCart, "0123456789012345", "05/2023")
        self.assertTrue(newCart.isEmpty())

    def test8_cartIsEmptyAfterCheckout(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aCashier = Cashier(catalog)
        aBook = "Un libro"
        newCart.addToCart(aBook, catalog, 1)
        aCashier.checkOutCart(newCart, "0123456789012345", "05/2023")
        self.assertTrue(newCart.isEmpty())


    def test9_cashierKnowsNumberOfBooksSold(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aCashier = Cashier(catalog)
        aBook = "Un libro"
        newCart.addToCart(aBook, catalog, 1)
        aCashier.checkOutCart(newCart, "0123456789012345", "05/2023")
        self.assertEqual(aCashier.numberOfBooksSold(), 1)

    def test10_cashierKnowsNumberOfCopiesSoldOfDifferentBook(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aCashier = Cashier(catalog)
        aBook = "Un libro"
        anotherBook = "Otro libro"
        newCart.addToCart(aBook, catalog, 100)
        newCart.addToCart(anotherBook, catalog, 200)
        aCashier.checkOutCart(newCart, "0123456789012345", "05/2023")
        self.assertEqual(aCashier.numberOfBooksSold(), 300)
        self.assertEqual(aCashier.numberOfCopiesSold(aBook), 100)
        self.assertEqual(aCashier.numberOfCopiesSold(anotherBook), 200)

    def test11_cashierKnowsTotalAmount(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aCashier = Cashier(catalog)
        aBook = "Un libro"
        anotherBook = "Otro libro"
        newCart.addToCart(aBook, catalog, 100)
        newCart.addToCart(anotherBook, catalog, 200)
        aCashier.checkOutCart(newCart, "0123456789012345", "05/2023")
        self.assertEqual(aCashier.totalAmount, 40*100 + 80*200)

    def test12_cannotCheckOutWithExpiredCreditCard(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aCashier = Cashier(catalog)
        aBook = "Un libro"
        newCart.addToCart(aBook, catalog, 1)
        with self.assertRaises(Exception):
            aCashier.checkOutCart(newCart, "0123456789012345", "05/2020")
        self.assertFalse(newCart.isEmpty())
        self.assertEqual(aCashier.numberOfBooksSold(), 0)
        self.assertEqual(aCashier.totalAmount, 0)
        
    def test13_cannotCheckOutWithInvalidCreditCard(self):
        catalog = {"Un libro": 40, "Otro libro": 80}
        newCart = Cart(catalog)
        aCashier = Cashier(catalog)
        aBook = "Un libro"
        newCart.addToCart(aBook, catalog, 1)
        with self.assertRaises(Exception):
            aCashier.checkOutCart(newCart, "1111111111111111", "05/2026")
        self.assertFalse(newCart.isEmpty())
        self.assertEqual(aCashier.numberOfBooksSold(), 0)
        self.assertEqual(aCashier.totalAmount, 0)

def main():
    unittest.main()

main()
