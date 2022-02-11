Class {
	#name : #IdleChampionUser,
	#superclass : #IdleChampionObject,
	#instVars : [
		'instanceID',
		'chests',
		'userId',
		'userHash'
	],
	#pools : [
		'IdleChampionChestIDs'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #accessing }
IdleChampionUser >> chests [

	^ chests
]

{ #category : #accessing }
IdleChampionUser >> chests: anObject [

	chests := anObject
]

{ #category : #initialization }
IdleChampionUser >> initializeFrom: anUserJson [
	json := anUserJson.
	instanceID := (anUserJson at: #details) at: #instance_id.
	chests := (anUserJson at: #details) at: #chests.

	self flag: #todo. "so many more stuff to scrap"
]

{ #category : #accessing }
IdleChampionUser >> instanceID [
	^ instanceID
]

{ #category : #accessing }
IdleChampionUser >> instanceID: anObject [

	instanceID := anObject
]

{ #category : #accessing }
IdleChampionUser >> userHash [

	^ userHash
]

{ #category : #accessing }
IdleChampionUser >> userHash: anObject [

	userHash := anObject
]

{ #category : #accessing }
IdleChampionUser >> userId [

	^ userId
]

{ #category : #accessing }
IdleChampionUser >> userId: anObject [

	userId := anObject
]
