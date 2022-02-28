Class {
	#name : #Background,
	#superclass : #IdleChampionObject,
	#instVars : [
		'midGraphicId',
		'distractions',
		'distractionsIds',
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
Background >> distractionsIds [

	^ distractionsIds
]

{ #category : #accessing }
Background >> distractionsIds: anObject [

	distractionsIds := anObject
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

{ #category : #testing }
Background >> hasBush [
	^ distractions anySatisfy: [ :aDistraction | aDistraction isBush ]
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
Background >> isFixedArea [
	properties ifNil: [ ^ false ].
	properties ifEmpty: [ ^ false ].
	^ properties at: #is_fixed ifAbsent: false
]

{ #category : #testing }
Background >> isOutdoor [
	^ (self properties at: #area_tags) includes: #outdoors
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

{ #category : #initializing }
Background >> resolveLinksWith: aDatabase [
	distractions := distractionsIds 
		ifNil: [ OrderedCollection new ] 
		ifNotNil: [ :did | did collect: [ :aDistractionID | 
				aDatabase distractionWithId: (aDistractionID at: #distraction_id) ] ].
]
