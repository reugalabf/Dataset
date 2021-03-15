Class {
	#name : #DatasetTest,
	#superclass : #TestCase,
	#instVars : [
		'dataset',
		'dataset2',
		'dataset3'
	],
	#category : #'Datasets-Tests'
}

{ #category : #running }
DatasetTest >> datasetTest [
	^ '123,05-08-1969,7890
124,05-09-1969,7891'
]

{ #category : #running }
DatasetTest >> datasetTest2 [
	^ '123,05-08-1969,6543
124,05-09-1969,4321'
]

{ #category : #running }
DatasetTest >> datasetTest3 [
	^ '123,,6543
124,05-09-1969,'
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
DatasetTest >> descriptorTest2 [
	| descriptor |
	descriptor := DatasetDescriptor new.
	descriptor columns
		add: 'dt' -> #Integer;
		add: 'timestamp2' -> #String;
		add: 'timezone2' -> #Integer.
	^ descriptor
]

{ #category : #running }
DatasetTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	dataset := Dataset
		on: self datasetTest readStream
		descriptor: self descriptorTest.
	dataset2 := Dataset
		on: self datasetTest2 readStream
		descriptor: self descriptorTest2.
	dataset3 := Dataset
		on: self datasetTest3 readStream
		descriptor: self descriptorTest2
]

{ #category : #tests }
DatasetTest >> testDatasetInstanceCreation [
	self assert: dataset columns size = 3.
	self assert: dataset rows size = 2.
	self assert: (dataset exportCSV = 
'123,''05-08-1969'',7890
124,''05-09-1969'',7891
')
]

{ #category : #tests }
DatasetTest >> testDatasetInstanceCreationWithNullValues [
	self assert: dataset3 columns size = 3.
	self assert: dataset3 rows size = 2
]

{ #category : #tests }
DatasetTest >> testJoin [
	| joinDataset |
	joinDataset := dataset join: dataset2.
	self assert: joinDataset columns size equals: 6.
	self assert: joinDataset rows size equals: 2.
	self assert: joinDataset rows first data size equals: 6.
	self
		assert: joinDataset exportCSV
		equals:
			'123,''05-08-1969'',7890,123,''05-08-1969'',6543
124,''05-09-1969'',7891,124,''05-09-1969'',4321
'.
	self
		assert: (dataset rows first valueAtName: (dataset descriptor columnAt: 1) key)
		equals:
			(joinDataset rows first valueAtName: (dataset descriptor columnAt: 1) key)
]

{ #category : #tests }
DatasetTest >> testJoinWithThreeColumns [
	| joinDataset |
	joinDataset := dataset join: dataset2 matchColumns: {1.2.3 }.
	self assert: joinDataset columns size equals: 6.
	self assert: joinDataset rows size equals: 0.
"	self assert: joinDataset rows first data size equals: 6.
	self
		assert: joinDataset exportCSV
		equals:
			'123,''05-08-1969'',7890,123,''05-08-1969'',6543
124,''05-09-1969'',7891,124,''05-09-1969'',4321
'.
	self
		assert: (dataset rows first valueAtName: (dataset descriptor columnAt: 1) key)
		equals:
			(joinDataset rows first valueAtName: (dataset descriptor columnAt: 1) key)"
]

{ #category : #tests }
DatasetTest >> testJoinWithTwoColumns [
	| joinDataset |
	joinDataset := dataset join: dataset2 matchColumns: {1 .2 }.
	self assert: joinDataset columns size equals: 6.
	self assert: joinDataset rows size equals: 2.
	self assert: joinDataset rows first data size equals: 6.
	self
		assert: joinDataset exportCSV
		equals:
			'123,''05-08-1969'',7890,123,''05-08-1969'',6543
124,''05-09-1969'',7891,124,''05-09-1969'',4321
'.
	self
		assert: (dataset rows first valueAtName: (dataset descriptor columnAt: 1) key)
		equals:
			(joinDataset rows first valueAtName: (dataset descriptor columnAt: 1) key)
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
