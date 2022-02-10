Class {
	#name : #CodeNameEntertainmentQueries,
	#superclass : #IdleChampionQueries,
	#instVars : [
		'userHash',
		'user'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #url }
CodeNameEntertainmentQueries class >> baseUrl [
	^ 'http://ps7.idlechampions.com/~idledragons/post.php?call='
]

{ #category : #url }
CodeNameEntertainmentQueries class >> forUser: aUser andHash: aHash [
	^ self new
		user: aUser;
		userHash: aHash;
		yourself
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

{ #category : #'rest-support' }
CodeNameEntertainmentQueries >> jsonFrom: response [
	^ self class jsonFrom: response

]

{ #category : #'rest-support' }
CodeNameEntertainmentQueries >> newQuery [
	^ self class newQuery
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
