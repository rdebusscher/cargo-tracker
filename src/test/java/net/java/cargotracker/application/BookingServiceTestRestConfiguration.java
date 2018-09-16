package net.java.cargotracker.application;

import javax.ws.rs.ApplicationPath;
import net.java.pathfinder.api.GraphTraversalService;
import org.glassfish.jersey.server.ResourceConfig;

/**
 * JAX-RS configuration.
 */
@ApplicationPath("rest")
public class BookingServiceTestRestConfiguration extends ResourceConfig {

    public BookingServiceTestRestConfiguration() {
        // Resources
        packages(new String[]{GraphTraversalService.class.getPackage().getName()});
    }
}
