import json

from sprockets.mixins.postgresql import AsyncHandlerMixin
from tornado import gen, web


class HealthCheckHandler(AsyncHandlerMixin, web.RequestHandler):

    DBNAME = 'ahmes'

    @gen.coroutine
    def get(self):
        result = yield self.ahmes_session.query("SELECT 1")
        result.free()
        self.finish(json.dumps({'success': True}))
