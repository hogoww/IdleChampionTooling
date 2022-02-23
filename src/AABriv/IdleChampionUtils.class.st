Class {
	#name : #IdleChampionUtils,
	#superclass : #Object,
	#category : #'AABriv-tools'
}

{ #category : #code }
IdleChampionUtils class >> extractCodesFrom: aString [
	| res |
	res := aString lines
		select: [ :l | l first = $[ ]
		thenCollect: [ :l | 
			| line |
				  line := l last: l size - (l indexOf: $:).
				  line last: line size - (line indexOf: $:) ].
	^ String streamContents: [:s | res do: [ :i | s << i ] separatedBy: [ s cr ] ].
]

{ #category : #code }
IdleChampionUtils class >> redeemCodesForAllUsers: codes [
	^ IdleChampionUser registeredUsers collect: [ :anUser | 
		anUser -> (anUser redeemAllCodesFrom: codes) ]
]

{ #category : #hogoww }
IdleChampionUtils class >> updateAllUsers [
	^ IdleChampionUser registeredUsers do: [ :ru | ru update ].
]
