Class {
	#name : #DatasetDescriptorTest,
	#superclass : #TestCase,
	#category : #'Datasets-Sources-Test'
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
				subDatasetDescriptorWithColumns: (Array with: 'dt'))  size
				= 1
]
