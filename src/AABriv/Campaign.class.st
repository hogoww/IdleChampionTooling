Class {
	#name : #Campaign,
	#superclass : #Object,
	#instVars : [
		'id',
		'description',
		'name',
		'shortName',
		'type',
		'adventures'
	],
	#category : #'AABriv-model'
}

{ #category : #accessing }
Campaign >> description [

	^ description
]

{ #category : #accessing }
Campaign >> description: anObject [

	description := anObject
]

{ #category : #filling }
Campaign >> fillAdventures [
	| adventureJSON |
	adventureJSON := ((KlehoQueries getAdventuresFor: id) at: #data) at: #adventures.
	adventures := adventureJSON collect: [ :anAdventureJSON | | adventure |
		adventure := Adventure new
			campaign: self;
			name: (anAdventureJSON at: #name);
			id:  (anAdventureJSON at: #id);
			description:  (anAdventureJSON at: #description);
			yourself.
"		adventure fillAreas."
		adventure
		]
]

{ #category : #accessing }
Campaign >> id [

	^ id
]

{ #category : #accessing }
Campaign >> id: anObject [

	id := anObject
]

{ #category : #accessing }
Campaign >> name [

	^ name
]

{ #category : #accessing }
Campaign >> name: anObject [

	name := anObject
]

{ #category : #accessing }
Campaign >> shortName [

	^ shortName
]

{ #category : #accessing }
Campaign >> shortName: anObject [

	shortName := anObject
]

{ #category : #accessing }
Campaign >> type [

	^ type
]

{ #category : #accessing }
Campaign >> type: anObject [

	type := anObject
]
