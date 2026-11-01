import pytest
from app.app import create_app


@pytest.fixture
def client():
    app = create_app()
    app.testing = True
    with app.test_client() as c:
        yield c


def test_root_returns_42(client):
    r = client.get("/")
    assert r.status_code == 200
    assert r.get_data(as_text=True) == "42\n"


def test_post_is_rejected(client):
    r = client.post("/")
    assert r.status_code == 405
    assert "GET" in r.headers["Allow"]


def test_unknown_path_is_404(client):
    assert client.get("/does-not-exist").status_code == 404


def test_health_endpoints(client):
    assert client.get("/healthz").status_code == 200
    assert client.get("/readyz").status_code == 200
