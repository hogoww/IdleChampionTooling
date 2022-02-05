Class {
	#name : #RunPlanner,
	#superclass : #Object,
	#instVars : [
		'adventure',
		'jumps',
		'objective',
		'areas'
	],
	#category : #'AABriv-model'
}

{ #category : #instanciating }
RunPlanner class >> planFor: anAdventure jumpingBy: anAmount [
	^ self new
		adventure: anAdventure ;
		jumps: anAmount ;
		yourself
]

{ #category : #accessing }
RunPlanner >> adventure [

	^ adventure
]

{ #category : #accessing }
RunPlanner >> adventure: anObject [

	adventure := anObject
]

{ #category : #precalcul }
RunPlanner >> calculateAreas [
	
	^ ((0 to: objective - 1 by: jumps + 1) 
		collect: [ :i | i + 1  -> (adventure areaAt: (i rem: 50) + 1) ])
		asOrderedCollection
]

{ #category : #query }
RunPlanner >> howManyTransitionsToArea: anInteger [ 
	^ (1 to: anInteger by: jumps + 1) size
]

{ #category : #accessing }
RunPlanner >> jumps [

	^ jumps
]

{ #category : #accessing }
RunPlanner >> jumps: anObject [

	jumps := anObject
]

{ #category : #accessing }
RunPlanner >> objective: anInteger [ 
	objective := anInteger
]

{ #category : #inspecting }
RunPlanner >> showMeAreas [
	areas := self calculateAreas.
	self halt.
]

{ #category : #query }
RunPlanner >> transitionsWhere: aBlock [
	| firstArea transitioningFrom transitioningTo transitions |
	firstArea := adventure areas first.
	transitioningFrom := firstArea.
	transitions := OrderedCollection new.
	[ | nextAreaID|
		nextAreaID := ((transitioningFrom areaId + self jumps) \\ (adventure areas size)) + 1.
		transitioningTo := adventure areas at: nextAreaID.
		(aBlock cull: transitioningFrom cull: transitioningTo) 
			ifTrue: [transitions add: (transitioningFrom -> transitioningTo)]. 	
		transitioningTo = firstArea ] 
		whileFalse: [ transitioningFrom := transitioningTo ].
	 ^transitions
]

{ #category : #accessing }
RunPlanner >> uniqueTransitions [
	^adventure areas size / (adventure areas size gcd: jumps+1)
]

{ #category : #query }
RunPlanner >> visitedAreasWhere: aBlock [
	^(self transitionsWhere: aBlock) select: #key
]
