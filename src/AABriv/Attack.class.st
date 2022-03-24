Class {
	#name : #Attack,
	#superclass : #IdleChampionObject,
	#instVars : [
		'graphicId',
		'description',
		'name',
		'aoeRadius',
		'id',
		'longDescription',
		'target',
		'numTargets',
		'tags',
		'damageModifier',
		'cooldown',
		'damageTypes'
	],
	#category : #'AABriv-model'
}

{ #category : #'instance creation' }
Attack class >> newFrom: anAttackJSON [
	^ self new
		graphicId: (anAttackJSON at: #graphic_id);
		description: (anAttackJSON at: #description);
		name: (anAttackJSON at: #name);
		aoeRadius: (anAttackJSON at: #aoe_radius); 
		id: (anAttackJSON at: #id);
		longDescription: (anAttackJSON at: #long_description); 
		target: (anAttackJSON at: #target);
		numTargets: (anAttackJSON at: #num_targets);
		tags: (anAttackJSON at: #tags);
		damageModifier: (anAttackJSON at: #damage_modifier);
		cooldown: (anAttackJSON at: #cooldown); 
		damageTypes: (anAttackJSON at: #damage_types);
		yourself
]

{ #category : #accessing }
Attack >> aoeRadius [

	^ aoeRadius
]

{ #category : #accessing }
Attack >> aoeRadius: anObject [

	aoeRadius := anObject
]

{ #category : #accessing }
Attack >> cooldown [

	^ cooldown
]

{ #category : #accessing }
Attack >> cooldown: anObject [

	cooldown := anObject
]

{ #category : #accessing }
Attack >> damageModifier [

	^ damageModifier
]

{ #category : #accessing }
Attack >> damageModifier: anObject [

	damageModifier := anObject
]

{ #category : #accessing }
Attack >> damageTypes [

	^ damageTypes
]

{ #category : #accessing }
Attack >> damageTypes: anObject [

	damageTypes := anObject
]

{ #category : #accessing }
Attack >> description [

	^ description
]

{ #category : #accessing }
Attack >> description: anObject [

	description := anObject
]

{ #category : #accessing }
Attack >> graphicId [

	^ graphicId
]

{ #category : #accessing }
Attack >> graphicId: anObject [

	graphicId := anObject
]

{ #category : #accessing }
Attack >> id [

	^ id
]

{ #category : #accessing }
Attack >> id: anObject [

	id := anObject
]

{ #category : #accessing }
Attack >> longDescription [

	^ longDescription
]

{ #category : #accessing }
Attack >> longDescription: anObject [

	longDescription := anObject
]

{ #category : #accessing }
Attack >> name [

	^ name
]

{ #category : #accessing }
Attack >> name: anObject [

	name := anObject
]

{ #category : #accessing }
Attack >> numTargets [

	^ numTargets
]

{ #category : #accessing }
Attack >> numTargets: anObject [

	numTargets := anObject
]

{ #category : #printing }
Attack >> printOn: aStream [
	aStream << 'Attack '
		<< damageTypes
		<< ' ('.
	cooldown printOn: aStream.
	aStream << 's)'
]

{ #category : #accessing }
Attack >> resolveLinksWith: aDatabase [
	"nothing to do for weapons AFAIK"
]

{ #category : #accessing }
Attack >> tags [

	^ tags
]

{ #category : #accessing }
Attack >> tags: anObject [

	tags := anObject
]

{ #category : #accessing }
Attack >> target [

	^ target
]

{ #category : #accessing }
Attack >> target: anObject [

	target := anObject
]
