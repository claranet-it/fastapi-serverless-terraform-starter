from mangum import Mangum

from fastapi_serverless_terraform_starter.main import app

handler = Mangum(app)
