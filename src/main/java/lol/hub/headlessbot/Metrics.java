package lol.hub.headlessbot;

import io.prometheus.metrics.core.metrics.Counter;
import io.prometheus.metrics.exporter.httpserver.HTTPServer;
import io.prometheus.metrics.instrumentation.jvm.JvmMetrics;

import java.io.IOException;

public class Metrics {

    public static final Counter deaths = Counter.builder()
        .name("deaths")
        .help("Total deaths.")
        .register();

    static void init() {
        JvmMetrics.builder().register();
        try {
            HTTPServer server = HTTPServer.builder()
                .port(8080)
                .buildAndStart();
            Runtime.getRuntime().addShutdownHook(new Thread(server::stop));
            Log.info("Metrics available at: http://localhost:" + server.getPort() + "/metrics");
        } catch (IOException ex) {
            // rethrow this wrapped as IllegalStateException
            // to make the game or some mod-loader handle it
            throw new IllegalStateException(ex.getMessage());
        }
    }
}
