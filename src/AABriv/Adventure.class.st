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

{ #category : #'instance creation' }
Adventure class >> newFrom: anAdventureJSON [

	^ self new
		  json: anAdventureJSON;
		  campaign: self;
		  name: (anAdventureJSON at: #name);
		  id: (anAdventureJSON at: #id);
		  description: (anAdventureJSON at: #description);
		  areaSetId: (anAdventureJSON at: #area_set_id);
		  fillAreasFrom: (anAdventureJSON at: #area_sets);
		  yourself
]

{ #category : #'instance creation' }
Adventure class >> newFrom: anAdventureJSON andAreas: areaSets [

	^ self new
		  json: anAdventureJSON;
		  campaign: self;
		  name: (anAdventureJSON at: #name);
		  id: (anAdventureJSON at: #id);
		  description: (anAdventureJSON at: #description);
		  areaSetId: (anAdventureJSON at: #area_set_id);
		  fillAreasFrom: areaSets;
		  yourself
]

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
Adventure >> fillAreasFrom: allAreaJSONs [
	"((adventureJSON at: #area_sets) at: (anAdventureJSON at: #area_set_id) printString) at: #areas"
	| areasJSON |			
	areasJSON := allAreaJSONs at: areaSetId printString.
	areas := (areasJSON at: #areas) collect: [ :anAreaJSON |
		AbstractArea newFrom: anAreaJSON
		]
]

{ #category : #testing }
Adventure >> hasArmorBased [
	^ self areas anySatisfy: [ :a | a hasArmorBased ]
]

{ #category : #testing }
Adventure >> hasHitBasedLife [
	^ self areas anySatisfy: [ :a | a hasHitBasedLife ]
]

{ #category : #testing }
Adventure >> highestKrullBush [
	^ self areas reverse detect: [ :area | area isFitForKrullBush ] ifNone: nil
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
	aStream << '('
		<< campaign name;
		<< ')Adventure: ';
		<< name 
]

{ #category : #testing }
Adventure >> quickTransitionForEveryJumps [
	^ (0 to: 14) collect: [ :i | i -> (self quickTransitionsFor: i) ]
]

{ #category : #enumerating }
Adventure >> quickTransitionsFor: aNumberOfJumps [
	| rp transitions percentageQuick |
		rp := RunPlanner new 
		adventure: self; 
		brivJumps: aNumberOfJumps;
		yourself.
	transitions := rp transitionsWhere: [:area1 :area2 | 
		area1 isQuickTransitionTo: area2 ].
	percentageQuick := (transitions size / rp uniqueTransitions) asFloat.
	^percentageQuick -> transitions
]

{ #category : #initialization }
Adventure >> resolveLinksWith: aDatabase [
	areas do: [ :anArea | anArea resolveLinksWith: aDatabase ].
]
