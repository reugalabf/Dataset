Class {
	#name : #DatasetConsitencyRule,
	#superclass : #Object,
	#category : #'Datasets-Sources'
}

{ #category : #'as yet unclassified' }
DatasetConsitencyRule >> checkConsitencyFor: aValue [
	^ self subclassResponsibility
]
