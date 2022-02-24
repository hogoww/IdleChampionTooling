Class {
	#name : #IdleChampionConsumableIDs,
	#superclass : #SharedPool,
	#classVars : [
		'EpicBlacksmithID',
		'EpicBoutyID',
		'EpicDamageID',
		'EpicFirebreathID',
		'EpicGoldID',
		'EpicHealthID',
		'EpicSpeedID',
		'HunterGemID',
		'HunterGoldID',
		'HunterMordronID',
		'LargeBlacksmithID',
		'LargeBoutyID',
		'LargeDamageID',
		'LargeFirebreathID',
		'LargeGoldID',
		'LargeHealthID',
		'LargeSpeedID',
		'MediumBlacksmithID',
		'MediumBountyID',
		'MediumDamageID',
		'MediumFirebreathID',
		'MediumGoldID',
		'MediumHealthID',
		'MediumSpeedID',
		'ScrollAssaultDamageID',
		'ScrollMajorDamageID',
		'ScrollMajorGoldID',
		'ScrollMinorDamageID',
		'ScrollMinorGoldID',
		'SmallBlacksmithID',
		'SmallBountyID',
		'SmallDamageID',
		'SmallFirebreathID',
		'SmallGoldID',
		'SmallHealthID',
		'SmallSpeedID',
		'SpecializationID'
	],
	#category : #'AABriv-constants'
}

{ #category : #initialization }
IdleChampionConsumableIDs class >> initialize [
	"""Potions"""
	"Damage (Giant's Strenght)"
	SmallDamageID := 1.
	MediumDamageID := 2.
	LargeDamageID := 3.
	EpicDamageID := 4.
	
	"Gold (Clairvoyance)"
	SmallGoldID := 5.
	MediumGoldID := 6.
	LargeGoldID := 7.
	EpicGoldID := 8.
	
	"Health (Heroism)"
	SmallHealthID := 13.
	MediumHealthID := 14.
	LargeHealthID := 15.
	EpicHealthID := 16.
	
	"Fire Breath"
	SmallFirebreathID := 37.
	MediumFirebreathID := 38.
	LargeFirebreathID := 39.
	EpicFirebreathID := 40.
	
	"Speed"
	SmallSpeedID := 74.
	MediumSpeedID := 75.
	LargeSpeedID := 76.
	EpicSpeedID := 77.
	
	"Miscalenious"
	SpecializationID := 35.

	HunterGoldID := 1721.
	HunterMordronID := 1722.
	HunterGemID := 1723.
	
	"""Others"""
	"Bounty Contracts"
	SmallBountyID := 17.
	MediumBountyID := 18.
	LargeBoutyID := 19.
	EpicBoutyID := 20.
	
	"Blackmith Contracts"
	SmallBlacksmithID := 31.
	MediumBlacksmithID := 32.
	LargeBlacksmithID := 33.
	EpicBlacksmithID := 34.
	
	"Scrolls"
	ScrollMinorDamageID := 1733.
	ScrollMajorDamageID := 1734.
	ScrollMinorGoldID := 1735.
	ScrollMajorGoldID := 1736.
	ScrollAssaultDamageID := 1737.
	
]

{ #category : #initialization }
IdleChampionConsumableIDs class >> nameForID: anID [
	self classPool associationsDo: [ :assoc | assoc value = anID ifTrue: [ ^ assoc key ] ].
	^ anID
]

{ #category : #initialization }
IdleChampionConsumableIDs class >> unknownIds [
	self error.
	"only for documentation purposes"
	'Unrecognized IDs for now:
	23
	26
	36
	126
	1741 - 1777
	'
]
