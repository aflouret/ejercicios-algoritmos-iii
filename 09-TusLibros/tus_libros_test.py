import unittest
from cart import Cart
from cashier import Cashier
from facade import Facade
from datetime import timedelta
from simulator_objects import MerchantProcessor, ClockSimulator, AuthenticatorSimulator

class TusLibrosTest(unittest.TestCase):

    def setUp(self):
        self.clock = ClockSimulator()
        self.authenticator = AuthenticatorSimulator()
        self.merchantProcessor = MerchantProcessor()
        self.aBookFromTheEditorial = "Un libro"
        self.anotherBookFromTheEditorial = "Otro libro"
        self.priceOfABookFromTheEditorial = 40
        self.priceOfAnotherBookFromTheEditorial = 80
        self.catalog = {self.aBookFromTheEditorial: self.priceOfABookFromTheEditorial,
                        self.anotherBookFromTheEditorial: self.priceOfAnotherBookFromTheEditorial}

    def createCart(self):
        return Cart(self.catalog)

    def createCashier(self):
        return Cashier(self.catalog, self.merchantProcessor)

    def createCompleteFacade(self):
        cashier = self.createCashier()
        return Facade(self.catalog, cashier, self.clock, self.authenticator)

    def assertRaisesErrorAndCartRemainsEmpty(self, aBlockExpectedToFail, expectedErrorMessage, aCart):
        try:
            aBlockExpectedToFail()
            self.fail()
        except Exception as expectedException:
            self.assertEqual(str(expectedException), expectedErrorMessage)
            self.assertTrue(aCart.isEmpty())

    def assertRaisesErrorAndNoSalesWereMade(self, aBlockExpectedToFail, aCart, aCashier):
        try:
            aBlockExpectedToFail()
            self.fail()
        except Exception:
            self.assertFalse(aCart.isEmpty())
            self.assertEqual(aCashier.numberOfBooksSold(), 0)
            self.assertEqual(aCashier.totalAmount, 0)

    def assertRaisesErrorWithInvalidCredentials(self, aBlockExpectedToFail):
        try:
            aBlockExpectedToFail()
            self.fail()
        except Exception as expectedException:
            self.assertEqual(str(expectedException), "Invalid credentials")

    def assertRaisesErrorWithCartExpired(self, aBlockExpectedToFail):
        try:
            aBlockExpectedToFail()
            self.fail()
        except Exception as expectedException:
            self.assertEqual(str(expectedException), "Cart expired")


    def test1NewCartIsEmpty(self):
        newCart = self.createCart()
        self.assertTrue(newCart.isEmpty())

    def test2ABookInCatalogCanBeAddedToCart(self):
        newCart = self.createCart()
        aBook = self.aBookFromTheEditorial
        newCart.addToCart(aBook)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.hasBook(aBook))

    def test3ABookNotInCatalogCanNotBeAddedToCart(self):
        newCart = self.createCart()
        aBook = "Un libro que no esta"

        self.assertRaisesErrorAndCartRemainsEmpty(lambda: newCart.addToCart(aBook),
                                                  "Book not in catalog",
                                                  newCart)

    def test4CanAddManyBooksOfSameTitle(self):
        newCart = self.createCart()
        aBook = self.aBookFromTheEditorial
        newCart.addToCart(aBook, 2)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.hasBook(aBook))
        self.assertEqual(newCart.quantity(), 2)

    def test5CanAddManyDifferentBooks(self):
        newCart = self.createCart()
        aBook = self.aBookFromTheEditorial
        anotherBook = self.anotherBookFromTheEditorial
        newCart.addToCart(aBook, 100)
        newCart.addToCart(anotherBook, 100)
        self.assertFalse(newCart.isEmpty())
        self.assertEqual(newCart.quantityOfBook(aBook), 100)
        self.assertEqual(newCart.quantityOfBook(anotherBook), 100)
        self.assertEqual(newCart.quantity(), 200)

    def test6CanOnlyAddAPositiveNumberOfBooks(self):
        newCart = self.createCart()
        aBook = self.aBookFromTheEditorial

        self.assertRaisesErrorAndCartRemainsEmpty(lambda: newCart.addToCart(aBook, -3),
                                                  "Number of books should be positive",
                                                  newCart)

    def test7CannotCheckoutEmptyCart(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        self.assertRaisesErrorAndCartRemainsEmpty(lambda: aCashier.checkOutCart(newCart, "0123456789012345", "052023"),
                                                  "Empty cart cannot be checked out",
                                                  newCart)

    def test8CartIsEmptyAfterCheckout(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial
        newCart.addToCart(aBook, 1)
        aCashier.checkOutCart(newCart, "0123456789012345", "052023")
        self.assertTrue(newCart.isEmpty())


    def test9CashierKnowsNumberOfBooksSold(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial
        newCart.addToCart(aBook, 1)
        aCashier.checkOutCart(newCart, "0123456789012345", "052023")
        self.assertEqual(aCashier.numberOfBooksSold(), 1)

    def test10CashierKnowsNumberOfCopiesSoldOfDifferentBooks(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial
        anotherBook = self.anotherBookFromTheEditorial
        newCart.addToCart(aBook, 100)
        newCart.addToCart(anotherBook, 200)
        aCashier.checkOutCart(newCart, "0123456789012345", "052023")
        self.assertEqual(aCashier.numberOfBooksSold(), 300)
        self.assertEqual(aCashier.numberOfCopiesSold(aBook), 100)
        self.assertEqual(aCashier.numberOfCopiesSold(anotherBook), 200)

    def test11CashierKnowsTotalAmount(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial
        anotherBook = self.anotherBookFromTheEditorial
        newCart.addToCart(aBook, 100)
        newCart.addToCart(anotherBook, 200)
        ticket = aCashier.checkOutCart(newCart, "0123456789012345", "052023")
        self.assertEqual(ticket.totalAmount(), self.priceOfABookFromTheEditorial*100 + self.priceOfAnotherBookFromTheEditorial*200)

    def test12CannotCheckOutWithExpiredCreditCard(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial
        newCart.addToCart(aBook, 1)
        self.assertRaisesErrorAndNoSalesWereMade(lambda: aCashier.checkOutCart(newCart, "0123456789012345", "052020"),
                                                 newCart, aCashier)



    def test13CannotCheckOutWithInvalidCreditCard(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial
        newCart.addToCart(aBook, 1)
        self.assertRaisesErrorAndNoSalesWereMade(lambda: aCashier.checkOutCart(newCart, "1111111111111111", "052026"),
                                                 newCart, aCashier)


    def test14CannotCreateCartWithInvalidCredentials(self):
        facade = self.createCompleteFacade()
        self.assertRaisesErrorWithInvalidCredentials(lambda: facade.createCart("Invalid ID", "Invalid Password"))


    def test15CannotListACartThatDoesNotExist(self):
        facade = self.createCompleteFacade()
        try:
            facade.listCart("1234")
            self.fail()
        except Exception as expectedException:
            self.assertEqual(str(expectedException), "There are no carts with that ID")

    def test16CanListValidCart(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        listOfBooks = facade.listCart(cartId)
        self.assertEqual(len(listOfBooks), 0)

    def test17TwoDifferentCartsHaveDifferentIds(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        anotherCartId = facade.createCart("Another Valid ID", "Another Valid Password")
        self.assertNotEqual(cartId, anotherCartId)

    def test18ListingCartShowsBooksAddedToCart(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        facade.addToCart(cartId, self.aBookFromTheEditorial, 4)
        listOfBooks = facade.listCart(cartId)
        self.assertEqual(listOfBooks.count(self.aBookFromTheEditorial), 4)

    def test19CannotAddBookToCartThatDoesNotExist(self):
        facade = self.createCompleteFacade()
        try:
            facade.addToCart("1234", self.aBookFromTheEditorial, 4)
        except Exception as expectedException:
            self.assertEqual(str(expectedException), "There are no carts with that ID")

    def test20ListingDifferentCartsShowsDifferentLists(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        anotherCartId = facade.createCart("Another Valid ID", "Another Valid Password")
        facade.addToCart(cartId, self.aBookFromTheEditorial, 4)
        facade.addToCart(anotherCartId, self.anotherBookFromTheEditorial, 2)
        self.assertEqual(facade.listCart(cartId).count(self.aBookFromTheEditorial), 4)
        self.assertEqual(facade.listCart(anotherCartId).count(self.anotherBookFromTheEditorial), 2)

    def test21CanNotCheckOutCartThatDoesNotExist(self):
        facade = self.createCompleteFacade()
        try:
            facade.checkOutCart("1234", "1234567890123456", "052023", "Card Owner's Name")
        except Exception as expectedException:
            self.assertEqual(str(expectedException), "There are no carts with that ID")

    def test22ListingCartAfterCheckoutShowsEmptyCart(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        facade.addToCart(cartId, self.aBookFromTheEditorial, 4)
        facade.checkOutCart(cartId, "1234567890123456", "052023", "Card Owner's Name")
        self.assertEqual(len(facade.listCart(cartId)), 0)

    def test23CanListOnePurchase(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        facade.addToCart(cartId, self.aBookFromTheEditorial, 4)
        facade.checkOutCart(cartId, "1234567890123456", "052023", "Card Owner's Name")
        salesReport = facade.listPurchases("Valid ID", "Valid Password")
        self.assertEqual(salesReport.totalAmount(), 4*self.priceOfABookFromTheEditorial)
        self.assertEqual(salesReport.listOfBooksByQuantity(), {self.aBookFromTheEditorial: 4})

    def test24CanListMultiplePurchases(self):
        facade = self.createCompleteFacade()
        aCartId = facade.createCart("Valid ID", "Valid Password")
        facade.addToCart(aCartId, self.aBookFromTheEditorial, 4)
        facade.checkOutCart(aCartId, "1234567890123456", "052023", "Card Owner's Name")

        anotherCartId = facade.createCart("Valid ID", "Valid Password")
        facade.addToCart(anotherCartId, self.anotherBookFromTheEditorial, 2)
        facade.checkOutCart(anotherCartId, "1234567890123456", "052023", "Card Owner's Name")

        salesReport = facade.listPurchases("Valid ID", "Valid Password")
        self.assertEqual(salesReport.totalAmount(), 4 * self.priceOfABookFromTheEditorial + 2 * self.priceOfAnotherBookFromTheEditorial)
        self.assertEqual(salesReport.listOfBooksByQuantity(), {self.aBookFromTheEditorial: 4, self.anotherBookFromTheEditorial: 2})

    def test25CannotListPurchasesWithInvalidCredentials(self):
        facade = self.createCompleteFacade()
        self.assertRaisesErrorWithInvalidCredentials(lambda: facade.listPurchases("Invalid ID", "Invalid Password"))


    def test26cannotListExpiredCart(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        self.clock.goForward(timedelta(minutes=30, seconds=1))
        self.assertRaisesErrorWithCartExpired(lambda: facade.listCart(cartId))
        


    def test27cannotAddBookToExpiredCart(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        self.clock.goForward(timedelta(minutes=30, seconds=1))
        self.assertRaisesErrorWithCartExpired(lambda: facade.addToCart(cartId, self.aBookFromTheEditorial, 4))

    def test28cannotCheckOutExpiredCart(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        self.clock.goForward(timedelta(minutes=30, seconds=1))
        self.assertRaisesErrorWithCartExpired(lambda: facade.checkOutCart(cartId, "1234567890123456", "052023", "Card Owner's Name"))

    def test29CartIsNotExpiredAtExactlyThirtyMinutesAfterLastUpdate(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        self.clock.goForward(timedelta(minutes=30))
        listOfBooks = facade.listCart(cartId)
        self.assertEqual(len(listOfBooks), 0)

    def test30CartOnlyExpiresIfLastUpdateWasMoreThanThirtyMinutesAgo(self):
        facade = self.createCompleteFacade()
        cartId = facade.createCart("Valid ID", "Valid Password")
        self.clock.goForward(timedelta(minutes=10))
        facade.addToCart(cartId, self.aBookFromTheEditorial, 4)
        self.clock.goForward(timedelta(minutes=25))
        listOfBooks = facade.listCart(cartId)
        self.assertEqual(len(listOfBooks), 4)

def main():
    unittest.main()

if __name__ == '__main__':
    main()
