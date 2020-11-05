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

!CustomerBookTest methodsFor: 'tests' stamp: 'AF 11/5/2020 17:45:39'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	self removerClienteSuspendido: false.
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'AF 11/5/2020 17:45:58'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	self removerClienteSuspendido: true.

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'AF 11/5/2020 18:32:05'!
test07CanNotSuspendAnInvalidCustomer

	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self noSePuedeSuspenderA: 'Ringo Starr' libro: customerBook .

	"
	[ customerBook suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]"
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'AF 11/5/2020 18:31:52'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.

	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self noSePuedeSuspenderA: 'John Lennon' libro: customerBook .

	
	"
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]"
! !


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

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/5/2020 18:22:43'!
noSePuedeSuspenderA: unCliente

	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: unCliente.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/5/2020 18:31:35'!
noSePuedeSuspenderA: unCliente libro: unLibro
	
	[ unLibro suspendCustomerNamed: unCliente.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: unLibro numberOfCustomers = 1.
			self assert: (unLibro includesCustomerNamed: 'John Lennon') ]! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/5/2020 17:54:00'!
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
			self assert: customerBook numberOfCustomers = 1.
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

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/5/2020 17:06:29'!
setearClientes: unCaso  activos: cantidadDeActivos suspendidos: cantidadDeSuspendidos total: cantidadTotal

	
	
	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	
	unCaso value.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'AF 11/5/2020 17:15:37'!
setearClientes: unCaso  activos: cantidadDeActivos suspendidos: cantidadDeSuspendidos total: cantidadTotal libro: unLibro


	unCaso value.
	
	self assert: cantidadDeActivos equals: unLibro numberOfActiveCustomers.
	self assert: cantidadDeSuspendidos equals: unLibro numberOfSuspendedCustomers.
	self assert: cantidadTotal equals: unLibro numberOfCustomers.
	! !


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


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
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
