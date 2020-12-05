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

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:33:26'!
test02ForwardCommandShouldMoveRoverForwardFacingNorth

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover position: 0@1 facingTo: #North)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:33:40'!
test03BackwardsCommandShouldMoveRoverBackwardsFacingNorth

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover position: 0@-1 facingTo: #North)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:33:54'!
test04RotateLeftCommandShouldRotateRoverLeftFromNorthToWest

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover position: 0@0 facingTo: #West)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:34:22'!
test05RotateRightCommandShouldRotateRoverRightFromNorthToEast

	| marsRover |
	marsRover := MarsRover inPosition: 0@0 inDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover position: 0@0 facingTo: #East)
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


!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:14:45'!
goBackwards
	direction = #North ifTrue: [position := position + (0@-1)].
	"direction = 'South' ifTrue: [position := position + (0@1)].
	direction = 'West' ifTrue: [position := position + (1@0)].
	direction = 'East' ifTrue: [position := position + (-1@0)]."! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:14:56'!
goForward
	direction = #North ifTrue: [position := position + (0@1)].
	"direction = 'South' ifTrue: [position := position + (0@-1)].
	direction = 'West' ifTrue: [position := position + (-1@0)].
	direction = 'East' ifTrue: [position := position + (1@0)]."! !

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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AF 12/3/2020 17:46:23'!
receiveSequenceOfCommands: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self receiveCommand: aCommand]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:15:27'!
rotateLeft
	direction := #West.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AH 12/5/2020 15:15:37'!
rotateRight
	direction := #East.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AF 11/30/2020 21:51:37'!
inPosition: aPosition inDirection: aDirection 
	
	^self new initializeInPosition: aPosition inDirection: aDirection ! !
