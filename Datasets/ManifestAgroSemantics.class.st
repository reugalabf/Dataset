"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAgroSemantics,
	#superclass : #PackageManifest,
	#category : #'Datasets-Manifest'
}

{ #category : #'code-critics' }
ManifestAgroSemantics class >> ruleRBCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DatasetDescriptor class' #fullOpenWeatherMap #true)) #'2020-05-26T15:56:22.867324-03:00') )
]
