Class {
	#name : #ChestOpenningResult,
	#superclass : #IdleChampionObject,
	#instVars : [
		'chestType',
		'chestContents'
	],
	#pools : [
		'IdleChampionChestIDs'
	],
	#category : #'AABriv-webQuery'
}

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
						(IdleChampionConsumableIDs nameForID: (aLootDetail at: #add_inventory_buff_id)).]
				 ]
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
