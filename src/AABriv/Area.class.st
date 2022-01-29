Class {
	#name : #Area,
	#superclass : #Object,
	#instVars : [
		'quest',
		'enemies',
		'type'
	],
	#category : #'AABriv-model'
}

{ #category : #adding }
Area >> addEnemy: anEnemy [
	enemies add: anEnemy
]

{ #category : #testing }
Area >> hasArmorBased [
	^ enemies anySatisfy: [ :enemy | enemy isArmored ]
]

{ #category : #testing }
Area >> hasHitBased [
	^ enemies anySatisfy: [ :enemy | enemy isHitBased ]
]

{ #category : #initialization }
Area >> hasOnlyType: aType [
	^ enemies allSatisfy: [ :enemy | enemy isOfType: aType ]
]

{ #category : #initialization }
Area >> hasType: aType [
	^ enemies anySatisfy: [ :enemy | enemy isOfType: aType]
]

{ #category : #initialization }
Area >> initialize [
	enemies := OrderedCollection new.
]

{ #category : #testing }
Area >> isOutdoor [
	^ type isOutdoor
]

{ #category : #testing }
Area >> type: aType [
	type := aType
]
