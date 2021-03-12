Class {
	#name : #DatasetDescriptorTest,
	#superclass : #TestCase,
	#category : #'Datasets-Tests'
}

{ #category : #running }
DatasetDescriptorTest >> descriptorTest [
	| descriptor |
	descriptor := DatasetDescriptor new.
	descriptor columns
		add: 'dt' -> #Integer;
		add: 'timestamp' -> #String;
		add: 'timezone' -> #Integer.
	^ descriptor
]

{ #category : #tests }
DatasetDescriptorTest >> testSubDescritor [
	self
		assert:
			(self descriptorTest
				subDatasetDescriptorWithColumns: (Array with: 'dt')) columns  size
				= 1
]

{ #category : #tests }
DatasetDescriptorTest >> testTwoSubDescritor [
	self
		assert:
			(self descriptorTest
				subDatasetDescriptorWithColumns: (Array with: 'dt' with:'timezone')) columns  size
				= 2
]
