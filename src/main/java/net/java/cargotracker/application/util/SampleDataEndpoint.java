package net.java.cargotracker.application.util;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("/load-data")
@RequestScoped
public class SampleDataEndpoint {

    @Inject
    private SampleDataGenerator sampleDataGenerator;

    @GET
    public void loadSampleData() {
        sampleDataGenerator.loadSampleData();
    }
}
