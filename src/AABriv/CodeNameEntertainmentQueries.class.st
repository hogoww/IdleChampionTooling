Class {
	#name : #CodeNameEntertainmentQueries,
	#superclass : #IdleChampionQueries,
	#instVars : [
		'userHash',
		'user',
		'userObject'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #url }
CodeNameEntertainmentQueries class >> baseUrl [
	^ 'http://ps7.idlechampions.com/~idledragons/post.php?call='
]

{ #category : #initialization }
CodeNameEntertainmentQueries class >> forICPUser: anICPUser [ 
	^ self forUser: anICPUser user
		andHash: anICPUser userHash
]

{ #category : #url }
CodeNameEntertainmentQueries class >> forUser: aUser andHash: aHash [
	^ self basicNew
		user: aUser;
		userHash: aHash;
		initialize;
		yourself
]

{ #category : #url }
CodeNameEntertainmentQueries class >> handleErrorIfAnyFrom: aJson [
	(aJson at: #success) 
		ifFalse: [ self error: 
			(String streamContents: [ :s | 
				 s << (aJson at: #error_code) printString;
					<< ' ';
					<< (aJson at: #failure_reason)
		 	])
		]
]

{ #category : #'query-support' }
CodeNameEntertainmentQueries >> baseUrl [
	^ self class baseUrl
]

{ #category : #query }
CodeNameEntertainmentQueries >> getUserDetailsJson [
	| response |
	response := self newQuery
		url: self userDetailsUrl asUrl;
		addPart: 	(ZnMimePart fieldName: 'include_free_play_objectives' value: 'true');
		addPart: 	(ZnMimePart fieldName: 'instance_key' value: '1');
		addPart: 	self userPart;
		addPart: self userHashPart;
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #initialization }
CodeNameEntertainmentQueries >> initialize [
	userObject := IdleChampionUser new
		initializeFrom: self getUserDetailsJson;
		yourself.
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> instanceIdPart [
	^ ZnMimePart fieldName: 'instance_id' value: userObject instanceID
]

{ #category : #'rest-support' }
CodeNameEntertainmentQueries >> jsonFrom: response [
	^ self class jsonFrom: response

]

{ #category : #'rest-support' }
CodeNameEntertainmentQueries >> newQuery [
	^ self class newQuery
]

{ #category : #query }
CodeNameEntertainmentQueries >> redeemAllCodesFrom: aString [
	| extractedCode |
	extractedCode := IdleChampionUtils extractCodesFrom: aString.
	^ extractedCode lines collect: [ :aCode |
		self redeemCode: aCode
		] into: Bag new
]

{ #category : #query }
CodeNameEntertainmentQueries >> redeemCode: aCode [
	| result |
	result := self redeemCodeServerCall: aCode.
	^ self redeemCodeResultString: result
]

{ #category : #query }
CodeNameEntertainmentQueries >> redeemCodeResultString: result [
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

{ #category : #query }
CodeNameEntertainmentQueries >> redeemCodeServerCall: aCode [
	| response query |
	query := self newQuery
		url: self redeemUrl asUrl.
	query addDummyDataPart.
	response := query
		addPart: 	self userPart;
		addPart: self userHashPart;
		addPart: self instanceIdPart;
		addPart: 	(ZnMimePart fieldName: 'code' value: aCode);
		post;
		response.
	^ self jsonFrom: response
]

{ #category : #url }
CodeNameEntertainmentQueries >> redeemUrl [
	^ self baseUrl , 'redeemcoupon'
]

{ #category : #accessing }
CodeNameEntertainmentQueries >> user [

	^ user
]

{ #category : #accessing }
CodeNameEntertainmentQueries >> user: anObject [

	user := anObject
]

{ #category : #url }
CodeNameEntertainmentQueries >> userDetailsUrl [
	^ String streamContents: [ :s | 
		s << self baseUrl;
			<< 'getuserdetails'
		]
]

{ #category : #accessing }
CodeNameEntertainmentQueries >> userHash [
	"Rename to avoid clashing with #hash system method"
	^ userHash
]

{ #category : #accessing }
CodeNameEntertainmentQueries >> userHash: anObject [

	userHash := anObject
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> userHashPart [
	^ ZnMimePart fieldName: 'hash' value: userHash
]

{ #category : #'query-parts' }
CodeNameEntertainmentQueries >> userPart [
	^ ZnMimePart fieldName: 'user_id' value: user
]
