Class {
	#name : #DatasetConsitencyRule,
	#superclass : #Object,
	#category : #'Datasets-Core'
}

{ #category : #'as yet unclassified' }
DatasetConsitencyRule >> checkConsitencyFor: aValue [
	^ self subclassResponsibility
]
