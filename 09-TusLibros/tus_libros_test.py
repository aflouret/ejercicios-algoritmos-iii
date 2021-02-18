import unittest
from cart import Cart
from cashier import Cashier



class TusLibrosTest(unittest.TestCase):

    def aBookFromTheEditorial(self):
        return "Un libro"

    def anotherBookFromTheEditorial(self):
        return "Otro libro"

    def priceOfABookFromTheEditorial(self):
        return 40

    def priceOfAnotherBookFromTheEditorial(self):
        return 80

    def createCart(self):
        catalog = {self.aBookFromTheEditorial(): self.priceOfABookFromTheEditorial(),
                   self.anotherBookFromTheEditorial(): self.priceOfAnotherBookFromTheEditorial()}
        return Cart(catalog)

    def createCashier(self):
        catalog = {self.aBookFromTheEditorial(): self.priceOfABookFromTheEditorial(),
                   self.anotherBookFromTheEditorial(): self.priceOfAnotherBookFromTheEditorial()}
        return Cashier(catalog)

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


    def test1NewCartIsEmpty(self):
        newCart = self.createCart()
        self.assertTrue(newCart.isEmpty())

    def test2ABookInCatalogCanBeAddedToCart(self):
        newCart = self.createCart()
        aBook = self.aBookFromTheEditorial()
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
        aBook = self.aBookFromTheEditorial()
        newCart.addToCart(aBook, 2)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.hasBook(aBook))
        self.assertEqual(newCart.quantity(), 2)

    def test5CanAddManyDifferentBooks(self):
        newCart = self.createCart()
        aBook = self.aBookFromTheEditorial()
        anotherBook = self.anotherBookFromTheEditorial()
        newCart.addToCart(aBook, 100)
        newCart.addToCart(anotherBook, 100)
        self.assertFalse(newCart.isEmpty())
        self.assertEqual(newCart.quantityOfBook(aBook), 100)
        self.assertEqual(newCart.quantityOfBook(anotherBook), 100)
        self.assertEqual(newCart.quantity(), 200)

    def test6CanOnlyAddAPositiveNumberOfBooks(self):
        newCart = self.createCart()
        aBook = self.aBookFromTheEditorial()

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
        aBook = self.aBookFromTheEditorial()
        newCart.addToCart(aBook, 1)
        aCashier.checkOutCart(newCart, "0123456789012345", "052023")
        self.assertTrue(newCart.isEmpty())


    def test9CashierKnowsNumberOfBooksSold(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial()
        newCart.addToCart(aBook, 1)
        aCashier.checkOutCart(newCart, "0123456789012345", "052023")
        self.assertEqual(aCashier.numberOfBooksSold(), 1)

    def test10CashierKnowsNumberOfCopiesSoldOfDifferentBooks(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial()
        anotherBook = self.anotherBookFromTheEditorial()
        newCart.addToCart(aBook, 100)
        newCart.addToCart(anotherBook, 200)
        aCashier.checkOutCart(newCart, "0123456789012345", "052023")
        self.assertEqual(aCashier.numberOfBooksSold(), 300)
        self.assertEqual(aCashier.numberOfCopiesSold(aBook), 100)
        self.assertEqual(aCashier.numberOfCopiesSold(anotherBook), 200)

    def test11CashierKnowsTotalAmount(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial()
        anotherBook = self.anotherBookFromTheEditorial()
        newCart.addToCart(aBook, 100)
        newCart.addToCart(anotherBook, 200)
        aCashier.checkOutCart(newCart, "0123456789012345", "052023")
        self.assertEqual(aCashier.totalAmount, self.priceOfABookFromTheEditorial()*100 + self.priceOfAnotherBookFromTheEditorial()*200)

    def test12CannotCheckOutWithExpiredCreditCard(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial()
        newCart.addToCart(aBook, 1)
        self.assertRaisesErrorAndNoSalesWereMade(lambda: aCashier.checkOutCart(newCart, "0123456789012345", "052020"),
                                                 newCart, aCashier)


        
    def test13CannotCheckOutWithInvalidCreditCard(self):
        newCart = self.createCart()
        aCashier = self.createCashier()
        aBook = self.aBookFromTheEditorial()
        newCart.addToCart(aBook, 1)
        self.assertRaisesErrorAndNoSalesWereMade(lambda: aCashier.checkOutCart(newCart, "1111111111111111", "052026"),
                                                 newCart, aCashier)


def main():
    unittest.main()

if __name__ == '__main__':
    main()
