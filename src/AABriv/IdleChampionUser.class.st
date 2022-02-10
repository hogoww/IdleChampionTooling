Class {
	#name : #IdleChampionUser,
	#superclass : #IdleChampionObject,
	#instVars : [
		'instanceID',
		'aCodeNameEntertainmentQueries'
	],
	#category : #'AABriv-model'
}

{ #category : #initialization }
IdleChampionUser >> initializeFrom: anUserJson [
	json := anUserJson.
	instanceID := (anUserJson at: #details) at: #instance_id.
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
