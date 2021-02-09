import unittest

class Cart:

    def __init__(self,aClientId,aPassword):
        self.clientId = aClientId
        self.password = aPassword
        self.quantity = 0
        self.books = []

    def isEmpty(self):
        return self.quantity == 0

    def addToCart(self,aBook):
        self.books.append(aBook)
        self.quantity += 1

    def hasBook(self,aBook):
        return aBook in self.books

class TestTusLibros(unittest.TestCase):
    def test1_newCartIsEmpty(self):
        newCart = Cart("100","abc123")
        self.assertTrue(newCart.isEmpty())

    def test2_addANewBook(self):
        newCart = Cart("100", "abc123")
        aBook = "Un libro"
        newCart.addToCart(aBook)
        self.assertFalse(newCart.isEmpty())
        self.assertTrue(newCart.hasBook(aBook))

    def test3_addManyBooks(self):
        pass


"""
    def test_upper(self):
        self.assertEqual('foo'.upper(), 'FOO')

    def test_isupper(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())

    def test_split(self):
        s = 'hello world'
        self.assertEqual(s.split(), ['hello', 'world'])
        # check that s.split fails when the separator is not a string
        with self.assertRaises(TypeError):
            s.split(2)
"""
def main():
    unittest.main()
    return 0

main()