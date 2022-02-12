Class {
	#name : #OpenedChest,
	#superclass : #IdleChampionObject,
	#instVars : [
		'chestType',
		'chestContents'
	],
	#pools : [
		'IdleChampionChestIDs'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #accessing }
OpenedChest >> chestContents [

	^ chestContents
]

{ #category : #accessing }
OpenedChest >> chestContents: anObject [

	chestContents := anObject
]

{ #category : #accessing }
OpenedChest >> chestType [

	^ chestType
]

{ #category : #accessing }
OpenedChest >> chestType: anObject [

	chestType := anObject
]
