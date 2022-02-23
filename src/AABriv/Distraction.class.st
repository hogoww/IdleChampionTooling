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
	#category : #'AABriv-database'
}

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
	^ properties at: #chance_of_spawning 
		ifPresent: [ :v | self haltIf: [ v = 0 "I want to see it" ]. ^ true ]
		ifAbsent: [ ^ false ]
]

{ #category : #accessing }
Distraction >> name [

	^ name
]

{ #category : #accessing }
Distraction >> name: anObject [

	name := anObject
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