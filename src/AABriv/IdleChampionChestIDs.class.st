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
	SilverID := 1.
	GoldID := 2.
	ElectrumID := 125.

	GoldElvenChestID := 392."392 & 393 might be inverted"
	GoldGoldPieceID := 393.
]

{ #category : #initialization }
IdleChampionChestIDs class >> nameForID: anID [
	self classPool associationsDo: [ :assoc | assoc value printString = anID ifTrue: [ ^ assoc key ] ].
	^ anID
]
