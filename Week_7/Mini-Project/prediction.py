# libraries
from flask import Flask
from flask_restful import Api, Resource
import numpy as np
import pickle
import pandas as pd
from flask import request, jsonify

#create api definition
app = Flask(__name__)
api = Api(app)

#define UDFs
def object_to_num(df):
    df['Dependents'] = df['Dependents'].replace('3+', float(3))
    df = df.astype({'Dependents': 'float64'})
    return df

def to_dataframe(x):
    columns = ['Gender', 'Married', 'Dependents','Self_Employed',
       'LoanAmount', 'Loan_Amount_Term', 'Credit_History', 'TotalIncome']
    return pd.DataFrame(x, columns=columns)

def to_log(df):
    columns = ['LoanAmount', 'TotalIncome']
    for x in columns:
        df[x] = df[x].apply(lambda x: np.log(x))
    df = df.drop(columns, axis=1)
    return df

#define UFD class
class objectTransformer:
    
    def __init__(self, func):
        self.func = func
        
    def fit(self, X, y=None, **fit_params):
        return self
    
    def transform(self, X, **fit_params):
        return self.func(X)

#import models
with open('classifier.pickle', 'rb') as f:
    classifier = pickle.load(f)

#Define API resources

class welcome(Resource):
    def get(self):
        return "Welcome! You can use this Flask to Predict Loan Acceptance!"

class predict(Resource):
    def post(self):
        json_data = request.get_json() #expect json file
        # For 1 observation
        #index is on keys
        df = pd.DataFrame(json_data.values(), 
                            index = json_data.keys()).transpose()

       #sending in a dataframe and mulitple records
        #df = pd.DataFrame(json_data)

        result = classifier.predict(df)

        return result.tolist() #back to json format

#assign endpoints
api.add_resource(welcome, '/welcome')
api.add_resource(predict, '/predict')

#Run the app and API
if __name__ == "__main__":
    app.run(debug=True, host = 'ec2-35-174-113-161.compute-1.amazonaws.com', port = 5000)
