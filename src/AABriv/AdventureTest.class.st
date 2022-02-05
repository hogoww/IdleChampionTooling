Class {
	#name : #AdventureTest,
	#superclass : #TestCase,
	#instVars : [
		'adventure'
	],
	#category : #'AABriv-tests'
}

{ #category : #helpers }
AdventureTest >> fillWithRandomAreas: anAdventure [
	1 to: 50 do: [ :i | anAdventure areaAt: i put: (AbstractArea withId: i) ]
]

{ #category : #running }
AdventureTest >> setUp [
	adventure := Adventure new.
	self fillWithRandomAreas: adventure.
]

{ #category : #tests }
AdventureTest >> testFourBrivJumpWalksAllLevels [
	| run |
	run := RunPlanner planFor: adventure jumpingBy: 4.
	self assert: (run howManyTransitionsToArea: 100) equals: 20.
	
]

{ #category : #tests }
AdventureTest >> testOneBrivJumpWalksAllLevels [
	| run |
	run := RunPlanner planFor: adventure jumpingBy: 1.
	self assert: (run howManyTransitionsToArea: 50) equals: 25.
	
]

{ #category : #tests }
AdventureTest >> testThreeBrivJumpWalksAllLevels [
	| run |
	run := RunPlanner planFor: adventure jumpingBy: 3.
	self assert: (run howManyTransitionsToArea: 100) equals: 25.
]

{ #category : #tests }
AdventureTest >> testTwoBrivJumpWalksAllLevels [
	| run |
	run := RunPlanner planFor: adventure jumpingBy: 2.
	self assert: (run howManyTransitionsToArea: 100) equals: 34.
	
]

{ #category : #tests }
AdventureTest >> testUniqueTransitions1Jump [
	self testUniqueTransitionsWhenJumping: 1
]

{ #category : #tests }
AdventureTest >> testUniqueTransitions2Jump [
	self testUniqueTransitionsWhenJumping: 2
]

{ #category : #tests }
AdventureTest >> testUniqueTransitions3Jump [
	self testUniqueTransitionsWhenJumping: 3
]

{ #category : #tests }
AdventureTest >> testUniqueTransitions4Jump [
	self testUniqueTransitionsWhenJumping: 4
]

{ #category : #tests }
AdventureTest >> testUniqueTransitions5Jump [
	self testUniqueTransitionsWhenJumping: 5
]

{ #category : #tests }
AdventureTest >> testUniqueTransitions6Jump [
	self testUniqueTransitionsWhenJumping: 6
]

{ #category : #tests }
AdventureTest >> testUniqueTransitions7Jump [
	self testUniqueTransitionsWhenJumping: 7
]

{ #category : #tests }
AdventureTest >> testUniqueTransitions8Jump [
	self testUniqueTransitionsWhenJumping: 8
]

{ #category : #tests }
AdventureTest >> testUniqueTransitions9Jump [
	self testUniqueTransitionsWhenJumping: 9
]

{ #category : #tests }
AdventureTest >> testUniqueTransitionsWhenJumping: jumps [
	"The number of unique transitions for a jump value is defined by the gcd, check we pass through the correct amount "
	| run |
	run := RunPlanner planFor: adventure jumpingBy: jumps.
	self assert: (run transitionsWhere: [ true ]) size equals: run uniqueTransitions.
	
]

{ #category : #tests }
AdventureTest >> testZeroBrivJumpWalksAllLevels [
	| run |
	run := RunPlanner planFor: adventure jumpingBy: 0.
	self assert: (run howManyTransitionsToArea: 100) equals: 100.
	
]
