Class {
	#name : #IdleChampionUser,
	#superclass : #IdleChampionObject,
	#instVars : [
		'instanceID',
		'userId',
		'userHash',
		'name',
		'inventoryStates',
		'cneQueries'
	],
	#pools : [
		'IdleChampionChestIDs'
	],
	#classInstVars : [
		'RegisteredUser'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #initializing }
IdleChampionUser class >> initialize [
	self resetRegisteredUsers
]

{ #category : #'instance creation' }
IdleChampionUser class >> new [
	| newUser |
	newUser := super new.
	RegisteredUser add: newUser.
	^ newUser
]

{ #category : #registerUsers }
IdleChampionUser class >> registeredUsers [
	^ RegisteredUser
]

{ #category : #registerUsers }
IdleChampionUser class >> resetRegisteredUsers [
	RegisteredUser := OrderedCollection new
]

{ #category : #registerUsers }
IdleChampionUser class >> userNamed: aName [
	^ RegisteredUser detect: [ :anICPUser | anICPUser name = aName ]
]

{ #category : #initialization }
IdleChampionUser >> checkCneQueriesState [
	self initializeCneQueries.
	self updateCneQueriesIfTooOld.
]

{ #category : #accessing }
IdleChampionUser >> cneQueries [
	self checkCneQueriesState.
	^ cneQueries
]

{ #category : #accessing }
IdleChampionUser >> currentInventoryState [
	^ inventoryStates last
]

{ #category : #'api-chests' }
IdleChampionUser >> howManyChestsOf: aChestID [
	^ self currentInventoryState howManyChestsOf: aChestID
]

{ #category : #initialization }
IdleChampionUser >> initialize [
	inventoryStates := OrderedCollection new.
]

{ #category : #initialization }
IdleChampionUser >> initializeCneQueries [
	^  cneQueries ifNil: [ 
		cneQueries := CodeNameEntertainmentQueries forICPUser: self.
		self update
		]
]

{ #category : #initialization }
IdleChampionUser >> initializeYourself [
	"force creation of cneQueries and first user datas"
	self cneQueries.
]

{ #category : #accessing }
IdleChampionUser >> instanceID [
	^ instanceID
]

{ #category : #accessing }
IdleChampionUser >> instanceID: anObject [

	instanceID := anObject
]

{ #category : #accessing }
IdleChampionUser >> inventoryState [
	^ inventoryStates
]

{ #category : #accessing }
IdleChampionUser >> inventoryStates: anObject [

	inventoryStates := anObject
]

{ #category : #accessing }
IdleChampionUser >> name [

	^ name
]

{ #category : #accessing }
IdleChampionUser >> name: anObject [

	name := anObject
]

{ #category : #'api-chests' }
IdleChampionUser >> openAllGoldChests [
	^ self openChests: GoldID times: (self howManyChestsOf: GoldID)
]

{ #category : #'api-chests' }
IdleChampionUser >> openAllSilverChests [
	^ self openChests: SilverID times: (self howManyChestsOf: SilverID)
]

{ #category : #'api-chests' }
IdleChampionUser >> openChests: aChestID times: aNumberOfChests [
	| currentNumberOfChests |
	(self howManyChestsOf: aChestID) > aNumberOfChests 
		ifFalse: [ self error: 'Not enough ' , (IdleChampionChestIDs nameForID: aChestID) ,' Chests available' ].
	currentNumberOfChests := aNumberOfChests.
	^ (1 to: currentNumberOfChests // 50 + 1) collect: [ :i | | res |
		res := self openedChestsFromJson: (self cneQueries openChest: aChestID times: (50 min: currentNumberOfChests) ).	
		currentNumberOfChests := currentNumberOfChests - (50 min: currentNumberOfChests).
		res
		] into: OrderedCollection new
]

{ #category : #'api-chests' }
IdleChampionUser >> openGoldChests: aNumberOfChests [
	^ self openChests: GoldID times: aNumberOfChests
]

{ #category : #'api-chests' }
IdleChampionUser >> openSilverChests: aNumberOfChests [
	^ self openChests: SilverID times: aNumberOfChests
]

{ #category : #'api-chests' }
IdleChampionUser >> openedChestsFromJson: aChestJson [
	| chest |
	chest := ChestOpenningResult new.
	chest chestType: (IdleChampionChestIDs nameForID: ((aChestJson at: #actions) first at: #chest_type_id)).
	chest chestContentsFromJson: (aChestJson at: #loot_details).
	^ chest
]

{ #category : #api }
IdleChampionUser >> redeemAllCodesFrom: aString [
	| extractedCode |
	extractedCode := IdleChampionUtils extractCodesFrom: aString.
	^ extractedCode lines collect: [ :aCode |
		self redeemCode: aCode
		] into: Bag new
]

{ #category : #api }
IdleChampionUser >> redeemCode: aCode [
	| result |
	result := self cneQueries redeemCodeServerCall: aCode.
	^ self redeemCodeResultString: result
]

{ #category : #'result-interpration' }
IdleChampionUser >> redeemCodeResultString: result [
	(result at: #okay) ifTrue: [
		^ (result at: #loot_details) 
			collect: [ :aResult |
				String streamContents: [ :s | 
					s << ((aResult at: #after) - (aResult at: #before)) printString.
					s space.
					s << (aResult at: #loot_item)
				]]].
	^ (result at: #failure_reason)
]

{ #category : #api }
IdleChampionUser >> update [
	| userJson |
	userJson := cneQueries getUserDetailsJson. 
	instanceID := (userJson at: #details) at: #instance_id.
	inventoryStates add: (IdleChampionUserState new initializeFrom: userJson).
]

{ #category : #initialization }
IdleChampionUser >> updateCneQueriesIfTooOld [
	"don't know what 'too old' might be yet"
]

{ #category : #accessing }
IdleChampionUser >> userHash [

	^ userHash
]

{ #category : #accessing }
IdleChampionUser >> userHash: anObject [

	userHash := anObject
]

{ #category : #accessing }
IdleChampionUser >> userId [

	^ userId
]

{ #category : #accessing }
IdleChampionUser >> userId: anObject [

	userId := anObject
]
