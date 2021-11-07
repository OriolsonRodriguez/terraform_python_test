from flask import Flask

app = Flask(__name__)


@app.route("/")
def indexPage():
    '''
    Starting index page of the app. It just display a welcoming message
    '''
    return "This is the starting page of the simple App for Flugel.it test"

@app.route("/tags", endpoint="tags")
def showTags():
    '''
    It shows the Tags for EC2 instance and S3 Bucket
    '''
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
