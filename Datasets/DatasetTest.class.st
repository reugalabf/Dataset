Class {
	#name : #DatasetTest,
	#superclass : #TestCase,
	#instVars : [
		'dataset'
	],
	#category : #'Datasets-Sources-Test'
}

{ #category : #running }
DatasetTest >> datasetTest [
	^ '123,05-08-1969,7890
124,05-09-1969,7891'
]

{ #category : #running }
DatasetTest >> descriptorTest [
	| descriptor |
	descriptor := DatasetDescriptor new.
	descriptor columns
		add: 'dt' -> #Integer;
		add: 'timestamp' -> #String;
		add: 'timezone' -> #Integer.
	^ descriptor
]

{ #category : #running }
DatasetTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	dataset := Dataset
		on: self datasetTest readStream
		descriptor: self descriptorTest
]

{ #category : #tests }
DatasetTest >> testDatasetInstanceCreation [
	self assert: dataset columns size = 3.
	self assert: dataset rows size = 2
]

{ #category : #tests }
DatasetTest >> testSubDatasetCreation [
	| subDataset |
	subDataset := dataset subDatasetWithColumns: (Array with: 'dt').
	self assert: subDataset columns size = 1.
	self assert: subDataset rows size = 2
]

{ #category : #tests }
DatasetTest >> testSubDatasetCreation2 [
	| subDataset |
	subDataset := dataset subDatasetWithColumns: (Array with: 'dt' with:'timestamp').
	self assert: subDataset columns size = 2.
	self assert: subDataset rows size = 2
]
