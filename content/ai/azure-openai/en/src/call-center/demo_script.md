Prerequisites

1) Speech Services Cog Svc
2) Blob Storage
3) Audio Files
4) Developer environment

### Install Speech Services Batch API
How to use the Speech Services Batch Transcription API from Python
Download and install the API client library
To execute the sample you need to generate the Python library for the REST API which is generated through Swagger.
Follow these steps for the installation:
	1. Go to https://editor.swagger.io.
	2. Click File, then click Import URL.
	3. Enter the Swagger URL for the Speech Services API: https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/specification/cognitiveservices/data-plane/Speech/SpeechToText/stable/v3.1/speechtotext.json.
	4. Click Generate Client and select Python.
	5. Save the client library.
	6. Extract the downloaded python-client-generated.zip somewhere in your file system.
	7. Install the extracted python-client module in your Python environment using pip: pip install path/to/package/python-client.
The installed package has the name swagger_client. You can check that the installation worked using the command python -c "import swagger_client".

Download [sample code](https://raw.githubusercontent.com/Azure-Samples/cognitive-services-speech-sdk/master/samples/batch/python/python-client/main.py) and save it in the project folder.



