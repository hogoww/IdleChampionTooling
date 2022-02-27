Class {
	#name : #IdleChampionChestIDs,
	#superclass : #SharedPool,
	#classVars : [
		'AilaGoldID',
		'AilaSilverID',
		'AlyndraGoldID',
		'AlyndraSilverID',
		'ArtemisGoldID',
		'ArtemisSilverID',
		'AvrenGoldID',
		'AvrenSilverID',
		'BaelothGoldID',
		'BaelothSilverID',
		'BarrowinGoldID',
		'BarrowinSilverID',
		'BeadleAndGrimmGoldID',
		'BeadleAndGrimmSilverID',
		'BinwinGoldID',
		'BinwinSilverID',
		'BirdsongGoldID',
		'BirdsongSilverID',
		'BlackViperGoldID',
		'BlackViperSilverID',
		'BrigGoldID',
		'BrigSilverID',
		'BrivGoldID',
		'BrivSilverID',
		'CattiBrieGoldID',
		'CattiBrieSilverID',
		'CorazonGoldID',
		'CorazonSilverID',
		'DeekinGoldID',
		'DeekinSilverID',
		'DesmondGoldID',
		'DesmondSilverID',
		'DhadiusGoldID',
		'DhadiusSilverID',
		'DhaniGoldID',
		'DhaniSilverID',
		'DonaarGoldID',
		'DonaarSilverID',
		'ElectrumID',
		'EllywickGoldID',
		'EllywickSilverID',
		'EvelynGoldID',
		'EvelynSilverID',
		'EzmereldaGoldID',
		'EzmereldaSilverID',
		'FaridehGoldID',
		'FaridehSilverID',
		'FreelyGoldID',
		'FreelySilverID',
		'GoldElvenChestID',
		'GoldGoldPieceID',
		'GoldID',
		'GrommaGoldID',
		'GrommaSilverID',
		'HavilarGoldID',
		'HavilarSilverID',
		'HewMaanGoldID',
		'HewMaanSilverID',
		'HewMannGoldID',
		'HewMannSilverID',
		'IshiGoldID',
		'IshiSilverID',
		'JaheiraGoldID',
		'JaheiraSilverID',
		'JimGoldID',
		'JimSilverID',
		'KorthGoldID',
		'KorthSilverID',
		'KrondGoldID',
		'KrondSilverID',
		'KrullGoldID',
		'KrullSilverID',
		'KrydleGoldID',
		'KrydleSilverID',
		'KthrissGoldID',
		'KthrissSilverID',
		'LazaapzGoldID',
		'LazaapzSilverID',
		'LuciusGoldID',
		'LuciusSilverID',
		'MehenGoldID',
		'MehenSilverID',
		'MelfGoldID',
		'MelfSilverID',
		'MorgaenGoldID',
		'MorgaenSilverID',
		'NerysGoldID',
		'NerysSilverID',
		'NovaGoldID',
		'NovaSilverID',
		'NrakkGoldID',
		'NrakkSilverID',
		'OminGoldID',
		'OminSilverID',
		'OrishaGoldID',
		'OrishaSilverID',
		'OrkiraGoldID',
		'OrkiraSilverID',
		'PaultinGoldID',
		'PaultinSilverID',
		'PenelopeGoldID',
		'PenelopeSilverID',
		'PrudenceGoldID',
		'PrudenceSilverID',
		'PwentGoldID',
		'PwentSilverID',
		'QillekGoldID',
		'QillekSilverID',
		'RegisGoldID',
		'RegisSilverID',
		'RosieGoldID',
		'RosieSilverID',
		'RustGoldID',
		'RustSilverID',
		'SeliseGoldID',
		'SeliseSilverID',
		'SentryGoldID',
		'SentrySilverID',
		'SgtKnoxGoldID',
		'SgtKnoxSilverID',
		'ShakaGoldID',
		'ShakaSilverID',
		'ShandieGoldID',
		'ShandieSilverID',
		'SilverID',
		'SisaspiaGoldID',
		'SisaspiaSilverID',
		'SpurtGoldID',
		'SpurtSilverID',
		'StokiGoldID',
		'StokiSilverID',
		'StrixGoldID',
		'StrixSilverID',
		'TalinGoldID',
		'TalinSilverID',
		'TorogarGoldID',
		'TorogarSilverID',
		'TurielGoldID',
		'TurielSilverID',
		'ViGoldID',
		'ViSilverID',
		'ViconiaGoldID',
		'ViconiaSilverID',
		'VlahnyaGoldID',
		'VlahnyaSilverID',
		'WalnutGoldID',
		'WalnutSilverID',
		'WardenGoldID',
		'WardenSilverID',
		'WiddleGoldID',
		'WiddleSilverID',
		'WulfgarGoldID',
		'WulfgarSilverID',
		'XanderGoldID',
		'XanderSilverID',
		'YorvenGoldID',
		'YorvenSilverID',
		'ZorbuGoldID',
		'ZorbuSilverID'
	],
	#category : #'AABriv-constants'
}

{ #category : #generation }
IdleChampionChestIDs class >> generateChampionChestsIds [
	<script>
	"Allow to complete the existing shared variables for champion chests that were not set.
	Their IDs still have to be set by hand however"
	| championChestIDs classVariableNames championChestIDsToAdd |
	championChestIDs := String streamContents: [ :s |
		IdleChampionUtils heroesListCleanedUp lines do: [ :aHero |
			s << aHero << 'SilverID' << Character cr.
			s << aHero << 'GoldID' << Character cr ]].
	classVariableNames := self classVariables collect:[ :aClassVariable | aClassVariable name ].
	championChestIDsToAdd := championChestIDs lines reject: [ :aChampChestID | classVariableNames includes: aChampChestID ].
	championChestIDsToAdd do: [ :aChampChestID | self addClassVarNamed: aChampChestID ].
	
]

{ #category : #'class initialization' }
IdleChampionChestIDs class >> initialize [
	"Common chests"
	SilverID := '1'.
	GoldID := '2'. 
	ElectrumID := '282'.

	"Champion chests" 
	ArtemisSilverID := '166'.
	ArtemisGoldID := '167'.
	HewMannSilverID := '256'.
	HewMannGoldID := '257'.
	OrishaSilverID := '258'.
	OrishaGoldID := '259'.
	
	"Weekend chests"
	GoldElvenChestID := '392'."392 & 393 might be inverted"
	GoldGoldPieceID := '393'.
]

{ #category : #'class initialization' }
IdleChampionChestIDs class >> initializeChampionChests [
	
	TurielSilverID := '107'.
	TurielGoldID := '108'.
	PwentSilverID := '158'.
	PwentGoldID := '159'.
	AvrenSilverID := '160'.
	AvrenGoldID := '161'.
	SentrySilverID := '162'.
	SentryGoldID := '163'.
	KrullSilverID := '164'.
	KrullGoldID := '165'.
	ArtemisSilverID := '166'.
	ArtemisGoldID := '167'.
	MorgaenSilverID := '168'.
	MorgaenGoldID := '169'.
	HavilarSilverID := '170'.
	HavilarGoldID := '171'.
	SisaspiaSilverID := '172'.
	SisaspiaGoldID := '173'.
	BrivSilverID := '174'.
	BrivGoldID := '175'.
	MelfSilverID := '176'.
	MelfGoldID := '177'.
	KrydleSilverID := '178'.
	KrydleGoldID := '179'.
	JaheiraSilverID := '180'.
	JaheiraGoldID := '181'. 
	NovaSilverID := '182'.
	NovaGoldID := '183'.
	FreelySilverID := '184'.
	FreelyGoldID := '185'.
	BeadleAndGrimmSilverID := '186'.
	BeadleAndGrimmGoldID := '187'.
	OminSilverID := '188'.
	OminGoldID := '189'.
	LazaapzSilverID := '190'.
	LazaapzGoldID := '191'.
	
	TorogarSilverID := '244'.
	TorogarGoldID := '245'.
	EzmereldaSilverID := '246'.
	EzmereldaGoldID := '247'.
	PenelopeSilverID := '248'.
	PenelopeGoldID := '249'.
	LuciusSilverID := '250'.
	LuciusGoldID := '251'.
	BaelothSilverID := '252'.
	BaelothGoldID := '253'.
	TalinSilverID := '254'.
	TalinGoldID := '255'.
	HewMannSilverID := '256'.
	HewMannGoldID := '257'.
	OrishaSilverID := '258'.
	OrishaGoldID := '259'.
	AlyndraSilverID := '260'.
	AlyndraGoldID := '261'.
	OrkiraSilverID := '262'.
	OrkiraGoldID := '263'.
	ShakaSilverID := '264'.
	ShakaGoldID := '265'.
	MehenSilverID := '266'.
	MehenGoldID := '267'.
	SeliseSilverID := '268'.
	SeliseGoldID := '269'.
	SgtKnoxSilverID := '270'.
	SgtKnoxGoldID := '271'.
	EllywickSilverID := '272'.
	EllywickGoldID := '273'.
	PrudenceSilverID := '274'.
	PrudenceGoldID := '275'.
	CorazonSilverID := '276'.
	CorazonGoldID := '277'.
	
]

{ #category : #initialization }
IdleChampionChestIDs class >> nameForID: anID [
	self classPool associationsDo: [ :assoc | assoc value = anID ifTrue: [ ^ assoc key ] ].
	^ anID
]

{ #category : #initialization }
IdleChampionChestIDs class >> priceForChest: anID [
	"Does not take into account the kind of currency currently"
	anID = SilverID ifTrue: [ ^ 50 ].
	anID = GoldID ifTrue: [ ^ 500 ].
	self flag: #todo.
	^ self error
	
]
