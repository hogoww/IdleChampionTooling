Class {
	#name : #AbstractArea,
	#superclass : #IdleChampionObject,
	#instVars : [
		'monsterIds',
		'questId',
		'cinematicsId',
		'id',
		'backgroundId',
		'areaId',
		'quest',
		'background'
	],
	#category : #'AABriv-model'
}

{ #category : #'instance creation' }
AbstractArea class >> withId: anAreaID [
	 ^self new areaId: anAreaID; yourself
]

{ #category : #accessing }
AbstractArea >> allMonsters [
	^ self subclassResponsibility
]

{ #category : #accessing }
AbstractArea >> areaId [

	^ areaId
]

{ #category : #accessing }
AbstractArea >> areaId: anObject [

	areaId := anObject
]

{ #category : #accessing }
AbstractArea >> background [

	^ background
]

{ #category : #accessing }
AbstractArea >> background: anObject [

	background := anObject
]

{ #category : #accessing }
AbstractArea >> backgroundId [

	^ backgroundId
]

{ #category : #accessing }
AbstractArea >> backgroundId: anObject [

	backgroundId := anObject
]

{ #category : #accessing }
AbstractArea >> cinematicsId [

	^ cinematicsId
]

{ #category : #accessing }
AbstractArea >> cinematicsId: anObject [

	cinematicsId := anObject
]

{ #category : #testing }
AbstractArea >> hasArmorBased [
	^ self allMonsters anySatisfy: [ :aMonster | aMonster hasArmor ]
]

{ #category : #testing }
AbstractArea >> hasHitBased [
	^ self allMonsters anySatisfy: [ :aMonster | aMonster hasHitBasedLife ]
]

{ #category : #initialization }
AbstractArea >> hasOnlyType: aType [
	self subclassResponsibility
]

{ #category : #initialization }
AbstractArea >> hasType: aType [
	^ enemies anySatisfy: [ :enemy | enemy isOfType: aType]
]

{ #category : #accessing }
AbstractArea >> id [

	^ id
]

{ #category : #accessing }
AbstractArea >> id: anObject [

	id := anObject
]

{ #category : #initialization }
AbstractArea >> initialize [
	enemies := OrderedCollection new.
]

{ #category : #testing }
AbstractArea >> isFixedArea [
	^ background isFixedArea
]

{ #category : #testing }
AbstractArea >> isOutdoor [
	^ background isOutdoor
]

{ #category : #testing }
AbstractArea >> isQuickTransitionTo: anotherArea [
	^ self isFixedArea and: [ anotherArea isFixedArea and: [ background = anotherArea background ]]
]

{ #category : #accessing }
AbstractArea >> monsterIds [

	^ monsterIds
]

{ #category : #accessing }
AbstractArea >> monsterIds: anObject [

	monsterIds := anObject
]

{ #category : #printing }
AbstractArea >> printOn: aStream [
	aStream << 'Area #'.
	areaId storeOn: aStream.
	
	self hasArmorBased ifTrue: [ aStream << ' ARMOR ' ].
	self hasHitBased ifTrue: [ aStream << ' HITBASED ' ]. 
]

{ #category : #accessing }
AbstractArea >> quest [

	^ quest
]

{ #category : #accessing }
AbstractArea >> quest: anObject [

	quest := anObject
]

{ #category : #accessing }
AbstractArea >> questId [

	^ questId
]

{ #category : #accessing }
AbstractArea >> questId: anObject [

	questId := anObject
]

{ #category : #initialization }
AbstractArea >> resolveLinksWith: aDatabase [
	quest := aDatabase questWithId: questId.
	background := aDatabase backgroundWithId: backgroundId.
]

{ #category : #testing }
AbstractArea >> type: aType [
	type := aType
]
