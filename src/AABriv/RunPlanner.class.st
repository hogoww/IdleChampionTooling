Class {
	#name : #RunPlanner,
	#superclass : #Object,
	#instVars : [
		'adventure',
		'objective',
		'areas',
		'brivJumps',
		'jumpStartingAt'
	],
	#category : #'AABriv-model'
}

{ #category : #instanciating }
RunPlanner class >> planFor: anAdventure jumpingBy: anAmount [
	^ self new
		adventure: anAdventure ;
		brivJumps: anAmount ;
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

{ #category : #accessing }
RunPlanner >> areas [

	^ areas
]

{ #category : #accessing }
RunPlanner >> areas: anObject [

	areas := anObject
]

{ #category : #accessing }
RunPlanner >> brivJumps [

	^ brivJumps
]

{ #category : #accessing }
RunPlanner >> brivJumps: anObject [

	brivJumps := anObject
]

{ #category : #query }
RunPlanner >> calculateAreas [
	
	^ ((0 to: objective - 1 by: brivJumps + 1) 
		collect: [ :i | i + 1  -> (adventure areaAt: (i rem: 50) + 1) ])
		asOrderedCollection
]

{ #category : #query }
RunPlanner >> calculateAreasFor: anAdventure [
	
	^ ((0 to: objective - 1 by: brivJumps + 1) 
		collect: [ :i | i + 1  -> (anAdventure areaAt: (i rem: 50) + 1) ])
		asOrderedCollection
]

{ #category : #comparing }
RunPlanner >> compareWith: anAdventure [ 
	| adventure1 adventure2 |
	self flag: #todo.
	adventure1 := self recapFor: adventure.
	adventure2 := self recapFor: anAdventure.

]

{ #category : #query }
RunPlanner >> howManyTransitionsToArea: anInteger [ 
	^ (1 to: anInteger by: brivJumps + 1) size
]

{ #category : #accessing }
RunPlanner >> jumpStartingAt [

	^ jumpStartingAt
]

{ #category : #accessing }
RunPlanner >> jumpStartingAt: anObject [

	jumpStartingAt := anObject
]

{ #category : #accessing }
RunPlanner >> objective [

	^ objective
]

{ #category : #accessing }
RunPlanner >> objective: anInteger [ 
	objective := anInteger
]

{ #category : #query }
RunPlanner >> recap: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Recap'> 
	| dictionaryToDisplay |
	dictionaryToDisplay := self recapFor: adventure.
	
	^ aBuilder newTable 
		addColumn: (SpStringTableColumn 
			title: 'Key'
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each key ])
			beSortable;
		addColumn: (SpStringTableColumn 
			title: 'Value' 
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each value ])
			beSortable;
		items: (dictionaryToDisplay associations collect: [:e | StInspectorAssociationNode hostObject: e ]);
		yourself
]

{ #category : #query }
RunPlanner >> recapFor: anAdventure [
	| currentAreas slowDown hitBasedAreas armoredBasedAreas rangedMonsters non25Areas |
	currentAreas := self calculateAreasFor: anAdventure.
	rangedMonsters := currentAreas select: [ :a | a value containsRangeMonsters ].
	slowDown := currentAreas select: [ :a | a value isSlowDown ].
	hitBasedAreas := currentAreas select: [ :a | a value hasHitBased ].
	armoredBasedAreas := currentAreas select: [ :a | a value hasArmorBased ].
	non25Areas := currentAreas select: [ :a | a value quest isSlow ] "thenCollect: [ :a | a key ]".
	
	^ { 
		'Adventure' -> anAdventure.
		'Percentage of quick transitions' -> (adventure quickTransitionsFor: brivJumps) key.
		'Number of areas with ranged enemies' -> (rangedMonsters size printString ,  '/' , objective printString).
		'Number of areas exhibiting some kind of slowdown' -> (slowDown size printString ,  '/' , objective printString).
		'Number of areas containing hit based entity' -> (hitBasedAreas size printString ,  '/' , objective printString).
		'Number of areas containing armor based entity' -> (armoredBasedAreas size printString ,  '/' , objective printString).
		'Number of areas requiring more than one kill (with maxed hew)' -> (non25Areas size printString ,  '/' , objective printString).
		'Areas with ranged enemies' -> rangedMonsters.
		'Areas slowing run down' -> slowDown.
		'Areas containing hit based entity' -> hitBasedAreas.
		'Areas containing armored entity' -> armoredBasedAreas.
		'Areas requiring more than one kill (with maxed hew)' -> non25Areas.
	} asOrderedDictionary. 
]

{ #category : #query }
RunPlanner >> transitionsWhere: aBlock [
	| firstArea transitioningFrom transitioningTo transitions |
	firstArea := adventure areas first.
	transitioningFrom := firstArea.
	transitions := OrderedCollection new.
	[ | nextAreaID|
		nextAreaID := ((transitioningFrom areaId + self brivJumps) \\ (adventure areas size)) + 1.
		transitioningTo := adventure areas at: nextAreaID.
		(aBlock cull: transitioningFrom cull: transitioningTo) 
			ifTrue: [transitions add: (transitioningFrom -> transitioningTo)]. 	
		transitioningTo = firstArea ] 
		whileFalse: [ transitioningFrom := transitioningTo ].
	 ^transitions
]

{ #category : #accessing }
RunPlanner >> uniqueTransitions [
	^ adventure areas size / (adventure areas size gcd: brivJumps + 1)
]

{ #category : #query }
RunPlanner >> visitedAreasWhere: aBlock [
	^ (self transitionsWhere: aBlock) select: #key
]
