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
	super setUp.
	area := Area new.
]

{ #category : #tests }
AreaTest >> testAreaWithArmorHasArmored [
	area monsters: { Monster new tags: #(armor_based); yourself }.
	self assert: area hasArmorBased
]

{ #category : #tests }
AreaTest >> testAreaWithHitBasedHasHitBased [
	area monsters: { Monster new tags: #(hits_based); yourself }.
	self assert: area hasHitBased
]

{ #category : #tests }
AreaTest >> testAreaWithoutArmorHasNoArmor [
	area monsters: { Monster new tags: #(); yourself }.
	self deny: area hasArmorBased
]

{ #category : #tests }
AreaTest >> testAreaWithoutHitBasedHasNotHitBased [
	area monsters: { Monster new tags: #(); yourself }.
	self deny: area hasHitBased
]
