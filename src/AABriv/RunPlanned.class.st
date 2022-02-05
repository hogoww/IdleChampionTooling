Class {
	#name : #RunPlanned,
	#superclass : #Object,
	#instVars : [
		'adventure',
		'jumps'
	],
	#category : #'AABriv-model'
}

{ #category : #'as yet unclassified' }
RunPlanned class >> planFor: anAdventure jumpingBy: anAmount [
	^ self new
		adventure: anAdventure ;
		jumps: anAmount ;
		yourself
]

{ #category : #accessing }
RunPlanned >> adventure [

	^ adventure
]

{ #category : #accessing }
RunPlanned >> adventure: anObject [

	adventure := anObject
]

{ #category : #query }
RunPlanned >> howManyTransitionsToArea: anInteger [ 
	^ (1 to: anInteger by: jumps + 1) size
]

{ #category : #accessing }
RunPlanned >> jumps [

	^ jumps
]

{ #category : #accessing }
RunPlanned >> jumps: anObject [

	jumps := anObject
]

{ #category : #query }
RunPlanned >> transitionsWhere: aBlock [
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
RunPlanned >> uniqueTransitions [
	^adventure areas size / (adventure areas size gcd: jumps+1)
]

{ #category : #query }
RunPlanned >> visitedAreasWhere: aBlock [
	^(self transitionsWhere: aBlock) select: #key
]
