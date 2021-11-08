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

def getEC2Instance():
    '''
    get current instance pointer to ec2 instance. Return object
    '''
    ec2 = boto3.resource('ec2', region_name='us-east-1')
    return ec2.instances.filter(InstanceIds = str(getInstance_ID()))

@app.route("/")
def indexPage():
    '''
    Starting index page of the app. It just display a welcoming message
    '''
    return "This is the starting page of the simple App for Flugel.it test, This is running in EC2 instance with ID: " + str(getInstance_ID())

@app.route("/tags", endpoint="tags")
def showTags():
    '''
    It shows the Tags for EC2 instance and S3 Bucket
    '''
    # Connect to EC2
    instances=getEC2Instance()
    for instance in instances:
        return instance.tags

    return "instance.tags"

@app.route("/shutdown", endpoint="shutdown")
def shutDown():
    '''
    Shutdown instance.  Return None
    '''
    getEC2Instance().terminate() 
    return "shuting down EC2 instance"

if __name__=='__main__':
    app.run(host="0.0.0.0", port=4000)
