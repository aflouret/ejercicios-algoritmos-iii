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

    def addToCart(self, aBook, aBookQuantity=1):
        if (aBook in self.catalog) == False:
            raise Exception("Book not in catalog")
        if aBookQuantity < 1:
            raise Exception("Number of books should be positive")

        for _ in range(aBookQuantity):
            self.books.append(aBook)
            self.totalAmount += self.catalog[aBook]

    def hasBook(self, aBook):
        return aBook in self.books

    def quantityOfBook(self, aBook):
        return self.books.count(aBook)

    def emptyCart(self):
        self.books = []
        self.totalAmount = 0
