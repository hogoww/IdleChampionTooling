Class {
	#name : #Quest,
	#superclass : #Object,
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
