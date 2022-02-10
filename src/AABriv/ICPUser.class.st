Class {
	#name : #ICPUser,
	#superclass : #Object,
	#instVars : [
		'user',
		'userHash',
		'name'
	],
	#classInstVars : [
		'RegisteredUser'
	],
	#category : #'AABriv-webQuery'
}

{ #category : #initializing }
ICPUser class >> initialize [
	self resetRegisteredUsers
]

{ #category : #'instance creation' }
ICPUser class >> new [
	| newObject |
	newObject := super new.
	RegisteredUser add: newObject.
	^ newObject 
]

{ #category : #registerUsers }
ICPUser class >> registeredUsers [
	^ RegisteredUser
]

{ #category : #registerUsers }
ICPUser class >> resetRegisteredUsers [
	RegisteredUser := OrderedCollection new 
]

{ #category : #registerUsers }
ICPUser class >> userNamed: aName [
	^ RegisteredUser detect: [ :anICPUser | anICPUser name = aName ]
]

{ #category : #accessing }
ICPUser >> asCNEQ [
	^ CodeNameEntertainmentQueries forICPUser: self
]

{ #category : #accessing }
ICPUser >> name [

	^ name
]

{ #category : #accessing }
ICPUser >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ICPUser >> user [

	^ user
]

{ #category : #accessing }
ICPUser >> user: anObject [

	user := anObject
]

{ #category : #accessing }
ICPUser >> userHash [

	^ userHash
]

{ #category : #accessing }
ICPUser >> userHash: anObject [

	userHash := anObject
]
