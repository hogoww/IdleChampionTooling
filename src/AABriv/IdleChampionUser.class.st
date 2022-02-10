Class {
	#name : #IdleChampionUser,
	#superclass : #IdleChampionObject,
	#instVars : [
		'instanceID',
		'aCodeNameEntertainmentQueries',
		'chests'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #initialization }
IdleChampionUser >> initializeFrom: anUserJson [
	json := anUserJson.
	instanceID := (anUserJson at: #details) at: #instance_id.
	"(chests at: #silver) put: ((anUserJson at: #details) at: #instance_id)."
	"self halt."
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
