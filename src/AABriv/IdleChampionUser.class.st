Class {
	#name : #IdleChampionUser,
	#superclass : #IdleChampionObject,
	#instVars : [
		'instanceID',
		'chests',
		'userId',
		'userHash',
		'inventory'
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

{ #category : #accessing }
IdleChampionUser >> gameInstanceId [
	self shouldBeImplemented.
]

{ #category : #'api-chests' }
IdleChampionUser >> howManyChestsOf: aChestId [ 
	^ chests at: aChestId printString
]

{ #category : #initialization }
IdleChampionUser >> initializeFrom: anUserJson [
	| details |
	json := anUserJson.
	details := anUserJson at: #details.
	instanceID := details at: #instance_id.
	chests := details at: #chests.
	inventory := (details at: #buffs)
		collect: [ :d | (IdleChampionConsumableIDs nameForID: (d at: #buff_id)) -> (d at: #inventory_amount) ]
		into: Dictionary new.
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
