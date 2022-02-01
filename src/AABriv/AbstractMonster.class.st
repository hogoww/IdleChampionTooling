Class {
	#name : #AbstractMonster,
	#superclass : #IdleChampionJsonObject,
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
		'scale',
		'attack'
	],
	#category : #'AABriv-model'
}

{ #category : #'as yet unclassified' }
AbstractMonster class >> armoredType [
	^ #armored
]

{ #category : #'as yet unclassified' }
AbstractMonster class >> hitBasedType [
	^ #hitBased
]

{ #category : #'as yet unclassified' }
AbstractMonster class >> regularType [
	^ #regular
]

{ #category : #accessing }
AbstractMonster >> attack [

	^ attack
]

{ #category : #accessing }
AbstractMonster >> attack: anObject [

	attack := anObject
]

{ #category : #accessing }
AbstractMonster >> attackId [

	^ attackId
]

{ #category : #accessing }
AbstractMonster >> attackId: anObject [

	attackId := anObject
]

{ #category : #accessing }
AbstractMonster >> damageModifier [

	^ damageModifier
]

{ #category : #accessing }
AbstractMonster >> damageModifier: anObject [

	damageModifier := anObject
]

{ #category : #accessing }
AbstractMonster >> graphicId [

	^ graphicId
]

{ #category : #accessing }
AbstractMonster >> graphicId: anObject [

	graphicId := anObject
]

{ #category : #accessing }
AbstractMonster >> healthModifier [

	^ healthModifier
]

{ #category : #accessing }
AbstractMonster >> healthModifier: anObject [

	healthModifier := anObject
]

{ #category : #accessing }
AbstractMonster >> id [

	^ id
]

{ #category : #accessing }
AbstractMonster >> id: anObject [

	id := anObject
]

{ #category : #accessing }
AbstractMonster >> name [

	^ name
]

{ #category : #accessing }
AbstractMonster >> name: anObject [

	name := anObject
]

{ #category : #accessing }
AbstractMonster >> properties [

	^ properties
]

{ #category : #accessing }
AbstractMonster >> properties: anObject [

	properties := anObject
]

{ #category : #accessing }
AbstractMonster >> resolveLinksWith: aDatabase [
	"no op for common monsters"
]

{ #category : #accessing }
AbstractMonster >> scale [

	^ scale
]

{ #category : #accessing }
AbstractMonster >> scale: anObject [

	scale := anObject
]

{ #category : #accessing }
AbstractMonster >> tags [

	^ tags
]

{ #category : #accessing }
AbstractMonster >> tags: anObject [

	tags := anObject
]

{ #category : #accessing }
AbstractMonster >> type [

	^ type
]

{ #category : #accessing }
AbstractMonster >> type: anObject [

	type := anObject
]
