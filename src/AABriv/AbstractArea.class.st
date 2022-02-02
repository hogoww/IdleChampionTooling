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

{ #category : #adding }
AbstractArea >> addEnemy: anEnemy [
	enemies add: anEnemy
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
	^ enemies anySatisfy: [ :enemy | enemy isArmored ]
]

{ #category : #testing }
AbstractArea >> hasHitBased [
	^ enemies anySatisfy: [ :enemy | enemy isHitBased ]
]

{ #category : #initialization }
AbstractArea >> hasOnlyType: aType [
	^ enemies allSatisfy: [ :enemy | enemy isOfType: aType ]
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
AbstractArea >> isOutdoor [
	^ type isOutdoor
]

{ #category : #testing }
AbstractArea >> isQuickTransition [
	^ background isQuickTransition
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
	areaId storeOn: aStream
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
