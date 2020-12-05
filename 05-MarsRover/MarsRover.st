!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:33:18'!
test01EmptyCommandShouldNotMoveRover

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #North.
	
	marsRover receiveSequenceOfCommands: ''.
	
	self assert: (marsRover position: 0@0 facingTo: #North)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 16:54:13'!
test18

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'fff*ff'.
	
	self assert: (marsRover position: 0@3 facingTo: #North)
	! !


!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/5/2020 16:33:05'!
test02rotatesFromNorthToWest

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover position: 0@0 facingTo: #West)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/5/2020 16:06:23'!
test03NorteRotarDerecha

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover position: 0@0 facingTo: #East)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/5/2020 16:07:05'!
test04

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #South.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover position: 0@0 facingTo: #East)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/5/2020 16:07:19'!
test05

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #South.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover position: 0@0 facingTo: #West)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/5/2020 16:07:28'!
test06

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #East.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover position: 0@0 facingTo: #North)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/5/2020 16:07:32'!
test07

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #East.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover position: 0@0 facingTo: #South)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/5/2020 16:07:38'!
test08

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #West.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover position: 0@0 facingTo: #South)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/5/2020 16:07:55'!
test09

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #West.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover position: 0@0 facingTo: #North)
	! !


!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/5/2020 16:08:18'!
test10NorteForward

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover position: 0@1 facingTo: #North)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/5/2020 16:08:33'!
test11NorteBackwards

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover position: 0@-1 facingTo: #North)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/5/2020 15:58:33'!
test12

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #South.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover position: 0@-1 facingTo: #South)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/5/2020 15:59:44'!
test13

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #South.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover position: 0@1 facingTo: #South)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/5/2020 16:24:53'!
test14

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #East.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover position: 1@0 facingTo: #East)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/5/2020 16:25:06'!
test15

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #East.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover position: -1@0 facingTo: #East)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/5/2020 16:27:22'!
test16

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #West.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover position: -1@0 facingTo: #West)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/5/2020 16:28:38'!
test17

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #West.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover position: 1@0 facingTo: #West)
	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'AF 11/30/2020 21:52:35'!
initializeInPosition: aPosition inDirection: aDirection 
	position := aPosition.
	direction := aDirection.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 16:28:49'!
goBackwards
	direction = #North ifTrue: [^position := position + (0@-1)].
	direction = #South ifTrue: [^position := position + (0@1)].
	direction = #East ifTrue: [^position := position + (-1@0)].
	direction = #West ifTrue: [^position := position + (1@0)].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 16:27:59'!
goForward
	direction = #North ifTrue: [^position := position + (0@1)].
	direction = #South ifTrue: [^position := position + (0@-1)].
	direction = #East ifTrue: [^position := position + (1@0)].
	direction = #West ifTrue: [^position := position + (-1@0)].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AF 12/3/2020 16:48:36'!
position: aPosition facingTo: aDirection
	
	^ (position = aPosition and: [direction = aDirection])! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AF 12/3/2020 17:56:23'!
receiveCommand: aCommand

	aCommand = $f ifTrue: [self goForward]. 
	aCommand = $b ifTrue: [self goBackwards].
	aCommand = $l ifTrue: [self rotateLeft].
	aCommand = $r ifTrue: [self rotateRight].
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 16:49:48'!
receiveSequenceOfCommands: aSequenceOfCommands
	|acceptedCommands|
	acceptedCommands := #($l $r $f $b).
	
	aSequenceOfCommands do: [:aCommand | 
		(acceptedCommands includes: aCommand) ifFalse: [^self].
		self receiveCommand: aCommand.
		]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:54:40'!
rotateLeft
	direction = #North ifTrue: [^direction := #West.].
	direction = #South ifTrue: [^direction := #East.].
	direction = #East ifTrue: [^direction := #North.].
	direction = #West ifTrue: [^direction := #South.].
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:55:28'!
rotateRight
	direction = #North ifTrue: [^direction := #East.].
	direction = #South ifTrue: [^direction := #West.].
	direction = #East ifTrue: [^direction := #South.].
	direction = #West ifTrue: [^direction := #North.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AF 11/30/2020 21:51:37'!
inPosition: aPosition inDirection: aDirection 
	
	^self new initializeInPosition: aPosition inDirection: aDirection ! !
