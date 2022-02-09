Class {
	#name : #IdleChampionDataBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'db'
	],
	#category : #'AABriv-tests'
}

{ #category : #running }
IdleChampionDataBaseTest >> setUp [
	super setUp.
	db := IdleChampionDataBase basicNew.
]

{ #category : #tests }
IdleChampionDataBaseTest >> testFillAttacks [
	"currently queried via monsters"
	db fillMonsters.
	self assert: db attacks size equals: 111
]

{ #category : #tests }
IdleChampionDataBaseTest >> testFillBackgrounds [
	db fillBackgrounds.
	self assert: db backgrounds size equals: ((KlehoQueries getBackgrounds at: #data) at: #_count)
]

{ #category : #tests }
IdleChampionDataBaseTest >> testFillCampaign [
	db fillCampaigns.
	self assert: db campaigns size equals: ((KlehoQueries getCampaigns at: #data) at: #_count).
]

{ #category : #tests }
IdleChampionDataBaseTest >> testFillMonsters [
	db fillMonsters.
	self assert: db monsters size equals: ((KlehoQueries getMonsters anyOne at: #data) at: #_count)
]

{ #category : #tests }
IdleChampionDataBaseTest >> testFillQuests [
	db fillQuests.
	self assert: db quests size equals: ((KlehoQueries getQuests anyOne at: #data) at: #_count)
]
