package net.java.cargotracker.application.util;

import javax.ws.rs.ApplicationPath;
import net.java.cargotracker.interfaces.booking.rest.CargoMonitoringService;
import net.java.cargotracker.interfaces.handling.rest.HandlingReportService;
import net.java.pathfinder.api.GraphTraversalService;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.ServerProperties;

/**
 * JAX-RS configuration.
 */
@ApplicationPath("rest")
public class RestConfiguration extends ResourceConfig {

    public RestConfiguration() {
        // Resources
        packages(new String[]{
            HandlingReportService.class.getPackage().getName(),
            GraphTraversalService.class.getPackage().getName(),
            CargoMonitoringService.class.getPackage().getName(),
            SampleDataEndpoint.class.getPackage().getName()});
        // Enable Bean Validation error messages.
        property(ServerProperties.BV_SEND_ERROR_IN_RESPONSE, true);
    }
}
