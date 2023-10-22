### Dataset

https://boston.lti.cs.cmu.edu/classes/95-865-K/HW/HW3/

### Steps

1. Create the app
2. Download Dataset
   1. One Way
      1. Data Analysis using pandas
      2. Train Using Create ML
   2. Another Way
      1. Train Using Playgrounds
3. Integrate Model into App

### Conda Commands

```shell
conda env list
conda active YourEnv

```

### Python Code with Panda

```python
import pandas as pd

df = pd.read_csv('~/Desktop/epinions3.csv')

def_neg = df[df['class'] == 'Neg']
def_pos = df[df['class'] == 'Pos']

for row in range(def_neg.shape[0]):
    def_neg.iloc[row].to_csv(f'~/Desktop/train/negative/negative{row}.csv', index = False)

for row in range(def_pos.shape[0]):
    def_pos.iloc[row].to_csv(f'~/Desktop/train/positive/positive{row}.csv', index = False)
```

Then, you will see created folder /train

- /train/negative
- /train/positive

put it into `CreateML` and create `.mlmodel`

### Using Only Playground

- Create `Mac` Playground
- Prepare your data set

```swift
import Cocoa
import CreateML
import Foundation

let filePath = "/Users/paigeshin/Desktop/playground/sentimental_analysis/epinions3.csv"
let outputFileName = "/Users/paigeshin/Desktop/playground/sentimental_analysis/SentimentAnalysisClassiferModel.mlmodel"

let dataURL = URL(fileURLWithPath: filePath)
let data = try MLDataTable(contentsOf: dataURL)

let (trainingData,testingData) = data.randomSplit(by: 0.8)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let metadata = MLModelMetadata(author: "Paige Shin", shortDescription: "Sentiment Analysis Model", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: outputFileName), metadata: metadata)


```

### Swift

```swift
    private var model: SentimentAnalysisClassiferModel? {
        try? SentimentAnalysisClassiferModel(configuration: MLModelConfiguration())
    }
    
    // perform sentiment analysis
    DispatchQueue.global().async {
        guard
            let output = try? self.model?.prediction(text: self.text)
        else { return }
        self.isPositive = output.label == "Pos"
    }
```
