!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:21:10'!
test01EmptyCommandShouldNotMoveRover

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #NorthCompass.
	
	marsRover receiveSequenceOfCommands: ''.
	
	self assert: (marsRover position: 0@0 facingTo: #NorthCompass)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:21:09'!
test18

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #NorthCompass.
	
	marsRover receiveSequenceOfCommands: 'fff*ff'.
	
	self assert: (marsRover position: 0@3 facingTo: #NorthCompass)
	! !


!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/6/2020 16:21:29'!
test02rotatesFromNorthToWest

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #NorthCompass.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover position: 0@0 facingTo: #WestCompass)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/6/2020 16:21:10'!
test03NorteRotarDerecha

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #NorthCompass.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover position: 0@0 facingTo: #EastCompass)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/6/2020 16:21:20'!
test04

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #SouthCompass.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover position: 0@0 facingTo: #EastCompass)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/6/2020 16:21:29'!
test05

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #SouthCompass.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover position: 0@0 facingTo: #WestCompass)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/6/2020 16:21:10'!
test06

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #EastCompass.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover position: 0@0 facingTo: #NorthCompass)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/6/2020 16:21:20'!
test07

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #EastCompass.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover position: 0@0 facingTo: #SouthCompass)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/6/2020 16:21:29'!
test08

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #WestCompass.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover position: 0@0 facingTo: #SouthCompass)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AH 12/6/2020 16:21:29'!
test09

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #WestCompass.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover position: 0@0 facingTo: #NorthCompass)
	! !


!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/6/2020 16:21:09'!
test10NorteForward

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #NorthCompass.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover position: 0@1 facingTo: #NorthCompass)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/6/2020 16:21:10'!
test11NorteBackwards

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #NorthCompass.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover position: 0@-1 facingTo: #NorthCompass)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/6/2020 16:21:20'!
test12

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #SouthCompass.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover position: 0@-1 facingTo: #SouthCompass)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/6/2020 16:21:20'!
test13

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #SouthCompass.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover position: 0@1 facingTo: #SouthCompass)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/6/2020 16:13:20'!
test14

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #EastCompass.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover position: 1@0 facingTo: #EastCompass)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/6/2020 16:13:20'!
test15

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #EastCompass.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover position: -1@0 facingTo: #EastCompass)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/6/2020 16:21:29'!
test16

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #WestCompass.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover position: -1@0 facingTo: #WestCompass)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AH 12/6/2020 16:21:29'!
test17

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #WestCompass.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover position: 1@0 facingTo: #WestCompass)
	! !


!classDefinition: #Compass category: 'MarsRover'!
Object subclass: #Compass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Compass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:06:04'!
direction
	self subclassResponsibility .! !

!Compass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:01:38'!
rotateLeft:aMarsRover
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Compass class' category: 'MarsRover'!
Compass class
	instanceVariableNames: ''!

!Compass class methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:21:29'!
withDirection:aDirection
		
	aDirection = #NorthCompass ifTrue: [^NorthCompass new].
	aDirection = #SouthCompass ifTrue: [^SouthCompass new].
	aDirection= #EastCompass ifTrue: [^EastCompass new].
	aDirection= #WestCompass ifTrue: [^WestCompass new].! !


!classDefinition: #EastCompass category: 'MarsRover'!
Compass subclass: #EastCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:13:19'!
direction
	^#EastCompass.! !

!EastCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 15:58:44'!
rotateLeft:aMarsRover
	aMarsRover rotateToNorth.
! !

!EastCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:29:04'!
rotateRight:aMarsRover
	aMarsRover rotateToSouth.
! !

!EastCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:49:49'!
setToBackward:aMarsRover
	
	aMarsRover moveOnePositionInXNegative .
"	direction = #NorthCompass ifTrue: [^position := position + (0@-1)].
	direction = #SouthCompass ifTrue: [^position := position + (0@1)].
	direction = #EastCompass ifTrue: [^position := position + (-1@0)].
	direction = #WestCompass ifTrue: [^position := position + (1@0)].
"! !

!EastCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:49:30'!
setToForward:aMarsRover
	
	aMarsRover moveOnePositionInXPositive.
	"

	direction = #NorthCompass ifTrue: [^position := position + (0@1)].
	direction = #SouthCompass ifTrue: [^position := position + (0@-1)].
	direction = #WestCompass ifTrue: [^position := position + (-1@0)]."! !


!classDefinition: #NorthCompass category: 'MarsRover'!
Compass subclass: #NorthCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:21:10'!
direction
	^#NorthCompass.! !

!NorthCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:22:57'!
rotateLeft:aMarsRover
	aMarsRover rotateToWest.
! !

!NorthCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:29:29'!
rotateRight:aMarsRover
	aMarsRover rotateToEast.
! !

!NorthCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:50:09'!
setToBackward:aMarsRover
	
	aMarsRover moveOnePositionInYNegative .
"	direction = #NorthCompass ifTrue: [^position := position + (0@-1)].
	direction = #SouthCompass ifTrue: [^position := position + (0@1)].
	direction = #EastCompass ifTrue: [^position := position + (-1@0)].
	direction = #WestCompass ifTrue: [^position := position + (1@0)].
"! !

!NorthCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:47:23'!
setToForward:aMarsRover
	
	aMarsRover moveOnePositionInYPositive.
	"
	direction = #SouthCompass ifTrue: [^position := position + (0@-1)].
	direction = #WestCompass ifTrue: [^position := position + (-1@0)]."! !


!classDefinition: #SouthCompass category: 'MarsRover'!
Compass subclass: #SouthCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:21:20'!
direction
	^#SouthCompass.! !

!SouthCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:24:42'!
rotateLeft:aMarsRover
	aMarsRover rotateToEast.
! !

!SouthCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:29:41'!
rotateRight:aMarsRover
	aMarsRover rotateToWest.
! !

!SouthCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:50:27'!
setToBackward:aMarsRover
	
	aMarsRover moveOnePositionInYPositive.
"	direction = #NorthCompass ifTrue: [^position := position + (0@-1)].
	direction = #SouthCompass ifTrue: [^position := position + (0@1)].
	direction = #EastCompass ifTrue: [^position := position + (-1@0)].
	direction = #WestCompass ifTrue: [^position := position + (1@0)].
"! !

!SouthCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:47:52'!
setToForward:aMarsRover
	
	aMarsRover moveOnePositionInYNegative .
	"
	direction = #WestCompass ifTrue: [^position := position + (-1@0)]."! !


!classDefinition: #WestCompass category: 'MarsRover'!
Compass subclass: #WestCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:21:29'!
direction
	^#WestCompass.! !

!WestCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:24:58'!
rotateLeft:aMarsRover
	aMarsRover rotateToSouth.
! !

!WestCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:29:54'!
rotateRight:aMarsRover
	aMarsRover rotateToNorth.
! !

!WestCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:50:49'!
setToBackward:aMarsRover
	
	aMarsRover moveOnePositionInXPositive .
"	direction = #NorthCompass ifTrue: [^position := position + (0@-1)].
	direction = #SouthCompass ifTrue: [^position := position + (0@1)].
	direction = #EastCompass ifTrue: [^position := position + (-1@0)].
	direction = #WestCompass ifTrue: [^position := position + (1@0)].
"! !

!WestCompass methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:48:08'!
setToForward:aMarsRover
	
	aMarsRover moveOnePositionInXNegative .! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position compass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'AH 12/6/2020 15:47:30'!
initializeInPosition: aPosition inDirection: aMarsRoverCompass 
	position := aPosition.
	compass := aMarsRoverCompass .! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:49:15'!
goBackwards
	compass setToBackward: self.
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:38:15'!
goForward
	compass setToForward: self.
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:46:47'!
moveOnePositionInXNegative
	position := position - (1@0).! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:44:53'!
moveOnePositionInXPositive
	position  := position + (1@0).! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:46:58'!
moveOnePositionInYNegative
	position := position - (0@1).! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:46:20'!
moveOnePositionInYPositive
	position := position + (0@1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:05:49'!
position: aPosition facingTo: aDirection
	
	^ (position = aPosition and: [compass direction = aDirection])! !

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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:01:02'!
rotateLeft
	compass rotateLeft: self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:36:03'!
rotateRight
	compass rotateRight: self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:25:58'!
rotateToEast
	compass := Compass withDirection: #EastCompass.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:21:09'!
rotateToNorth
	compass := Compass withDirection: #NorthCompass.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:25:37'!
rotateToSouth
	compass := Compass withDirection: #SouthCompass.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/6/2020 16:26:28'!
rotateToWest
	compass := Compass withDirection: #WestCompass.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AH 12/6/2020 15:50:16'!
inPosition: aPosition inDirection: aDirection 
	|compass|
	compass := Compass withDirection:aDirection.
	
	^self new initializeInPosition: aPosition inDirection: compass. ! !
