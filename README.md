DGSelfSizingCollectionViewCells
===============================

Simple implementation of self sizing UICollectionViewCells introduced in iOS 8. 

To have dynamic height cells all that is needed is to have our custom cells implement preferredLayoutAttributesFittingAttributes: and to set the estimatedItemSize property on UICollectionViewFlowLayout.
