import boto3
import urllib.request
from flask import Flask
from collections import defaultdict


app = Flask(__name__)

def getInstance_ID():
    '''
    The current instance ID. Return string with Id
    '''
  
    return urllib.request.urlopen('http://169.254.169.254/latest/meta-data/instance-id').read().decode()       

@app.route("/")
def indexPage():
    '''
    Starting index page of the app. It just display a welcoming message
    '''
    return "This is the starting page of the simple App for Flugel.it test" + str(getInstance_ID)

@app.route("/tags", endpoint="tags")
def showTags():
    '''
    It shows the Tags for EC2 instance and S3 Bucket
    '''
    # Connect to EC2
    ec2 = boto3.resource('ec2')

    # Get information for all running instances
    running_instances = ec2.instances.filter(Filters=[{
        'Name': 'instance-state-name',
        'Values': ['running']}])

    ec2info = defaultdict()
    print(running_instances)
    for instance in running_instances:
        for tag in instance.tags:
            if 'Name'in tag['Key']:
                print(tag)
    list_g={'ec2':'hi', 's3':'you'}
    return list_g

@app.route("/shutdown", endpoint="shutdown")
def showTags():
    '''
    nothing here
    '''
    return "shuting down"

if __name__=='__main__':
    app.run(host="0.0.0.0", port=4000)
