import pytest
from starlette.testclient import TestClient

from fastapi_serverless_terraform_starter.main import app


@pytest.fixture(scope="function")
def client():
    with TestClient(app) as c:
        yield c
