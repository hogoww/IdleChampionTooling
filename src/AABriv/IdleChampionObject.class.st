Class {
	#name : #IdleChampionObject,
	#superclass : #Object,
	#instVars : [
		'json'
	],
	#pools : [
		'IdleChampionChestIDs',
		'IdleChampionConsumableIDs'
	],
	#category : #'AABriv-model'
}

{ #category : #'instance creation' }
IdleChampionObject class >> newFrom: aJSON [
	^ self subclassResponsibility
]

{ #category : #accessing }
IdleChampionObject >> json [
	^ json
]

{ #category : #accessing }
IdleChampionObject >> json: anObject [

	json := anObject
]
