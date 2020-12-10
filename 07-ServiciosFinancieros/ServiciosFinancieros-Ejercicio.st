!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/8/2020 17:02:30'!
test01PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/8/2020 17:02:30'!
test02PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio hasAccount: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/8/2020 17:02:30'!
test03PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio hasAccount: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/8/2020 17:02:30'!
test04ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/8/2020 17:02:30'!
test05ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/8/2020 17:02:30'!
test06PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify hasAccounts ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/10/2020 16:57:52'!
test07PortfolioShouldHaveZeroAsBalanceWhenCreated

	| portfolio |
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0*peso
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/10/2020 16:59:32'!
test08PortfolioWithSingleAccountShouldHaveSameBalanceAsAccount

	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	Deposit register: 100 * peso on: account.
	
	self assert: portfolio balance equals: 100*peso
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/10/2020 17:00:14'!
test09PortfolioBalanceShouldEqualSumOfAccountBalances

	| portfolio account anotherAccount |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	portfolio := Portfolio with: account with: anotherAccount.
	
	Deposit register: 100 * peso on: account.
	Deposit register: 200 * peso on: anotherAccount.

	
	self assert: portfolio balance equals: 300*peso
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/10/2020 17:00:48'!
test10PortfolioKnowsRegisteredTransactions

	| portfolio account anotherAccount deposit |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	portfolio := Portfolio with: account with: anotherAccount.
	
	deposit := Deposit register: 100 * peso on: account.
		
	self assert: (portfolio hasRegistered: deposit)
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'AF 12/10/2020 17:04:46'!
test11PortfolioDoesNotKnowNotRegisteredTransactions

	| portfolio account anotherAccount deposit withdraw |
	
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	portfolio := Portfolio with: account with: anotherAccount.
	
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (portfolio hasRegistered: deposit).
	self deny: (portfolio hasRegistered: withdraw).
	
	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 17:01:58'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:55:33'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AH 12/5/2020 21:12:10'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AH 12/5/2020 21:26:54'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:01'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 9/20/2020 20:56:08'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 12/10/2020 17:56:26'!
test01EmptyTransferShouldNotModifyAccountBalance
	
	|originAccount destinationAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Transfer from:originAccount To:destinationAccount anAmountOf:0*peso.
	self assert: originAccount balance = (0*peso).
	self assert: destinationAccount balance = (0*peso)

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 12/10/2020 16:56:25'!
test02TransferShouldModifyBalanceOfBothAccountsOnTransferAmount
	
	|originAccount destinationAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Deposit register: 100*peso on:originAccount .
	Transfer from:originAccount To:destinationAccount anAmountOf:100*peso.

	self assert: 0 * peso equals: originAccount balance.
	self assert: 100 * peso equals: destinationAccount balance.
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 12/10/2020 17:52:50'!
test03TransferPartsShouldKnowTheirCounterpart
	
	|originAccount destinationAccount transfer|
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Deposit register: 100*peso on:originAccount .
	transfer := Transfer from:originAccount To:destinationAccount anAmountOf:100*peso.
	
	self assert: (transfer withdrawPart = transfer depositPart counterpart).
	self assert: (transfer depositPart = transfer withdrawPart counterpart).

	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'AF 12/10/2020 18:02:49'!
test04TransferPartsValueShouldEqualTransferValue
	
	|originAccount destinationAccount transfer|
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Deposit register: 100*peso on:originAccount .
	transfer := Transfer from:originAccount To:destinationAccount anAmountOf:100*peso.
	
	self assert: (transfer withdrawPart value = (100*peso)).
	self assert: (transfer depositPart value = (100*peso)).

	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'AH 12/5/2020 21:25:27'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'AF 12/8/2020 16:25:37'!
isOfAmount: anAmount on: anAccount

	^ anAmount = self value and: [anAccount]! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
Deposit subclass: #TransferDeposit
	instanceVariableNames: 'counterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'associating' stamp: 'AF 12/10/2020 17:32:35'!
linkWithCounterpart: aTransferWithdraw 
	counterpart := aTransferWithdraw! !


!TransferDeposit methodsFor: 'accessing' stamp: 'AF 12/10/2020 17:33:19'!
counterpart
	^counterpart! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'AH 12/5/2020 19:06:43'!
value

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
Withdraw subclass: #TransferWithdraw
	instanceVariableNames: 'counterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'associating' stamp: 'AF 12/10/2020 17:33:03'!
linkWithCounterpart: aTransferDeposit 
	counterpart := aTransferDeposit! !


!TransferWithdraw methodsFor: 'accessing' stamp: 'AF 12/10/2020 17:33:31'!
counterpart
	
	^counterpart! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'accounts management' stamp: 'AF 12/8/2020 17:03:49'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'AF 12/8/2020 17:09:29'!
addPortfolio: portfolioToAdd

	"self assertCanAdd: accountToAdd."
		
	| portfolios |
	portfolios add: portfolioToAdd.
	"accountToAdd addedTo: self" 
	! !


!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:05:33'!
hasAccount: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'testing' stamp: 'LL 9/20/2020 17:09:01'!
hasAccounts
	
	^accounts isEmpty ! !


!Portfolio methodsFor: 'accessing' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accessing' stamp: 'AF 12/8/2020 16:58:14'!
balance
	
	self accountsSize = 0 ifTrue: [^ 0*peso].

	^  accounts sum: [:anAccount | anAccount balance]! !


!Portfolio methodsFor: 'composition - private' stamp: 'AF 12/8/2020 17:03:49'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'AF 12/8/2020 17:03:49'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'AF 12/8/2020 17:23:21'!
hasRegistered: anAccountTransaction 
	
	accounts do: [:anAccount | ^ anAccount hasRegistered: anAccountTransaction]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AF 12/8/2020 17:03:49'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AF 12/8/2020 17:03:49'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LL 9/20/2020 17:01:23'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AF 12/10/2020 17:44:43'!
balance
	|totalBalance|
	totalBalance := 0*peso.
	transactions do: [ :aTransaction | 
		(aTransaction isKindOf:Deposit) ifTrue: [ totalBalance := totalBalance + aTransaction value].
		(aTransaction isKindOf:Withdraw) ifTrue: [ totalBalance := totalBalance - aTransaction value].
		].
	^totalBalance.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'LL 9/20/2020 20:48:29'!
hasRegistered: aTransaction

	^transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AF 12/8/2020 17:02:30'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition - private' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'depositPart withdrawPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'accessing' stamp: 'AF 12/10/2020 16:16:16'!
depositPart
	
	^ depositPart! !

!Transfer methodsFor: 'accessing' stamp: 'AF 12/10/2020 16:16:08'!
withdrawPart
	
	^ withdrawPart! !


!Transfer methodsFor: 'initialization' stamp: 'AF 12/10/2020 18:06:19'!
initializeTransferWithOriginAccount: anOriginAccount toADestinationAccount: aDestinationAccount forAnAmountOf: anAmountOfTransfer 
	
	depositPart := TransferDeposit register: anAmountOfTransfer on: aDestinationAccount.
	withdrawPart := TransferWithdraw register: anAmountOfTransfer on: anOriginAccount.
	
	depositPart linkWithCounterpart: withdrawPart.
	withdrawPart linkWithCounterpart: depositPart.
! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'AF 12/10/2020 16:39:08'!
from: anOriginAccount To: aDestinationAccount anAmountOf: anAmountOfTransfer 

	^self new initializeTransferWithOriginAccount: anOriginAccount toADestinationAccount:aDestinationAccount forAnAmountOf: anAmountOfTransfer.! !
