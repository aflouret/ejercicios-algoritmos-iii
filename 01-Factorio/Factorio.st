!classDefinition: #CintaAzul category: 'Factorio'!
DenotativeObject subclass: #CintaAzul
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaAzul class' category: 'Factorio'!
CintaAzul class
	instanceVariableNames: 'destino contenido'!

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 18:27:12'!
agregar: unaMena
	contenido add: unaMena.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AF 10/29/2020 18:22:19'!
agregarLote: unLoteDeMenas
	contenido addAll: unLoteDeMenas .! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 17:46:31'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 17:46:44'!
cantidadDeMenas
	^contenido size.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 17:17:03'!
conectarA: unDestino
	destino := unDestino.! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AF 10/29/2020 18:37:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := Contenedor.
	contenido := ((OrderedCollection new)).! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 18:36:11'!
transportar
	destino agregarLote: contenido.
	self vaciar.
! !

!CintaAzul class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 17:31:21'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #CintaRoja category: 'Factorio'!
DenotativeObject subclass: #CintaRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaRoja class' category: 'Factorio'!
CintaRoja class
	instanceVariableNames: 'destino contenido'!

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 18:33:58'!
agregar: unaMena
	contenido add: unaMena.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AF 10/29/2020 18:21:56'!
agregarLote: unLoteDeMenas
	contenido addAll: unLoteDeMenas .! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 17:56:02'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 17:56:02'!
cantidadDeMenas
	^contenido size.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 17:56:02'!
conectarA: unDestino
	destino := unDestino.! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AF 10/29/2020 18:37:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaAzul.
	contenido := ((OrderedCollection new)).! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 18:34:45'!
transportar
	destino agregarLote: contenido.
	self vaciar.
! !

!CintaRoja class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 17:56:02'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #Contenedor category: 'Factorio'!
DenotativeObject subclass: #Contenedor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Contenedor class' category: 'Factorio'!
Contenedor class
	instanceVariableNames: 'contenido'!

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:04'!
agregar: unaMena
	contenido add: unaMena.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'AF 10/29/2020 18:22:30'!
agregarLote: unLoteDeMenas
	contenido addAll: unLoteDeMenas .! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:00'!
cantidadDe: unaMenaDeMuestra
	^contenido count: [:unaMena | unaMena = unaMenaDeMuestra ].! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:38:20'!
cantidadDeMenas
	^contenido size.! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'AF 10/29/2020 18:37:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new) add: #carbon; add: #hierro; yourself).! !

!Contenedor class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:35:51'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #ExtractorDeCarbon category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeCarbon class' category: 'Factorio'!
ExtractorDeCarbon class
	instanceVariableNames: 'destino'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:23'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 10/23/2020 00:33:50'!
extraer
	destino agregar: #carbon.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'AF 10/29/2020 18:37:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaAzul.! !


!classDefinition: #ExtractorDeHierro category: 'Factorio'!
DenotativeObject subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'Factorio'!
ExtractorDeHierro class
	instanceVariableNames: 'destino'!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 17:58:36'!
conectarA: unDestino
	destino := unDestino.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'AF 10/25/2020 17:58:49'!
extraer
	destino agregar: #hierro.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'AF 10/29/2020 18:37:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaRoja.! !


!classDefinition: #FactorioTest category: 'Factorio'!
DenotativeObject subclass: #FactorioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Factorio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FactorioTest class' category: 'Factorio'!
FactorioTest class
	instanceVariableNames: ''!

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 01:01:45'!
configurarCircuitoExtractorCaja.

	Contenedor vaciar.
	ExtractorDeCarbon conectarA: Contenedor.	
! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'SF 10/23/2020 00:55:32'!
hacerAndarCircuitoExtractorCaja

	ExtractorDeCarbon extraer.
	! !

!FactorioTest class methodsFor: 'escenario 1' stamp: 'AF 10/25/2020 17:08:00'!
test01ExtractorCaja
	self configurarCircuitoExtractorCaja.
	
	self hacerAndarCircuitoExtractorCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.! !


!FactorioTest class methodsFor: 'escenario 2' stamp: 'AF 10/25/2020 17:54:56'!
configurarCircuitoExtractorCintaCaja

	Contenedor vaciar.
	CintaAzul vaciar.
	ExtractorDeCarbon conectarA: CintaAzul.
	CintaAzul conectarA: Contenedor.
! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'AF 10/25/2020 17:54:56'!
hacerAndarCircuitoExtractorCintaCaja

	ExtractorDeCarbon extraer.
	CintaAzul transportar.! !

!FactorioTest class methodsFor: 'escenario 2' stamp: 'AF 10/25/2020 17:54:56'!
test02ExtractorCintaCaja
	self configurarCircuitoExtractorCintaCaja.
	
	self hacerAndarCircuitoExtractorCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 1.
	Assert that: CintaAzul cantidadDeMenas isEqualTo: 0.
! !


!FactorioTest class methodsFor: 'escenario 3' stamp: 'AF 10/25/2020 18:04:40'!
configurarCircuitoExtractorExtractorCintaCintaCaja

	Contenedor vaciar.
	CintaAzul vaciar.
	CintaRoja vaciar.
	ExtractorDeCarbon conectarA: CintaAzul.
	ExtractorDeHierro conectarA: CintaRoja. 
	CintaAzul conectarA: Contenedor.
	CintaRoja conectarA: CintaAzul.
	
! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'AF 10/25/2020 18:07:21'!
hacerAndarCircuitoExtractorExtractorCintaCintaCaja
	
	ExtractorDeCarbon extraer.
	ExtractorDeHierro extraer.
	CintaRoja transportar.
	CintaAzul transportar.! !

!FactorioTest class methodsFor: 'escenario 3' stamp: 'AF 10/25/2020 18:08:19'!
test03ExtractorExtractorCintaCintaCaja
	self configurarCircuitoExtractorExtractorCintaCintaCaja.
	
	self hacerAndarCircuitoExtractorExtractorCintaCintaCaja.
	
	Assert that: (Contenedor cantidadDe: #carbon) isEqualTo: 1.
	Assert that: (Contenedor cantidadDe: #hierro) isEqualTo: 1.
	Assert that: Contenedor cantidadDeMenas isEqualTo: 2.
	Assert that: CintaAzul cantidadDeMenas isEqualTo: 0.
	Assert that: CintaRoja cantidadDeMenas isEqualTo: 0.! !

CintaAzul initializeAfterFileIn!
CintaRoja initializeAfterFileIn!
Contenedor initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!