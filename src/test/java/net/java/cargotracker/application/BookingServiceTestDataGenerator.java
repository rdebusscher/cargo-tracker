package net.java.cargotracker.application;

import net.java.cargotracker.domain.model.cargo.Cargo;
import net.java.cargotracker.domain.model.location.SampleLocations;
import net.java.cargotracker.domain.model.voyage.SampleVoyages;

import javax.annotation.PostConstruct;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;
import java.util.logging.Logger;

/**
 * Loads sample data for demo.
 */
//@Singleton
//@Startup
// In comments so that at deploymznt time the database isn't populated which is not Production style.
public class BookingServiceTestDataGenerator {
    
    private static final Logger logger = Logger
            .getLogger(BookingServiceTestDataGenerator.class.getName());
    @PersistenceContext
    private EntityManager entityManager;

    @PostConstruct
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void loadSampleData() {
        logger.info("Loading sample data.");
        unLoadAll(); // Fail-safe in case of application restart that does not
        // trigger a JPA schema drop.
        loadSampleLocations();
        loadSampleVoyages();
        // loadSampleCargos();
    }

    private void unLoadAll() {
        logger.info("Unloading all existing data.");
		// In order to remove handling events, must remove references in cargo.
        // Dropping cargo first won't work since handling events have references
        // to it.
        // TODO See if there is a better way to do this.
        List<Cargo> cargos = entityManager.createQuery("Select c from Cargo c",
                Cargo.class).getResultList();
        for (Cargo cargo : cargos) {
            cargo.getDelivery().setLastEvent(null);
            entityManager.merge(cargo);
        }

		// Delete all entities
        // TODO See why cascade delete is not working.
        entityManager.createQuery("Delete from HandlingEvent").executeUpdate();
        entityManager.createQuery("Delete from Leg").executeUpdate();
        entityManager.createQuery("Delete from Cargo").executeUpdate();
        entityManager.createQuery("Delete from CarrierMovement")
                .executeUpdate();
        entityManager.createQuery("Delete from Voyage").executeUpdate();
        entityManager.createQuery("Delete from Location").executeUpdate();
    }

    private void loadSampleLocations() {
        logger.info("Loading sample locations.");

        entityManager.persist(SampleLocations.HONGKONG);
        entityManager.persist(SampleLocations.MELBOURNE);
        entityManager.persist(SampleLocations.STOCKHOLM);
        entityManager.persist(SampleLocations.HELSINKI);
        entityManager.persist(SampleLocations.CHICAGO);
        entityManager.persist(SampleLocations.TOKYO);
        entityManager.persist(SampleLocations.HAMBURG);
        entityManager.persist(SampleLocations.SHANGHAI);
        entityManager.persist(SampleLocations.ROTTERDAM);
        entityManager.persist(SampleLocations.GOTHENBURG);
        entityManager.persist(SampleLocations.HANGZOU);
        entityManager.persist(SampleLocations.NEWYORK);
        entityManager.persist(SampleLocations.DALLAS);
    }

    private void loadSampleVoyages() {
        logger.info("Loading sample voyages.");

        entityManager.persist(SampleVoyages.HONGKONG_TO_NEW_YORK);
        entityManager.persist(SampleVoyages.NEW_YORK_TO_DALLAS);
        entityManager.persist(SampleVoyages.DALLAS_TO_HELSINKI);
        entityManager.persist(SampleVoyages.HELSINKI_TO_HONGKONG);
        entityManager.persist(SampleVoyages.DALLAS_TO_HELSINKI_ALT);
    }
}
