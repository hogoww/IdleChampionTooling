Class {
	#name : #IdleChampionUtils,
	#superclass : #Object,
	#category : #'AABriv-tools'
}

{ #category : #code }
IdleChampionUtils class >> database [
	^ IdleChampionDataBase cachedDatabase
]

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

{ #category : #hogoww }
IdleChampionUtils class >> heroesList [
	"For generation purpose and stuff"
	"Last updated with Desmond"
	^ 'Aila
Alyndra
Artemis
Avren
Baeloth
Barrowin
Beadle & Grimm
Binwin
Birdsong
Black Viper
Brig
Briv
Catti-brie
Corazón
D''hani
Deekin
Desmond
Dhadius
Donaar
Ellywick
Evelyn
Ezmerelda
Farideh
Freely
Gromma
Havilar
Hew Maan
Ishi
Jaheira
Jim
K''thriss
Korth
Krond
Krull
Krydle
Lazaapz
Lucius
Mehen
Melf
Môrgæn
Nerys
Nova
Nrakk
Omin
Orisha
Orkira
Paultin
Penelope
Prudence
Pwent
Qillek
Regis
Rosie
Rust
Selise
Sentry
Sgt. Knox
Shaka
Shandie
Sisaspia
Spurt
Stoki
Strix
Talin
Torogar
Turiel
Vi
Viconia
Vlahnya
Walnut
Warden
Widdle
Wulfgar
Xander
Yorven
Zorbu'
]

{ #category : #hogoww }
IdleChampionUtils class >> heroesListCleanedUp [
	"For generation purpose and stuff, with only ascii characters and Pharo style formating"
	"Last updated with Desmond"
	^ 'Aila
Alyndra
Artemis
Avren
Baeloth
Barrowin
BeadleAndGrimm
Binwin
Birdsong
BlackViper
Brig
Briv
CattiBrie
Corazon
Deekin
Desmond
Dhadius
Dhani
Donaar
Ellywick
Evelyn
Ezmerelda
Farideh
Freely
Gromma
Havilar
HewMaan
Ishi
Jaheira
Jim
Korth
Krond
Krull
Krydle
Kthriss
Lazaapz
Lucius
Mehen
Melf
Morgaen
Nerys
Nova
Nrakk
Omin
Orisha
Orkira
Paultin
Penelope
Prudence
Pwent
Qillek
Regis
Rosie
Rust
Selise
Sentry
SgtKnox
Shaka
Shandie
Sisaspia
Spurt
Stoki
Strix
Talin
Torogar
Turiel
Vi
Viconia
Vlahnya
Walnut
Warden
Widdle
Wulfgar
Xander
Yorven
Zorbu'
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
