Class {
	#name : #IdleChampionChestIDs,
	#superclass : #SharedPool,
	#classVars : [
		'GoldChestID',
		'SilverChestID'
	],
	#category : #'AABriv-constants'
}

{ #category : #initialization }
IdleChampionChestIDs class >> initialize [
	SilverChestID := 1.
	GoldChestID := 2.

]
