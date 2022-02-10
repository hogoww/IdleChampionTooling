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
CodeNameEntertainmentQueries >> redeemCode: aCode [
	| response |
"	 ""mobile_client_version=999"""
	response := self newQuery
		url: self redeemUrl asUrl;
		addPart: 	(ZnMimePart fieldName: 'language_id' value: '1');
		addPart: 	(ZnMimePart fieldName: 'timestamp' value: '0');
		addPart: 	(ZnMimePart fieldName: 'request_id' value: '0');
		addPart: 	(ZnMimePart fieldName: 'network_id' value: '11');
		addPart: 	(ZnMimePart fieldName: 'mobile_client_version' value: '999');
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
