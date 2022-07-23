Class {
	#name : #Distraction,
	#superclass : #IdleChampionObject,
	#instVars : [
		'type',
		'rewards',
		'name',
		'graphicID',
		'id',
		'properties'
	],
	#category : #'AABriv-model'
}

{ #category : #'instance creation' }
Distraction class >> newFrom: aDistractionJSON [
	^ self new
			json: aDistractionJSON;
			type: (aDistractionJSON at: #type);
			rewards: (aDistractionJSON at: #rewards);
			name: (aDistractionJSON at: #name);
			graphicID: (aDistractionJSON at: #graphic_id);
			id: (aDistractionJSON at: #id);
			properties: (aDistractionJSON at: #properties);
			yourself
]

{ #category : #accessing }
Distraction >> graphicID [

	^ graphicID
]

{ #category : #accessing }
Distraction >> graphicID: anObject [

	graphicID := anObject
]

{ #category : #accessing }
Distraction >> id [

	^ id
]

{ #category : #accessing }
Distraction >> id: anObject [

	id := anObject
]

{ #category : #testing }
Distraction >> isBush [
	^ rewards anySatisfy: [ :aReward | (aReward at: #reward) = 'spawn_monster' ].
]

{ #category : #accessing }
Distraction >> name [

	^ name
]

{ #category : #accessing }
Distraction >> name: anObject [

	name := anObject
]

{ #category : #printing }
Distraction >> printOn: aStream [

	aStream << self class name << '(' << name << ')'
]

{ #category : #accessing }
Distraction >> properties [

	^ properties
]

{ #category : #accessing }
Distraction >> properties: anObject [

	properties := anObject
]

{ #category : #accessing }
Distraction >> rewards [

	^ rewards
]

{ #category : #accessing }
Distraction >> rewards: anObject [

	rewards := anObject
]

{ #category : #accessing }
Distraction >> type [

	^ type
]

{ #category : #accessing }
Distraction >> type: anObject [

	type := anObject
]
