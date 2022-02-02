Class {
	#name : #Adventure,
	#superclass : #IdleChampionObject,
	#instVars : [
		'campaign',
		'areas',
		'description',
		'id',
		'name',
		'areaSetId'
	],
	#category : #'AABriv-model'
}

{ #category : #initialization }
Adventure >> areaAt: anAreaIndex [
	^ areas at: anAreaIndex
]

{ #category : #initialization }
Adventure >> areaAt: anAreaIndex put: anArea [
	areas at: anAreaIndex put: anArea
]

{ #category : #accessing }
Adventure >> areaSetId [

	^ areaSetId
]

{ #category : #accessing }
Adventure >> areaSetId: anObject [

	areaSetId := anObject
]

{ #category : #accessing }
Adventure >> areas [

	^ areas
]

{ #category : #accessing }
Adventure >> areas: anObject [

	areas := anObject
]

{ #category : #accessing }
Adventure >> campaign [

	^ campaign
]

{ #category : #accessing }
Adventure >> campaign: anObject [

	campaign := anObject
]

{ #category : #accessing }
Adventure >> description [

	^ description
]

{ #category : #accessing }
Adventure >> description: anObject [

	description := anObject
]

{ #category : #initialization }
Adventure >> fillAreasFrom: allAreasJSON [
	"((adventureJSON at: #area_sets) at: (anAdventureJSON at: #area_set_id) printString) at: #areas"
	| areasJSON |			
	areasJSON := allAreasJSON at: areaSetId printString.
	areas := (areasJSON at: #areas) collect: [ :anAreaJSON | | area |
		area := anAreaJSON at: #monsters 
			ifPresent: [ :aValue |
				Area new 
					monsterIds: aValue;
					yourself ]
			ifAbsent: [ 
				BossArea new
					wavesIds: (anAreaJSON at: #waves);
					bossHealth: (anAreaJSON at: #boss_health ifAbsent:[nil]);
					yourself].
		area
			questId: (anAreaJSON at: #quest_id);
			id: (anAreaJSON at: #id);
			backgroundId: (anAreaJSON at: #background_id);
			areaId: (anAreaJSON at: #area_id);			
			yourself
		]
]

{ #category : #accessing }
Adventure >> id [

	^ id
]

{ #category : #accessing }
Adventure >> id: anObject [

	id := anObject
]

{ #category : #initialization }
Adventure >> initialize [
	areas := Array new: 50.
]

{ #category : #accessing }
Adventure >> name [

	^ name
]

{ #category : #accessing }
Adventure >> name: anObject [

	name := anObject
]

{ #category : #printing }
Adventure >> printOn: aStream [
	aStream << 'Adventure: ' << name 
]

{ #category : #enumerating }
Adventure >> quickTransitionsFor: aNumberOfJumps [
	| rp quickTransitions |
	rp := RunPlanned planFor: self jumpingBy: 4.
	rp cacheAreasEncounteredTo: self areas size.

	quickTransitions := OrderedCollection new.
	1 to: rp areas size - 1 do: [ :index |
		| area1 area2 |
		area1 := rp areas at: index.
		area2 := rp areas at: index + 1.
		(area1 value isQuickTransitionTo: area2 value) ifTrue: [ quickTransitions add: area1 ]].
	^ quickTransitions 

]

{ #category : #initialization }
Adventure >> resolveLinksWith: aDatabase [
	areas do: [ :anArea | anArea resolveLinksWith: aDatabase ].
]
