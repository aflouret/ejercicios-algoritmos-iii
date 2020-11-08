!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'AH 11/2/2020 21:48:20'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.	

	self assert: (self duracionDeLaAccion: [customerBook addCustomerNamed: 'John Lennon']) < (50 * millisecond)! !

!CustomerBookTest methodsFor: 'tests' stamp: 'AF 11/5/2020 16:20:02'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  	
	self assert: (self duracionDeLaAccion: [customerBook removeCustomerNamed: paulMcCartney]) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'AF 11/5/2020 18:39:38'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'HAW 8/28/2017 08:57:25'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'AF 11/8/2020 19:57:34'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
		
	self assert: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'AF 11/8/2020 19:57:55'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'AF 11/8/2020 19:58:13'!
test07CanNotSuspendAnInvalidCustomer

	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self noSePuedeSuspenderA: 'Ringo Starr' libro: customerBook .

! !

!CustomerBookTest methodsFor: 'tests' stamp: 'AF 11/8/2020 19:58:22'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.

	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self noSePuedeSuspenderA: 'John Lennon' libro: customerBook .

! !


!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/8/2020 19:29:34'!
SuspendCustomerAndRemoveIfTrue: debeEstarRemovido


	| customerBook paulMcCartney numeroDeSuspendidosEsperados numeroTotal numeroDeActivosEsperados |.
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	debeEstarRemovido ifTrue: [customerBook removeCustomerNamed: paulMcCartney.] .
	
	numeroDeActivosEsperados := 0.
	numeroDeSuspendidosEsperados := [debeEstarRemovido ifTrue: 0 ifFalse: 1.] value.
	numeroTotal := [debeEstarRemovido ifTrue: 0 ifFalse: 1.] value.
	
	self assert: numeroDeActivosEsperados equals: customerBook numberOfActiveCustomers.
	self assert: numeroDeSuspendidosEsperados equals: customerBook numberOfSuspendedCustomers.
	self assert: numeroTotal equals: customerBook numberOfCustomers.
	self assert: (debeEstarRemovido = (customerBook includesCustomerNamed: paulMcCartney) not).! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/5/2020 16:14:16'!
duracionDeLaAccion: unaAccion

	| millisecondsBeforeRunning millisecondsAfterRunning |
	

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	unaAccion value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning).
	
! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/5/2020 16:44:57'!
noSePuedeRealizarAccion: unaAccion enCasoDe: caso hacer: otraAccion

	[unaAccion value.
	self fail ]
		on: caso 
		do: otraAccion! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/5/2020 18:31:35'!
noSePuedeSuspenderA: unCliente libro: unLibro
	
	[ unLibro suspendCustomerNamed: unCliente.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: unLibro numberOfCustomers = 1.
			self assert: (unLibro includesCustomerNamed: 'John Lennon') ]! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/8/2020 19:58:48'!
noSePuedeSuspenderSi: unaAccion

	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/5/2020 17:44:33'!
removerClienteSuspendido: debeEstarRemovido


	| customerBook paulMcCartney numeroDeSuspendidosEsperados numeroTotal numeroDeActivosEsperados |.
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	debeEstarRemovido ifTrue: [customerBook removeCustomerNamed: paulMcCartney.] .
	
	numeroDeActivosEsperados := 0.
	numeroDeSuspendidosEsperados := [debeEstarRemovido ifTrue: 0 ifFalse: 1.] value.
	numeroTotal := [debeEstarRemovido ifTrue: 0 ifFalse: 1.] value.
	
	self assert: numeroDeActivosEsperados equals: customerBook numberOfActiveCustomers.
	self assert: numeroDeSuspendidosEsperados equals: customerBook numberOfSuspendedCustomers.
	self assert: numeroTotal equals: customerBook numberOfCustomers.
	self assert: (debeEstarRemovido = (customerBook includesCustomerNamed: paulMcCartney) not).! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'AF 11/8/2020 20:05:52'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'AF 11/8/2020 20:10:52'!
removeCustomerNamed: aName 
 	
	active remove: aName 
		ifAbsent: [	suspended remove: aName 
				ifAbsent: [^ NotFound signal].].
		
	^ aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'AF 11/8/2020 20:13:22'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [^CantSuspend signal].
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
