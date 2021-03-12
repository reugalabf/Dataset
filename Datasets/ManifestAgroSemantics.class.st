"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAgroSemantics,
	#superclass : #PackageManifest,
	#category : #'Datasets-Manifest'
}

{ #category : #'code-critics' }
ManifestAgroSemantics class >> ruleRBCodeCruftLeftInMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DatasetRow #join:descriptor: #false)) #'2020-05-29T10:40:40.269735-03:00') )
]

{ #category : #'code-critics' }
ManifestAgroSemantics class >> ruleRBCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DatasetDescriptor class' #fullOpenWeatherMap #true)) #'2020-05-26T15:56:22.867324-03:00') )
]

{ #category : #'code-critics' }
ManifestAgroSemantics class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DatasetRow #join:descriptor: #false)) #'2020-05-29T10:40:43.347454-03:00') )
]

{ #category : #'code-critics' }
ManifestAgroSemantics class >> ruleRBToDoRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DatasetRow #join:descriptor: #false)) #'2020-05-29T10:40:37.386454-03:00') #(#(#RGMethodDefinition #(#DatasetRow #initializeWithData:withDescriptor: #false)) #'2021-03-08T10:41:38.461754-03:00') )
]
