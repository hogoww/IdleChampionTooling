Class {
	#name : #Campaign,
	#superclass : #IdleChampionObject,
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

{ #category : #'instance creation' }
Campaign class >> newFrom: aCampaignJSON [

	^ self new
		  json: aCampaignJSON;
		  id: (aCampaignJSON at: #id);
		  description: (aCampaignJSON at: #name);
		  name: (aCampaignJSON at: #short_name);
		  type: (aCampaignJSON at: #type);
		  fillAdventures;
		  yourself
]

{ #category : #accessing }
Campaign >> adventures [

	^ adventures
]

{ #category : #accessing }
Campaign >> adventures: anObject [

	adventures := anObject
]

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
	| adventureJSONs |
	adventureJSONs := ((KlehoQueries getAdventuresFor: id) at: #data).

	adventures := ((adventureJSONs at: #adventures) collect: [ :anAdventureJSON | 
		| adventure |
		adventure := (Adventure newFrom: anAdventureJSON andAreas: (adventureJSONs at: #area_sets))
			campaign: self;
			yourself.
		]) values
]

{ #category : #query }
Campaign >> findAdventureNamed: aString [
	^ adventures detect: [ :anAdventure | anAdventure name = aString ] ifNone: nil
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

{ #category : #printing }
Campaign >> printOn: aStream [
	aStream << 'Campaign:  '.
	shortName ifNil: [ aStream << name ]
		ifNotNil: [ aStream << shortName ] 
]

{ #category : #accessing }
Campaign >> resolveLinksWith: aDatabase [
	adventures do: [ :anAdventure | anAdventure resolveLinksWith: aDatabase  ].
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
