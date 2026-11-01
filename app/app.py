"""TRDL: The Responding Dark Laughter. Returns 42 on GET /."""
from flask import Flask, Response, jsonify


def create_app() -> Flask:
    app = Flask(__name__)

    @app.route("/", methods=["GET"])
    def answer():
        return Response("42\n", status=200, mimetype="text/plain")

    @app.route("/healthz", methods=["GET"])
    def liveness():
        return jsonify(status="ok"), 200

    @app.route("/readyz", methods=["GET"])
    def readiness():
        return jsonify(status="ready"), 200

    @app.errorhandler(404)
    def not_found(_):
        return Response("not found\n", status=404, mimetype="text/plain")

    @app.errorhandler(405)
    def method_not_allowed(_):
        return Response("method not allowed\n", status=405,
                        mimetype="text/plain", headers={"Allow": "GET, HEAD"})

    return app
