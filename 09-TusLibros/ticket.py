class Ticket:

    @classmethod
    def generate(cls, aTotalAmount, aListOfBooks):
        listOfBooksByQuantity = {book: aListOfBooks.count(book) for book in aListOfBooks}
        return cls(aTotalAmount, listOfBooksByQuantity)

    def __init__(self, aTotalAmount, aListOfBooksByQuantity):
        self._totalAmount = aTotalAmount
        self._listOfBooksByQuantity = aListOfBooksByQuantity

    def totalAmount(self):
        return self._totalAmount

    def listOfBooksByQuantity(self):
        return self._listOfBooksByQuantity