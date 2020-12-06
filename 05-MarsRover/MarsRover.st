!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AF 12/6/2020 18:33:03'!
test01EmptyCommandShouldNotMoveNorRotateRover

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #North.
	
	marsRover receiveSequenceOfCommands: ''.
	
	self assert: (marsRover isAtPosition: 0@0 facingDirection: #North)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AF 12/6/2020 18:33:03'!
test18MarsRoverShouldBeAbleToExecuteMultipleCommands

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'ffrrlb'.
	
	self assert: (marsRover isAtPosition: -1@2 facingDirection: #East)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AF 12/6/2020 18:33:03'!
test19InvalidCommandShouldStopCommandProcessing

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'fff*ff'.
	
	self assert: (marsRover isAtPosition: 0@3 facingDirection: #North)
	! !


!MarsRoverTest methodsFor: 'testRotation' stamp: 'AF 12/6/2020 18:33:03'!
test04RotateLeftCommandShouldRotateRoverFromNorthToWest

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover isAtPosition: 0@0 facingDirection: #West)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AF 12/6/2020 18:33:03'!
test05RotateRightCommandShouldRotateRoverFromNorthToEast

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover isAtPosition: 0@0 facingDirection: #East)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AF 12/6/2020 18:33:03'!
test08RotateLeftCommandShouldRotateRoverFromEastToNorth

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #East.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover isAtPosition: 0@0 facingDirection: #North)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AF 12/6/2020 18:33:03'!
test09RotateRightCommandShouldRotateRoverFromEastToSouth

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #East.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover isAtPosition: 0@0 facingDirection: #South)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AF 12/6/2020 18:33:03'!
test12RotateLeftCommandShouldRotateRoverFromSouthToEast

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #South.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover isAtPosition: 0@0 facingDirection: #East)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AF 12/6/2020 18:33:03'!
test13RotateRightCommandShouldRotateRoverFromSouthToWest

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #South.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover isAtPosition: 0@0 facingDirection: #West)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AF 12/6/2020 18:33:03'!
test16RotateLeftCommandShouldRotateRoverFromWestToSouth

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #West.
	
	marsRover receiveSequenceOfCommands: 'l'.
	
	self assert: (marsRover isAtPosition: 0@0 facingDirection: #South)
	! !

!MarsRoverTest methodsFor: 'testRotation' stamp: 'AF 12/6/2020 18:33:03'!
test17RotateRightCommandShouldRotateRoverFromWestToNorth

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #West.
	
	marsRover receiveSequenceOfCommands: 'r'.
	
	self assert: (marsRover isAtPosition: 0@0 facingDirection: #North)
	! !


!MarsRoverTest methodsFor: 'testMovement' stamp: 'AF 12/6/2020 18:33:03'!
test02ForwardCommandShouldMoveRoverOnePositionNorthFacingNorth

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover isAtPosition: 0@1 facingDirection: #North)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AF 12/6/2020 18:33:03'!
test03BackwardsCommandShouldMoveRoverOnePositionSouthFacingNorth

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #North.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover isAtPosition: 0@-1 facingDirection: #North)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AF 12/6/2020 18:33:03'!
test06ForwardCommandShouldMoveRoverOnePositionEastFacingEast

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #East.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover isAtPosition: 1@0 facingDirection: #East)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AF 12/6/2020 18:33:03'!
test07BackwardsCommandShouldMoveRoverOnePositionWestFacingEast

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #East.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover isAtPosition: -1@0 facingDirection: #East)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AF 12/6/2020 18:33:03'!
test10ForwardCommandShouldMoveRoverOnePositionSouthFacingSouth

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #South.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover isAtPosition: 0@-1 facingDirection: #South)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AF 12/6/2020 18:33:03'!
test11BackwardsCommandShouldMoveRoverOnePoisitionNorthFacingSouth

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #South.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover isAtPosition: 0@1 facingDirection: #South)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AF 12/6/2020 18:33:03'!
test14ForwardCommandShouldMoveRoverOnePositionWestFacingWest

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #West.
	
	marsRover receiveSequenceOfCommands: 'f'.
	
	self assert: (marsRover isAtPosition: -1@0 facingDirection: #West)
	! !

!MarsRoverTest methodsFor: 'testMovement' stamp: 'AF 12/6/2020 18:33:03'!
test15BackwardsCommandShouldMoveRoverOnePositionEastFacingWest

	| marsRover |
	marsRover := MarsRover atPosition: 0@0 facingDirection: #West.
	
	marsRover receiveSequenceOfCommands: 'b'.
	
	self assert: (marsRover isAtPosition: 1@0 facingDirection: #West)
	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position compass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'AF 12/6/2020 18:26:26'!
initializeAtPosition: aPosition facingDirection: aMarsRoverCompass 
	position := aPosition.
	compass := aMarsRoverCompass .! !


!MarsRover methodsFor: 'private - commands' stamp: 'AF 12/6/2020 18:36:34'!
executeBackwardsCommand
	compass moveRoverBackwards: self.
! !

!MarsRover methodsFor: 'private - commands' stamp: 'AF 12/6/2020 18:34:47'!
executeCommand: aCommand

	aCommand = $f ifTrue: [self executeForwardCommand]. 
	aCommand = $b ifTrue: [self executeBackwardsCommand].
	aCommand = $l ifTrue: [self executeRotateLeftCommand].
	aCommand = $r ifTrue: [self executeRotateRightCommand].
	! !

!MarsRover methodsFor: 'private - commands' stamp: 'AF 12/6/2020 18:37:59'!
executeForwardCommand
	compass moveRoverForward: self.
! !

!MarsRover methodsFor: 'private - commands' stamp: 'AF 12/6/2020 18:37:02'!
executeRotateLeftCommand
	compass rotateRoverLeft: self.! !

!MarsRover methodsFor: 'private - commands' stamp: 'AF 12/6/2020 18:37:12'!
executeRotateRightCommand
	compass rotateRoverRight: self.! !

!MarsRover methodsFor: 'private - commands' stamp: 'AF 12/6/2020 18:33:03'!
receiveSequenceOfCommands: aSequenceOfCommands
	|acceptedCommands|
	acceptedCommands := #($l $r $f $b).
	
	aSequenceOfCommands do: [:aCommand | 
		(acceptedCommands includes: aCommand) ifFalse: [^self].
		self executeCommand: aCommand.
		]! !


!MarsRover methodsFor: 'private - movement' stamp: 'AF 12/6/2020 18:40:30'!
moveOnePositionEast
	position  := position + (1@0).! !

!MarsRover methodsFor: 'private - movement' stamp: 'AF 12/6/2020 18:39:54'!
moveOnePositionNorth
	position := position + (0@1)! !

!MarsRover methodsFor: 'private - movement' stamp: 'AF 12/6/2020 18:40:08'!
moveOnePositionSouth
	position := position - (0@1).! !

!MarsRover methodsFor: 'private - movement' stamp: 'AF 12/6/2020 18:39:26'!
moveOnePositionWest
	position := position - (1@0).! !


!MarsRover methodsFor: 'private - rotation' stamp: 'AF 12/6/2020 18:43:54'!
rotateToEast
	compass := MarsRoverCompass withDirection: #East.! !

!MarsRover methodsFor: 'private - rotation' stamp: 'AF 12/6/2020 18:43:54'!
rotateToNorth
	compass := MarsRoverCompass withDirection: #North.! !

!MarsRover methodsFor: 'private - rotation' stamp: 'AF 12/6/2020 18:43:54'!
rotateToSouth
	compass := MarsRoverCompass withDirection: #South.! !

!MarsRover methodsFor: 'private - rotation' stamp: 'AF 12/6/2020 18:43:54'!
rotateToWest
	compass := MarsRoverCompass withDirection: #West.! !


!MarsRover methodsFor: 'testing' stamp: 'AF 12/6/2020 18:27:01'!
isAtPosition: aPosition facingDirection: aDirection
	
	^ (position = aPosition and: [compass direction = aDirection])! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AF 12/6/2020 18:43:54'!
atPosition: aPosition facingDirection: aDirection 
	|compass|
	compass := MarsRoverCompass withDirection:aDirection.
	
	^self new initializeAtPosition: aPosition facingDirection: compass. ! !


!classDefinition: #MarsRoverCompass category: 'MarsRover'!
Object subclass: #MarsRoverCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCompass methodsFor: 'accessing' stamp: 'AH 12/6/2020 16:06:04'!
direction
	self subclassResponsibility .! !


!MarsRoverCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:36:34'!
moveRoverBackwards: aMarsRover
	self subclassResponsibility.! !

!MarsRoverCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:59'!
moveRoverForward: aMarsRover
	self subclassResponsibility.! !

!MarsRoverCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:02'!
rotateRoverLeft:aMarsRover
	self subclassResponsibility.! !

!MarsRoverCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:12'!
rotateRoverRight: aMarsRover
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCompass class' category: 'MarsRover'!
MarsRoverCompass class
	instanceVariableNames: ''!

!MarsRoverCompass class methodsFor: 'as yet unclassified' stamp: 'AF 12/6/2020 17:46:07'!
withDirection:aDirection
		
	aDirection = #North ifTrue: [^NorthCompass new].
	aDirection = #South ifTrue: [^SouthCompass new].
	aDirection= #East ifTrue: [^EastCompass new].
	aDirection= #West ifTrue: [^WestCompass new].! !


!classDefinition: #EastCompass category: 'MarsRover'!
MarsRoverCompass subclass: #EastCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastCompass methodsFor: 'accessing' stamp: 'AF 12/6/2020 17:41:08'!
direction
	^#East.! !


!EastCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:39:26'!
moveRoverBackwards: aMarsRover
	
	aMarsRover moveOnePositionWest. ! !

!EastCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:40:30'!
moveRoverForward: aMarsRover
	
	aMarsRover moveOnePositionEast.

	! !

!EastCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:02'!
rotateRoverLeft: aMarsRover

	aMarsRover rotateToNorth.
! !

!EastCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:12'!
rotateRoverRight: aMarsRover

	aMarsRover rotateToSouth.
! !


!classDefinition: #NorthCompass category: 'MarsRover'!
MarsRoverCompass subclass: #NorthCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthCompass methodsFor: 'accessing' stamp: 'AF 12/6/2020 17:41:15'!
direction

	^#North.! !


!NorthCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:40:08'!
moveRoverBackwards: aMarsRover
	
	aMarsRover moveOnePositionSouth .
! !

!NorthCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:39:54'!
moveRoverForward: aMarsRover
	
	aMarsRover moveOnePositionNorth.! !

!NorthCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:02'!
rotateRoverLeft: aMarsRover

	aMarsRover rotateToWest.
! !

!NorthCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:12'!
rotateRoverRight: aMarsRover

	aMarsRover rotateToEast.
! !


!classDefinition: #SouthCompass category: 'MarsRover'!
MarsRoverCompass subclass: #SouthCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthCompass methodsFor: 'accessing' stamp: 'AF 12/6/2020 17:41:21'!
direction

	^#South.! !


!SouthCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:39:54'!
moveRoverBackwards: aMarsRover
	
	aMarsRover moveOnePositionNorth.! !

!SouthCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:40:08'!
moveRoverForward: aMarsRover
	
	aMarsRover moveOnePositionSouth .! !

!SouthCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:02'!
rotateRoverLeft: aMarsRover
	
	aMarsRover rotateToEast.
! !

!SouthCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:12'!
rotateRoverRight: aMarsRover

	aMarsRover rotateToWest.
! !


!classDefinition: #WestCompass category: 'MarsRover'!
MarsRoverCompass subclass: #WestCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestCompass methodsFor: 'accessing' stamp: 'AF 12/6/2020 17:41:27'!
direction

	^#West.! !


!WestCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:40:30'!
moveRoverBackwards: aMarsRover
	
	aMarsRover moveOnePositionEast! !

!WestCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:39:26'!
moveRoverForward: aMarsRover
	
	aMarsRover moveOnePositionWest .! !

!WestCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:02'!
rotateRoverLeft: aMarsRover

	aMarsRover rotateToSouth.
! !

!WestCompass methodsFor: 'MarsRover commands' stamp: 'AF 12/6/2020 18:37:12'!
rotateRoverRight: aMarsRover
	
	aMarsRover rotateToNorth.
! !
