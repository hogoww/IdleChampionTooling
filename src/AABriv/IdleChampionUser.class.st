Class {
	#name : #IdleChampionUser,
	#superclass : #IdleChampionObject,
	#instVars : [
		'instanceID',
		'aCodeNameEntertainmentQueries',
		'chests'
	],
	#pools : [
		'IdleChampionChestIDs'
	],
	#category : #'AABriv-webQuery'
}

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
