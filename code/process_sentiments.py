import pandas as pd 

df = pd.read_csv('~/Desktop/epinions3.csv')

def_neg = df[df['class'] == 'Neg']
def_pos = df[df['class'] == 'Pos']  

for row in range(def_neg.shape[0]):
    def_neg.iloc[row].to_csv(f'~/Desktop/train/negative/negative{row}.csv', index = False)

for row in range(def_pos.shape[0]):
    def_pos.iloc[row].to_csv(f'~/Desktop/train/positive/positive{row}.csv', index = False)