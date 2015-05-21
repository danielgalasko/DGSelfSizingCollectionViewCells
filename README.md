DGSelfSizingCollectionViewCells
===============================

Simple implementation of self sizing `UICollectionViewCells` introduced in iOS 8. A picture says a thousand words

![screenshot](screenshot.png "Vibrant Seperators")

To have dynamic height cells all that is needed is to have our custom cells implement `preferredLayoutAttributesFittingAttributes:` and to set the estimatedItemSize property on `UICollectionViewFlowLayout`.

Be warned, if you are seeking to have your collection view look similar to `UITableView` you will need to do a lot more work. 
Currently the default behaviour for flow layout is to let cells expand in a horizontal direction first. 
This means if you want to fix the horizontal dimension you either need to force a width constraint on the cell [as seen here](http://stackoverflow.com/questions/28670951/uicollectionviewcell-systemlayoutsizefittingsize-returns-incorrect-width) or [here](http://stackoverflow.com/questions/26143591/specifying-one-dimension-of-cells-in-uicollectionview-using-auto-layout)