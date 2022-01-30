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
	1 to: 50 do: [ :i | anAdventure areaAt: i put: AbstractArea new ]
]

{ #category : #running }
AdventureTest >> setUp [
	adventure := Adventure new.
	self fillWithRandomAreas: adventure.
]

{ #category : #test }
AdventureTest >> testCollectAreasWithOneJumpShouldContainHalfOfTheAreas [
	| run |
	run := RunPlanned planFor: adventure jumpingBy: 1.
	self assert: (run collectAreasTo: 100) size equals: 50.
	
	
	
]

{ #category : #test }
AdventureTest >> testCollectAreasWithTwoJumpShouldContainsAThirdOfTheAreas [
	| run |
	run := RunPlanned planFor: adventure jumpingBy: 2.
	self assert: (run collectAreasTo: 100) size equals: 34.
	
	
	
]

{ #category : #test }
AdventureTest >> testCollectAreasWithTwoJumpShouldHaveAsLastArea99 [
	| run |
	run := RunPlanned planFor: adventure jumpingBy: 2.
	run cacheAreasEncounteredTo: 100.
	self assert: run lastAreaNumber equals: 99.
]

{ #category : #test }
AdventureTest >> testCollectAreasWithZeroJumpShouldContainAllAreas [
	| run |
	run := RunPlanned planFor: adventure jumpingBy: 0.
	self assert: (run collectAreasTo: 100) size equals: 100.
	
	
	
]

{ #category : #test }
AdventureTest >> testFourBrivJumpWalksAllLevels [
	| run |
	run := RunPlanned planFor: adventure jumpingBy: 4.
	self assert: (run howManyAreasTo: 100) equals: 20.
	
]

{ #category : #test }
AdventureTest >> testOneBrivJumpWalksAllLevels [
	| run |
	run := RunPlanned planFor: adventure jumpingBy: 1.
	self assert: (run howManyAreasTo: 50) equals: 25.
	
]

{ #category : #test }
AdventureTest >> testThreeBrivJumpWalksAllLevels [
	| run |
	run := RunPlanned planFor: adventure jumpingBy: 3.
	self assert: (run howManyAreasTo: 100) equals: 25.
]

{ #category : #test }
AdventureTest >> testTwoBrivJumpWalksAllLevels [
	| run |
	run := RunPlanned planFor: adventure jumpingBy: 2.
	self assert: (run howManyAreasTo: 100) equals: 34.
	
]

{ #category : #test }
AdventureTest >> testZeroBrivJumpWalksAllLevels [
	| run |
	run := RunPlanned planFor: adventure jumpingBy: 0.
	self assert: (run howManyAreasTo: 100) equals: 100.
	
]
