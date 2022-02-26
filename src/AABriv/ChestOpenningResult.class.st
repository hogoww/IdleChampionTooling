Class {
	#name : #ChestOpenningResult,
	#superclass : #IdleChampionObject,
	#instVars : [
		'chestType',
		'chestContents',
		'numberOfChests'
	],
	#pools : [
		'IdleChampionChestIDs'
	],
	#classInstVars : [
		'Log'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #chestType }
ChestOpenningResult class >> goldChestType [
	^ GoldID
]

{ #category : #initializing }
ChestOpenningResult class >> initialize [
	self resetLog
]

{ #category : #accessing }
ChestOpenningResult class >> log [
	^ Log
]

{ #category : #'instance creation' }
ChestOpenningResult class >> new [
	| newUser |
	newUser := super new.
	Log add: newUser.
	^ newUser
]

{ #category : #'instance creation' }
ChestOpenningResult class >> resetLog [
	^ Log := OrderedCollection new
]

{ #category : #accessing }
ChestOpenningResult >> chestContents [

	^ chestContents
]

{ #category : #accessing }
ChestOpenningResult >> chestContents: anObject [

	chestContents := anObject
]

{ #category : #initialization }
ChestOpenningResult >> chestContentsFromJson: lootDetails [
	chestContents := lootDetails collect:[ :aLootDetail |
		(aLootDetail at: #loot_action) = 'claim'
			ifTrue: [ 
				aLootDetail at: #add_gold_amount 
					ifPresent: [ 'gold' ]
					ifAbsent: [
						aLootDetail at: #add_inventory_buff_id
							ifPresent: [ :inventoryBuff | IdleChampionConsumableIDs nameForID: inventoryBuff ]
							ifAbsent: [ 'feat' -> (aLootDetail at: #unlock_hero_feat) ]]]
				 
			ifFalse: [		
				(aLootDetail at: #loot_action) = 'disenchant' 
					ifTrue:[ 
						ChampionItem new 
							character: (aLootDetail at: #hero_id);
							slot: (aLootDetail at: #slot_id);
							isShiny: (aLootDetail at: #gilded);
							yourself
					]
		
		]] into: Bag new
]

{ #category : #accessing }
ChestOpenningResult >> chestType [

	^ chestType
]

{ #category : #accessing }
ChestOpenningResult >> chestType: anObject [

	chestType := anObject
]

{ #category : #accessing }
ChestOpenningResult >> numberOfChests [

	^ numberOfChests
]

{ #category : #accessing }
ChestOpenningResult >> numberOfChests: anObject [

	numberOfChests := anObject
]
