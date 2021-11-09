import os
import urllib.request
import pathlib
from pathlib import Path
import json

def getOutputPath():
    '''
    Get path to output.json file generated when terraform runs. This file saves the Ip address of the EC2 instance.
    return string
    '''
    return os.path.join(pathlib.Path(__file__).parent.resolve(), 'output.json')


def getUrl():
    '''
    Reads output file and return http address with ip found in the file.
    Return string
    '''
    file_path = getOutputPath()
    with open(file_path) as outputfile:
        output_file = json.load(outputfile)
    return 'http://' + output_file['ec2_ip']['value'] + ':4000'


def test_indexPage():
    '''
    Test index page of Flask app
    '''
    url = getUrl()
    print(url)
    response = urllib.request.urlopen(url).read().decode() 
    
    assert response == 'This is the starting page of the simple App for Flugel.it test'


def test_showTags():
    '''
    Test /tags endpoint 
    '''
    url = getUrl() + '/tags'
    response = urllib.request.urlopen(url).read()
    response = json.loads(response.decode('utf-8'))

    assert response['Name'] == "Flugel"
    assert response ['Owner'] == "InfraTeam"


def test_shutDown():
    '''
    Test /shutdown endpoint 
    '''
    url = getUrl() + '/shutdown'
    response = urllib.request.urlopen(url).read().decode()

    assert response == "shuting down EC2 instance"