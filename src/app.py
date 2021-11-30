import boto3
import urllib.request
from flask import Flask


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
    return boto3.resource('ec2', region_name = 'us-east-1')


@app.route("/")
def indexPage():
    '''
    Starting index page of the app. It just display a welcoming message
    '''
    return "This is the starting page of the simple App for Flugel.it test"


@app.route("/tags", endpoint = "tags")
def showTags():
    '''
    It shows the Tags for EC2 instance and S3 Bucket. Return dict() of tags
    '''
    # Connect to EC2
    ec2 = getEC2Instance()
    ec2instance = ec2.Instance(str(getInstance_ID()))
    instance_tags = {}

    for tags in ec2instance.tags:
        instance_tags[tags["Key"]] = tags["Value"]

    return instance_tags


@app.route("/shutdown", endpoint = "shutdown")
def shutDown():
    '''
    Shutdown instance.  Return String:  message confirmation
    '''
    ec2 = getEC2Instance()
    ec2.instances.filter(InstanceIds = [str(getInstance_ID())]).terminate()
    return "shuting down EC2 instance"


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=4000)
