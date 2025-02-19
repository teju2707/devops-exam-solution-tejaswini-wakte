import zipfile

def create_zip():
    with zipfile.ZipFile('lambda_function_payload.zip', 'w') as zipf:
        zipf.write('lambda_function.py')

if __name__ == "__main__":
    create_zip()
