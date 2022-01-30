Class {
	#name : #Story,
	#superclass : #Object,
	#category : #'AABriv-model'
}

{ #category : #initializing }
Story >> resolveLinksWith: aDatabase [
	self flag: #todo
]
