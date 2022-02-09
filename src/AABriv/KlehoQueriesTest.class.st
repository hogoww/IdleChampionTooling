Class {
	#name : #KlehoQueriesTest,
	#superclass : #TestCase,
	#instVars : [
		'db'
	],
	#category : #'AABriv-tests'
}

{ #category : #running }
KlehoQueriesTest >> testGetAdventures [
	"Relies on internet and kleho's website"
	| adventureJSON |
	adventureJSON := KlehoQueries getAdventuresFor: 1.
	self assert: (adventureJSON at: #error) equals: 0
]

{ #category : #running }
KlehoQueriesTest >> testGetBackgrounds [
	"Relies on internet and kleho's website"
	| backgroundJsons |
	backgroundJsons := KlehoQueries getQuests.
	self assert: backgroundJsons size equals: 2.
	backgroundJsons do: [ :aQuery | self assert: (aQuery at: #error) equals: 0 ]
]

{ #category : #running }
KlehoQueriesTest >> testGetCampaigns [
	"Relies on internet and kleho's website"
	| campainJson |
	campainJson := KlehoQueries getCampaigns.
	self assert: (campainJson at: #error) equals: 0
]

{ #category : #running }
KlehoQueriesTest >> testGetMonsters [
	"Relies on internet and kleho's website"
	| monsters |
	monsters := KlehoQueries getMonsters.
	self assert: monsters size equals: 2.
	monsters do: [ :aQuery | self assert: (aQuery at: #error) equals: 0 ]
]

{ #category : #running }
KlehoQueriesTest >> testGetQuests [
	"Relies on internet and kleho's website"
	| questsJsons |
	questsJsons := KlehoQueries getQuests.
	self assert: questsJsons size equals: 7.
	questsJsons do: [ :aQuery | self assert: (aQuery at: #error) equals: 0 ]
]
