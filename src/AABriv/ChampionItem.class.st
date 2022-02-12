Class {
	#name : #ChampionItem,
	#superclass : #IdleChampionObject,
	#instVars : [
		'character',
		'slot',
		'isShiny'
	],
	#category : #'AABriv-model'
}

{ #category : #accessing }
ChampionItem >> character [

	^ character
]

{ #category : #accessing }
ChampionItem >> character: anObject [

	character := anObject
]

{ #category : #accessing }
ChampionItem >> isShiny [

	^ isShiny
]

{ #category : #accessing }
ChampionItem >> isShiny: anObject [

	isShiny := anObject
]

{ #category : #accessing }
ChampionItem >> slot [

	^ slot
]

{ #category : #accessing }
ChampionItem >> slot: anObject [

	slot := anObject
]
