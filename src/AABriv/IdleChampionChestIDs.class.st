Class {
	#name : #IdleChampionChestIDs,
	#superclass : #SharedPool,
	#classVars : [
		'ElectrumID',
		'GoldElvenChestID',
		'GoldGoldPieceID',
		'GoldID',
		'SilverID'
	],
	#category : #'AABriv-constants'
}

{ #category : #'class initialization' }
IdleChampionChestIDs class >> initialize [
	SilverID := '1'.
	GoldID := '2'.
	ElectrumID := '125'.

	GoldElvenChestID := '392'."392 & 393 might be inverted"
	GoldGoldPieceID := '393'.
]

{ #category : #initialization }
IdleChampionChestIDs class >> nameForID: anID [
	self classPool associationsDo: [ :assoc | assoc value = anID ifTrue: [ ^ assoc key ] ].
	^ anID
]

{ #category : #initialization }
IdleChampionChestIDs class >> priceForChest: anID [
	"Does not take into account the kind of currency currently"
	anID = SilverID ifTrue: [ ^ 50 ].
	anID = GoldID ifTrue: [ ^ 100 ].
	self flag: #todo.
	^ self error
	
]
