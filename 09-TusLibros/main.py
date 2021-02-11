import unittest


class Cart:

    def __init__(self):
        self.quantity = 0
        self.books = {}

    def isEmpty(self):
        return self.quantity == 0

    def addToCart(self, aBook, catalog, aBookQuantity = 1):
        if catalog.hasBook(aBook) == False:
            raise Exception("Book not in catalog")

        self.books[aBook] = aBookQuantity
        self.quantity += aBookQuantity

    def hasBook(self,aBook):
        return aBook in self.books

    def quantityOfBook(self, aBook):
        return self.books[aBook]


class Catalog:

    def __init__(self, aListOfBooks):
        self.books = aListOfBooks

    def hasBook(self, aBook):
        return aBook in self.books


class TestTusLibros(unittest.TestCase):

    def test1_newCartIsEmpty(self):
        newCart = Cart()
        self.assertTrue(newCart.isEmpty())

    def test2_aBookInCatalogCanBeAddedToCart(self):
        catalog = Catalog(["Un libro", "Otro libro"])
        newCart = Cart()
        aBook = "Un libro"
        newCart.addToCart(aBook, catalog)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.hasBook(aBook))

    def test3_aBookNotInCatalogCanNotBeAddedToCart(self):
        catalog = Catalog(["Un libro", "Otro libro"])
        newCart = Cart()
        aBook = "Un libro que no esta"

        with self.assertRaises(Exception):
            newCart.addToCart(aBook, catalog)
        self.assertTrue(newCart.isEmpty())
        self.assertFalse(newCart.hasBook(aBook))

    def test4_canAddManyBooksOfSameTitle(self):
        catalog = Catalog(["Un libro", "Otro libro"])
        newCart = Cart()
        aBook = "Un libro"
        newCart.addToCart(aBook, catalog, 2)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.hasBook(aBook))
        self.assertEqual(newCart.quantity, 2)

    def test5_canAddManyDifferentBooks(self):
        catalog = Catalog(["Un libro", "Otro libro"])
        newCart = Cart()
        aBook = "Un libro"
        anotherBook = "Otro libro"
        newCart.addToCart(aBook, catalog, 100)
        newCart.addToCart(anotherBook, catalog, 100)
        self.assertFalse(newCart.isEmpty())
        self.assertEqual(newCart.quantityOfBook(aBook), 100)
        self.assertEqual(newCart.quantityOfBook(anotherBook), 100)
        self.assertEqual(newCart.quantity, 200)



def main():
    unittest.main()

main()
