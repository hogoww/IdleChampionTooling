Class {
	#name : #Monster,
	#superclass : #IdleChampionObject,
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
Monster class >> armoredType [
	^ #armored
]

{ #category : #'as yet unclassified' }
Monster class >> hitBasedType [
	^ #hitBased
]

{ #category : #'instance creation' }
Monster class >> newFrom: aMonsterJSON [

	^ self new
		  json: aMonsterJSON;
		  damageModifier: (aMonsterJSON at: #damage_modifier);
		  graphicId: (aMonsterJSON at: #graphic_id);
		  name: (aMonsterJSON at: #name);
		  id: (aMonsterJSON at: #id);
		  properties: (aMonsterJSON at: #properties);
		  type: (aMonsterJSON at: #type);
		  tags: (aMonsterJSON at: #tags);
		  attackId: (aMonsterJSON at: #attack_id);
		  healthModifier: (aMonsterJSON at: #health_modifier);
		  scale: (aMonsterJSON at: #scale);
		  yourself
]

{ #category : #'as yet unclassified' }
Monster class >> regularType [
	^ #regular
]

{ #category : #accessing }
Monster >> attack [

	^ attack
]

{ #category : #accessing }
Monster >> attack: anObject [

	attack := anObject
]

{ #category : #accessing }
Monster >> attackId [

	^ attackId
]

{ #category : #accessing }
Monster >> attackId: anObject [

	attackId := anObject
]

{ #category : #accessing }
Monster >> damageModifier [

	^ damageModifier
]

{ #category : #accessing }
Monster >> damageModifier: anObject [

	damageModifier := anObject
]

{ #category : #accessing }
Monster >> graphicId [

	^ graphicId
]

{ #category : #accessing }
Monster >> graphicId: anObject [

	graphicId := anObject
]

{ #category : #testing }
Monster >> hasArmorBased [
	^ self tags includes: #armor_based
]

{ #category : #testing }
Monster >> hasHitBasedLife [
	 ^ self tags includes: #hits_based
]

{ #category : #accessing }
Monster >> healthModifier [

	^ healthModifier
]

{ #category : #accessing }
Monster >> healthModifier: anObject [

	healthModifier := anObject
]

{ #category : #accessing }
Monster >> id [

	^ id
]

{ #category : #accessing }
Monster >> id: anObject [

	id := anObject
]

{ #category : #testing }
Monster >> isBoss [
	^ tags includes: #boss
]

{ #category : #testing }
Monster >> isRanged [
	^ self tags includes: #ranged
]

{ #category : #accessing }
Monster >> monsterType [
	"Hardcoded list of non types info in tags. Probably not the best, but good enough"
	^ tags reject: [ :aTag | #(melee ranged boss flying hits_based armor_based) includes: aTag ]
]

{ #category : #accessing }
Monster >> name [

	^ name
]

{ #category : #accessing }
Monster >> name: anObject [

	name := anObject
]

{ #category : #accessing }
Monster >> properties [

	^ properties
]

{ #category : #accessing }
Monster >> properties: anObject [

	properties := anObject
]

{ #category : #accessing }
Monster >> resolveLinksWith: aDatabase [
	attack := aDatabase attackWithId: attackId.
]

{ #category : #accessing }
Monster >> scale [

	^ scale
]

{ #category : #accessing }
Monster >> scale: anObject [

	scale := anObject
]

{ #category : #accessing }
Monster >> tags [

	^ tags
]

{ #category : #accessing }
Monster >> tags: anObject [

	tags := anObject
]

{ #category : #accessing }
Monster >> type [

	^ type
]

{ #category : #accessing }
Monster >> type: anObject [

	type := anObject
]
