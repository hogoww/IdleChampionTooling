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

{ #category : #accessing }
IdleChampionUserState >> howManyChestsOf: aChestID [
	^ chests howManyChestsOf: aChestID
]

{ #category : #initializion }
IdleChampionUserState >> initializeFrom: userDetailsJson [
	chests := userDetailsJson at: #chests.
	inventory := (userDetailsJson at: #buffs)
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
