import groovy.json.JsonOutput

import static spark.Spark.*

class Bootstrap {

    static void main(String[] args) {

        def environment = System.getProperty('environment') ?: 'dev'

        staticFileLocation('/public')
        staticFiles.expireTime(10)
        port(9000)

        before "*", { req, res ->
            res.header("Access-Control-Allow-Headers", "Authorization, Content-Type");
            res.header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
            res.header("Access-Control-Allow-Origin", "*");
        }

        options "*/*", { req, res ->

        }

        get "/", { req, res ->
            return JsonOutput.toJson([ok: true, now: new Date()])
        }

    }

}