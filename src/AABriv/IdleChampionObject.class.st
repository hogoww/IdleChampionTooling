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

{ #category : #accessing }
IdleChampionObject >> json [
	^ json
]

{ #category : #accessing }
IdleChampionObject >> json: anObject [

	json := anObject
]
