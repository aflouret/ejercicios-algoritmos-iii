import unittest

class Cart:

    def __init__(self,aClientId,aPassword,aCatalog):
        self.clientId = aClientId
        self.password = aPassword
        self.quantity = 0
        self.books = {}
        self.catalog = aCatalog

    def isEmpty(self):
        return self.quantity == 0

    def addToCart(self, aBook, aBookQuantity = 1):
        if self.catalog.hasBook(aBook) == False:
            raise Exception("Book not in catalog")

        self.books[aBook] = aBookQuantity
        self.quantity += aBookQuantity

    def hasBook(self,aBook):
        return aBook in self.books

    def quantityOfBook(self, aBook):
        return self.books[aBook]

    """def listCart(self):
        list = "0"
        for book, quantity in self.books.items():
            list += "|" + book
            list += "|" + str(quantity)
        return list"""

class Catalog:

    def __init__(self, aListOfBooks):
        self.books = aListOfBooks

    def hasBook(self, aBook):
        return aBook in self.books


class TestTusLibros(unittest.TestCase):

    def test1_newCartIsEmpty(self):
        catalog = Catalog(["Un libro", "Otro libro"])
        newCart = Cart("100","abc123", catalog)
        self.assertTrue(newCart.isEmpty())

    def test2_aValidBookCanBeAddedToCartCorrectly(self):
        catalog = Catalog(["Un libro", "Otro libro"])
        newCart = Cart("100", "abc123", catalog)
        aBook = "Un libro"
        newCart.addToCart(aBook)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.hasBook(aBook))

    def test3_anInvalidBookIsNotAddedToCart(self):
        catalog = Catalog(["Un libro", "Otro libro"])
        newCart = Cart("100", "abc123", catalog)
        aBook = "Un libro que no esta"

        with self.assertRaises(Exception):
            newCart.addToCart(aBook)
        self.assertTrue(newCart.isEmpty())
        self.assertFalse(newCart.hasBook(aBook))

    def test4_canAddManyBooksOfSameTitle(self):
        catalog = Catalog(["Un libro", "Otro libro"])
        newCart = Cart("100", "abc123", catalog)
        aBook = "Un libro"
        newCart.addToCart(aBook, 2)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.hasBook(aBook))
        self.assertEqual(newCart.quantity, 2)

    def test5_canAddManyDifferentBooks(self):
        catalog = Catalog(["Un libro", "Otro libro"])
        newCart = Cart("100", "abc123", catalog)
        aBook = "Un libro"
        anotherBook = "Otro libro"
        newCart.addToCart(aBook, 2)
        newCart.addToCart(anotherBook, 3)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.quantityOfBook(aBook) == 2)
        self.assertTrue(newCart.quantityOfBook(anotherBook) == 3)
        self.assertEqual(newCart.quantity, 5)






def main():
    unittest.main()


    return 0

main()
