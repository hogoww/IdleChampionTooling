Class {
	#name : #Quest,
	#superclass : #IdleChampionObject,
	#instVars : [
		'description',
		'type',
		'properties',
		'goalGraphicId',
		'goalAmount',
		'goalDescription',
		'id'
	],
	#category : #'AABriv-model'
}

{ #category : #'instance creation' }
Quest class >> newFrom: aQuestJSON [

	^ self new
		  json: aQuestJSON;
		  description: (aQuestJSON at: #description);
		  type: (aQuestJSON at: #type);
		  properties: (aQuestJSON at: #properties);
		  goalGraphicId: (aQuestJSON at: #goal_graphic_id);
		  goalAmount: (aQuestJSON at: #goal_amount);
		  goalDescription: (aQuestJSON at: #goal_description);
		  id: (aQuestJSON at: #id);
		  yourself
]

{ #category : #accessing }
Quest >> description [

	^ description
]

{ #category : #accessing }
Quest >> description: anObject [

	description := anObject
]

{ #category : #accessing }
Quest >> goalAmount [

	^ goalAmount
]

{ #category : #accessing }
Quest >> goalAmount: anObject [

	goalAmount := anObject
]

{ #category : #accessing }
Quest >> goalDescription [

	^ goalDescription
]

{ #category : #accessing }
Quest >> goalDescription: anObject [

	goalDescription := anObject
]

{ #category : #accessing }
Quest >> goalGraphicId [

	^ goalGraphicId
]

{ #category : #accessing }
Quest >> goalGraphicId: anObject [

	goalGraphicId := anObject
]

{ #category : #accessing }
Quest >> id [

	^ id
]

{ #category : #accessing }
Quest >> id: anObject [

	id := anObject
]

{ #category : #testing }
Quest >> isSlow [
	"Loose definition for now"
	^ self goalAmount ~= 25
]

{ #category : #accessing }
Quest >> properties [

	^ properties
]

{ #category : #accessing }
Quest >> properties: anObject [

	properties := anObject
]

{ #category : #accessing }
Quest >> resolveLinksWith: aDatabase [
	"nothing to do for Quests AFAIK"
]

{ #category : #accessing }
Quest >> type [

	^ type
]

{ #category : #accessing }
Quest >> type: anObject [

	type := anObject
]
