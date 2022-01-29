Class {
	#name : #KlehoQueriesTest,
	#superclass : #TestCase,
	#instVars : [
		'db'
	],
	#category : #'AABriv-model'
}

{ #category : #running }
KlehoQueriesTest >> testGetAdventures [
	"Relies on internet and kleho's website"
	| adventureJSON |
	adventureJSON := KlehoQueries getAdventuresFor: 1.
	self halt.
	self assert: (adventureJSON at: #error) equals: 0
]

{ #category : #running }
KlehoQueriesTest >> testGetAreas [
	"Relies on internet and kleho's website"
	| campainJson |
	campainJson := KlehoQueries getAreasInformations.
	self halt.
	self assert: (campainJson at: #error) equals: 0
]

{ #category : #running }
KlehoQueriesTest >> testGetCampaigns [
	"Relies on internet and kleho's website"
	| campainJson |
	campainJson := KlehoQueries getCampaignsJSON.
	self assert: (campainJson at: #error) equals: 0
]
