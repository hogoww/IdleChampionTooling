Class {
	#name : #IdleChampionChest,
	#superclass : #IdleChampionObject,
	#instVars : [
		'name',
		'namePlural',
		'id',
		'details'
	],
	#category : #'AABriv-model'
}

{ #category : #accessing }
IdleChampionChest >> details [

	^ details
]

{ #category : #accessing }
IdleChampionChest >> details: anObject [

	details := anObject
]

{ #category : #accessing }
IdleChampionChest >> id [

	^ id
]

{ #category : #accessing }
IdleChampionChest >> id: anObject [

	id := anObject
]

{ #category : #accessing }
IdleChampionChest >> name [

	^ name
]

{ #category : #accessing }
IdleChampionChest >> name: anObject [

	name := anObject
]

{ #category : #accessing }
IdleChampionChest >> namePlural [

	^ namePlural
]

{ #category : #accessing }
IdleChampionChest >> namePlural: anObject [

	namePlural := anObject
]
