##python test file for flask to test locallu
import requests as r
import pandas as pd
import json

base_url = 'http://127.0.0.1:5000/' #base url local host

#predictions dictionary
json_data = {'Gender': 'Male',
           'Married': 'Yes',
           'Dependents': 2,
           'Self_Employed': 'Yes',
           'LoanAmount': 100.0,
           'Loan_Amount_Term': 360.0,
           'Credit_History' : 1.0,
           'TotalIncome': 30000.0}


#get response
#response = r.get(base_url+'welcome')
#one observation
response = r.post(base_url+'predict', json=json_data)

#if multiple
#test = pd.read_csv("test.csv", index_col=0)
#test = test.to_json(orient='records') #reorientates
#test = json.loads(test)
#response = r.post(base_url +'predict', json = test)

#Test repsonse

if response.status_code == 200:
    print('Request Successful')
    print('...')
    print(response.json())

else:
    print('Request Failed')