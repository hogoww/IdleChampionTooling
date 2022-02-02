Class {
	#name : #Background,
	#superclass : #IdleChampionObject,
	#instVars : [
		'midGraphicId',
		'distractions',
		'farGraphicID',
		'foreGraphicId',
		'nearGraphicId',
		'id',
		'distractionsCnt',
		'properties'
	],
	#category : #'AABriv-model'
}

{ #category : #accessing }
Background >> distractions [

	^ distractions
]

{ #category : #accessing }
Background >> distractions: anObject [

	distractions := anObject
]

{ #category : #accessing }
Background >> distractionsCnt [

	^ distractionsCnt
]

{ #category : #accessing }
Background >> distractionsCnt: anObject [

	distractionsCnt := anObject
]

{ #category : #accessing }
Background >> farGraphicID [

	^ farGraphicID
]

{ #category : #accessing }
Background >> farGraphicID: anObject [

	farGraphicID := anObject
]

{ #category : #accessing }
Background >> foreGraphicId [

	^ foreGraphicId
]

{ #category : #accessing }
Background >> foreGraphicId: anObject [

	foreGraphicId := anObject
]

{ #category : #accessing }
Background >> id [

	^ id
]

{ #category : #accessing }
Background >> id: anObject [

	id := anObject
]

{ #category : #testing }
Background >> isQuickTransition [
	properties ifNil: [ ^ false ].
	properties ifEmpty: [ ^ false ].
	^ properties at: #is_fixed ifAbsent: false
]

{ #category : #accessing }
Background >> midGraphicId [

	^ midGraphicId
]

{ #category : #accessing }
Background >> midGraphicId: anObject [

	midGraphicId := anObject
]

{ #category : #accessing }
Background >> nearGraphicId [

	^ nearGraphicId
]

{ #category : #accessing }
Background >> nearGraphicId: anObject [

	nearGraphicId := anObject
]

{ #category : #accessing }
Background >> properties [

	^ properties
]

{ #category : #accessing }
Background >> properties: anObject [

	properties := anObject
]

{ #category : #accessing }
Background >> resolveLinksWith: aDatabase [
	"Should probably resolve Distractions, however they are not available currently"
]
