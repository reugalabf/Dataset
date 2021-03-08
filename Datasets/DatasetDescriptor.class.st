Class {
	#name : #DatasetDescriptor,
	#superclass : #Object,
	#instVars : [
		'columns'
	],
	#category : #'Datasets-Sources'
}

{ #category : #'as yet unclassified' }
DatasetDescriptor class >> fromAssociations: associations [
	^ self new
		setColumns: associations;
		yourself
]

{ #category : #'as yet unclassified' }
DatasetDescriptor class >> fullOpenWeatherMap [
	| instance |
	instance := self new.
	instance columns
		add: 'dt' -> #Integer;
		add: 'timestamp' -> #DateAndTime;
		add: 'timezone' -> #Integer;
		add: 'city' -> #String;
		add: 'latitude' -> #Float;
		add: 'longitude' -> #Float;
		add: 'temperature' -> #Float;
		add: 'feels_like' -> #Float;
		add: 'temp_min' -> #Float;
		add: 'temp_max' -> #Float;
		add: 'pressure' -> #Integer;
		add: 'sea_level' -> #Float;
		add: 'gnd_level' -> #Float;
		add: 'humidity' -> #Integer;
		add: 'wind_speed' -> #Float;
		add: 'wind_deg' -> #Float;
		add: 'rain_1h' -> #Float;
		add: 'rain_3h' -> #Float;
		add: 'snow_1h' -> #Float;
		add: 'snow_3h' -> #Float;
		add: 'clouds' -> #Integer;
		add: 'weather_id' -> #Integer;
		add: 'weather_main' -> #String;
		add: 'weather_description' -> #String;
		add: 'weather_icon' -> #String.
	^ instance
]

{ #category : #adding }
DatasetDescriptor >> addFieldsTo: aCSVReader [
	columns
		do: [ :each | aCSVReader perform: ('add' , each value asString , 'Field')asSymbol ]
]

{ #category : #splitjoin }
DatasetDescriptor >> canJoin: anotherDescriptor [
	^ (self columnNames asSet
		intersection: anotherDescriptor columnNames asSet) isEmpty
]

{ #category : #accessing }
DatasetDescriptor >> columnNames [
	^ columns collect: [ :each | each key ]
]

{ #category : #accessing }
DatasetDescriptor >> columns [
	^ columns
]

{ #category : #accessing }
DatasetDescriptor >> indexOfColumn: aString [
	^ columns
		detect: [ :each | each key = aString ]
		ifFound: [ :found | columns indexOf: found ]
		ifNone: [ self error: 'Descriptor column not found' ]
]

{ #category : #initialization }
DatasetDescriptor >> initialize [
	columns := OrderedCollection new
]

{ #category : #splitjoin }
DatasetDescriptor >> join: anotherDescriptor [
	^self class fromAssociations: columns, anotherDescriptor columns
]

{ #category : #initialization }
DatasetDescriptor >> setColumns: associations [
	columns isEmpty
		ifFalse: [ self error: 'Dataset Descriptor is not empty' ]
		ifTrue: [ columns addAll: associations ]
]

{ #category : #accessing }
DatasetDescriptor >> subDatasetDescriptorWithColumns: aCollection [
	| result |
	result := columns select: [ :each | aCollection includes: each key ].
	^ result size = aCollection size
		ifTrue: [ self class fromAssociations: result ]
		ifFalse: [ self error: 'Cannot create sub dataset' ]
]
