Class {
	#name : #Enemy,
	#superclass : #Object,
	#instVars : [
		'damageModifier',
		'graphicId',
		'name',
		'id',
		'properties',
		'type',
		'tags',
		'attackId',
		'healthModifier',
		'scale'
	],
	#category : #'AABriv-model'
}

{ #category : #'as yet unclassified' }
Enemy class >> armoredType [
	^ #armored
]

{ #category : #'as yet unclassified' }
Enemy class >> hitBasedType [
	^ #hitBased
]

{ #category : #'as yet unclassified' }
Enemy class >> regularType [
	^ #regular
]

{ #category : #accessing }
Enemy >> attackId [

	^ attackId
]

{ #category : #accessing }
Enemy >> attackId: anObject [

	attackId := anObject
]

{ #category : #accessing }
Enemy >> damageModifier [

	^ damageModifier
]

{ #category : #accessing }
Enemy >> damageModifier: anObject [

	damageModifier := anObject
]

{ #category : #accessing }
Enemy >> graphicId [

	^ graphicId
]

{ #category : #accessing }
Enemy >> graphicId: anObject [

	graphicId := anObject
]

{ #category : #accessing }
Enemy >> healthModifier [

	^ healthModifier
]

{ #category : #accessing }
Enemy >> healthModifier: anObject [

	healthModifier := anObject
]

{ #category : #accessing }
Enemy >> id [

	^ id
]

{ #category : #accessing }
Enemy >> id: anObject [

	id := anObject
]

{ #category : #accessing }
Enemy >> name [

	^ name
]

{ #category : #accessing }
Enemy >> name: anObject [

	name := anObject
]

{ #category : #accessing }
Enemy >> properties [

	^ properties
]

{ #category : #accessing }
Enemy >> properties: anObject [

	properties := anObject
]

{ #category : #accessing }
Enemy >> scale [

	^ scale
]

{ #category : #accessing }
Enemy >> scale: anObject [

	scale := anObject
]

{ #category : #accessing }
Enemy >> tags [

	^ tags
]

{ #category : #accessing }
Enemy >> tags: anObject [

	tags := anObject
]

{ #category : #accessing }
Enemy >> type [

	^ type
]

{ #category : #accessing }
Enemy >> type: anObject [

	type := anObject
]
