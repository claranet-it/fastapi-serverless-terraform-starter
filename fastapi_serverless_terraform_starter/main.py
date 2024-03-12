from fastapi import FastAPI

from fastapi_serverless_terraform_starter.routers import health

app = FastAPI()


app.include_router(health.router)
