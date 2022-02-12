Class {
	#name : #IdleChampionUserState,
	#superclass : #IdleChampionObject,
	#instVars : [
		'chests',
		'inventory'
	],
	#pools : [
		'IdleChampionChestIDs'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #accessing }
IdleChampionUserState >> chests [

	^ chests
]

{ #category : #accessing }
IdleChampionUserState >> chests: anObject [

	chests := anObject
]

{ #category : #comparing }
IdleChampionUserState >> differenceWith: anIdleChampionUserState [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
IdleChampionUserState >> howManyChestsOf: aChestID [
	^ chests at: aChestID
]

{ #category : #initializion }
IdleChampionUserState >> initializeFrom: anUserJson [
	| details |
	json := anUserJson.
	details := anUserJson at: #details.
	chests := details at: #chests.
	inventory := (details at: #buffs)
		collect: [ :d | 
			(IdleChampionConsumableIDs nameForID: (d at: #buff_id)) 
				-> (d at: #inventory_amount) 
			] into: Dictionary new.
]

{ #category : #accessing }
IdleChampionUserState >> inventory [

	^ inventory
]

{ #category : #accessing }
IdleChampionUserState >> inventory: anObject [

	inventory := anObject
]
