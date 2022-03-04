Class {
	#name : #RunPlanner,
	#superclass : #Object,
	#instVars : [
		'adventure',
		'objective',
		'areas',
		'brivJumps',
		'jumpStart'
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
	| collection |
	
	collection := OrderedCollection new.
	"(0 to: jumpStart) collect: [ :i |  ] into: collection."
	((jumpStart to: objective - 1 by: brivJumps + 1) 
		collect: [ :i | i + 1  -> (adventure areaAt: (i rem: adventure areas size) + 1) ]
		into: collection).
	areas := collection
]

{ #category : #query }
RunPlanner >> calculateAreasFor: anAdventure [
	| collection |
	collection := OrderedCollection new.
	"(0 to: jumpStart) collect: [ :i |  ] into: collection."
	((jumpStart to: objective - 1 by: brivJumps + 1) 
		collect: [ :i | i + 1  -> (anAdventure areaAt: (i rem: 50) + 1) ]
		into: collection).
	^ collection
]

{ #category : #'private - computation' }
RunPlanner >> calculatePossibleStackingAreaFrom: areasEncountered [
	"TODO, work in progress"
	

	"initialization for a string that is not in the list of possible values of types."
	| longestMonsterTypeEncountered |
	longestMonsterTypeEncountered := Dictionary new.
	areasEncountered reverse do:[ :anArea|
		anArea value allMonsterTypes 
			do:[ :aType | 
				longestMonsterTypeEncountered at: aType ifAbsentPut: [ aType -> (OrderedCollection with: anArea value) ] ]
		].
	self halt.
]

{ #category : #query }
RunPlanner >> calculateQuickTransitionsFor: areasEncountered [
	| res |
	res := OrderedCollection new.
	1 to: areasEncountered size - 1 do: [ :index | | v1 v2 |
		v1 := (areasEncountered at: index) value.
		v2 := (areasEncountered at: index + 1) value.
		(v1 isQuickTransitionTo: v2) ifTrue: [ res add: v1 -> v2 ]
		].
	^ res
]

{ #category : #comparing }
RunPlanner >> compareWith: anAdventure [ 
	| adventure1 adventure2 |
	self flag: #todo.
	adventure1 := self recapFor: adventure.
	adventure2 := self recapFor: anAdventure.

]

{ #category : #testing }
RunPlanner >> hasArmorBased [
	^ areas anySatisfy: [ :anArea | anArea value hasArmorBased ]
]

{ #category : #testing }
RunPlanner >> hasHitBased [
	^ areas anySatisfy: [ :anArea | anArea value hasHitBased ]
]

{ #category : #query }
RunPlanner >> howManyTransitionsToArea: anInteger [ 
	^ (1 to: anInteger by: brivJumps + 1) size
]

{ #category : #query }
RunPlanner >> initialize [
	"basic default values"
	jumpStart := 0.
	brivJumps := 0.
	objective := 50.
]

{ #category : #accessing }
RunPlanner >> jumpStart [

	^ jumpStart
]

{ #category : #accessing }
RunPlanner >> jumpStart: anAreaNumber [

	jumpStart := anAreaNumber
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
RunPlanner >> recapDisplay: aBuilder [
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
	| areasEncountered slowDown hitBasedAreas armoredBasedAreas rangedMonsters non25Areas quickTransitions possibleStackingAreas |
	areasEncountered := self calculateAreasFor: anAdventure.
	quickTransitions := self calculateQuickTransitionsFor: areasEncountered.
	
	rangedMonsters := areasEncountered select: [ :a | a value containsRangeMonsters ].
	slowDown := areasEncountered select: [ :a | a value isSlowDown ].
	hitBasedAreas := areasEncountered select: [ :a | a value hasHitBased ].
	armoredBasedAreas := areasEncountered select: [ :a | a value hasArmorBased ].
	non25Areas := areasEncountered select: [ :a | a value quest isSlow ] "thenCollect: [ :a | a key ]".
	"possibleStackingAreas := self calculatePossibleStackingAreaFrom: areasEncountered."
	^ { 
		'Adventure' -> anAdventure.
		'Number of quick transitions' -> (quickTransitions size printString ,  '/' , areasEncountered size printString).
		'Number of areas with ranged enemies' -> (rangedMonsters size printString ,  '/' , areasEncountered size printString).
		'Number of areas exhibiting some kind of slowdown' -> (slowDown size printString ,  '/' , areasEncountered size printString).
		'Number of areas containing hit based entity' -> (hitBasedAreas size printString ,  '/' , areasEncountered size printString).
		'Number of areas containing armor based entity' -> (armoredBasedAreas size printString ,  '/' , areasEncountered size printString).
		'Number of areas requiring more than one kill (with maxed hew)' -> (non25Areas size printString ,  '/' , areasEncountered size printString).
		'All areas encountered' -> areasEncountered.
		'All quick transitions (QTs)' -> quickTransitions.
		'Areas with ranged enemies' -> rangedMonsters.
		'Areas slowing run down' -> slowDown.
		'Areas containing hit based entity' -> hitBasedAreas.
		'Areas containing armored entity' -> armoredBasedAreas.
		'Areas requiring more than one kill (with maxed hew)' -> non25Areas.
"		'Possible stacking areas' -> possibleStackingAreas."
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
