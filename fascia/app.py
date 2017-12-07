import uuid

from tornado import web
import sprockets.http

from handlers.health_check import HealthCheckHandler

re_uuid = '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'


def make_app(**settings):
    return web.Application([
        (r"/health/", HealthCheckHandler),
    ], **settings)

def run():
    sprockets.http.run(make_app)

if __name__ == "__main__":
    run()
