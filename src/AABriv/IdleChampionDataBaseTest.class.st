Class {
	#name : #IdleChampionDataBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'db'
	],
	#category : #'AABriv-model'
}

{ #category : #running }
IdleChampionDataBaseTest >> setUp [
	super setUp.
	db := IdleChampionDataBase basicNew.
]

{ #category : #tests }
IdleChampionDataBaseTest >> testFillAdventures [
	db fillCampaigns.
	self assert: db campaigns size equals: 27.
]

{ #category : #tests }
IdleChampionDataBaseTest >> testFillAttacks [
	db fillAttacksFrom: (((KlehoQueries getAreasInformations) at: #data) at: #attacks).
	self assert: db attacks size equals: 12
]

{ #category : #tests }
IdleChampionDataBaseTest >> testFillBackgrounds [
	db fillBackgroundsFrom: (((KlehoQueries getAreasInformations) at: #data) at: #bgs).
	self assert: db backgrounds size equals: 91
]

{ #category : #tests }
IdleChampionDataBaseTest >> testFillMonsters [
	db fillMonstersFrom: (((KlehoQueries getAreasInformations) at: #data) at: #monsters).
	self assert: db monsters size equals: 263
]

{ #category : #tests }
IdleChampionDataBaseTest >> testFillQuests [
	db fillQuestsFrom: (((KlehoQueries getAreasInformations) at: #data) at: #quests).
	self assert: db quests size equals: 485
]
