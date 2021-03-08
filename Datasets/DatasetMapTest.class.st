Class {
	#name : #DatasetMapTest,
	#superclass : #TestCase,
	#instVars : [
		'dataset'
	],
	#category : #'Datasets-Sources-Test'
}

{ #category : #running }
DatasetMapTest >> datasetTest [
	^ '1,20,33
2,20.5,32
3,20.9,32.5
4,21,33
5,21.4,33.1
6,20.9,
7,21,33
8,21,'
]

{ #category : #running }
DatasetMapTest >> descriptorTest [
	| descriptor |
	descriptor := DatasetDescriptor new.
	descriptor columns
		add: 'idx' -> #Integer;
		add: 'open_weather' -> #Float;
		add: 'flaresense' -> #Float.
	^ descriptor
]

{ #category : #running }
DatasetMapTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	dataset := Dataset
		on: self datasetTest readStream
		descriptor: self descriptorTest.
]

{ #category : #tests }
DatasetMapTest >> testDatasetMapCreation [
	| map |
	map := DataMapping
		from: dataset
		keyColumn: 'open_weather'
		valueColumn: 'flaresense'.
	self assert: map numberOfRows = 3.
	self assert: (map valuesAt: 21) size = 3
]

{ #category : #tests }
DatasetMapTest >> testDatasetWightedAverageMap [

	| map w_map |
	map := DataMapping
		from: dataset
		keyColumn: 'open_weather'
		valueColumn: 'flaresense'.
	w_map := map asWeightedAverageMap .
	
	self assert: w_map numberOfRows = 3.
	self assert: (w_map valuesAt: 21) closeTo: 33.033
]
