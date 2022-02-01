Class {
	#name : #AreaTest,
	#superclass : #TestCase,
	#instVars : [
		'area'
	],
	#category : #'AABriv-tests'
}

{ #category : #running }
AreaTest >> setUp [
	area := AbstractArea new.
]

{ #category : #test }
AreaTest >> testContainsArmoredEnemyDoesNotHaveArmored [
	area addEnemy: AbstractMonster new.
	self deny: area hasArmorBased 
]

{ #category : #test }
AreaTest >> testContainsArmoredEnemyDoesNotHaveHitBased [
	area addEnemy: AbstractMonster new.
	self deny: area hasHitBased
]

{ #category : #test }
AreaTest >> testContainsArmoredEnemyHasArmored [
	area addEnemy: AbstractMonster new beArmored.
	self assert: area hasArmorBased 
]

{ #category : #test }
AreaTest >> testContainsArmoredEnemyHasHitBased [
	area addEnemy: AbstractMonster new beHitBased.
	self assert: area hasHitBased 
]

{ #category : #test }
AreaTest >> testOutdoorIsOutdoor [
	area type: Outdoor new.
	self assert: area isOutdoor
]

{ #category : #test }
AreaTest >> testUndergroundIsNotOutdoor [
	area type: Underground new.
	self deny: area isOutdoor
]
