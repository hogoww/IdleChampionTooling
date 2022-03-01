Class {
	#name : #IdleChampionUserState,
	#superclass : #IdleChampionObject,
	#instVars : [
		'chests',
		'inventory',
		'timeStamp'
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

{ #category : #api }
IdleChampionUserState >> chestsOf: aChestID [
	^ chests at: aChestID id printString
]

{ #category : #comparing }
IdleChampionUserState >> compareTo: anIdleChampionUserState [ 
	| gems gemsPerHours hoursElapsed silverChests silverChestsPerHours goldChests goldChestsPerHours |
	hoursElapsed := (self timeElapsedWith: anIdleChampionUserState) asHours.
	gems := self totalGems - anIdleChampionUserState totalGems.
	gemsPerHours := gems / hoursElapsed.

	silverChests := (self chestsOf: SilverID) - (anIdleChampionUserState chestsOf: SilverID).
	silverChestsPerHours := silverChests / hoursElapsed.
	goldChests := (self chestsOf: GoldID) - (anIdleChampionUserState chestsOf: GoldID).
	goldChestsPerHours := goldChests / hoursElapsed.
	^ { 'Hours elapsed: ' -> hoursElapsed.
		'Gems gained' -> gems.
		'Gems per hours' -> gemsPerHours.
		
		'Silver chests gained' -> silverChests.
		'Silver chests per hours' -> silverChestsPerHours.

		'Gold chests gained' -> goldChests.
		'Gold chests per hours' -> goldChests.	
		} asDictionary
]

{ #category : #comparing }
IdleChampionUserState >> differenceWith: anIdleChampionUserState [ 
	self shouldBeImplemented.
]

{ #category : #api }
IdleChampionUserState >> gems [
	^ (json at: #details) at: #red_rubies
]

{ #category : #accessing }
IdleChampionUserState >> gemsSpent [
	^ (json at: #details) at: #red_rubies_spent
]

{ #category : #initializion }
IdleChampionUserState >> initializeFrom: anUserJson [
	| details |
	json := anUserJson.
	timeStamp := DateAndTime now.
	details := anUserJson at: #details.
	chests := details at: #chests.
	inventory := (details at: #buffs)
		collect: [ :d | 
			(IdleChampionConsumableIDs chestForID: (d at: #buff_id)) 
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

{ #category : #testing }
IdleChampionUserState >> timeElapsedWith: anIdleChampionUserState [ 
	^ timeStamp - anIdleChampionUserState timeStamp
]

{ #category : #accessing }
IdleChampionUserState >> timeStamp [

	^ timeStamp
]

{ #category : #accessing }
IdleChampionUserState >> timeStamp: anObject [

	timeStamp := anObject
]

{ #category : #accessing }
IdleChampionUserState >> totalGems [
	^ self gemsSpent + self gems
]
