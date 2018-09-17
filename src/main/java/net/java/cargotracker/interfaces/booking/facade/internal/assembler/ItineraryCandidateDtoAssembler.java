package net.java.cargotracker.interfaces.booking.facade.internal.assembler;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import net.java.cargotracker.domain.model.cargo.Itinerary;
import net.java.cargotracker.domain.model.cargo.Leg;
import net.java.cargotracker.domain.model.location.Location;
import net.java.cargotracker.domain.model.location.LocationRepository;
import net.java.cargotracker.domain.model.location.UnLocode;
import net.java.cargotracker.domain.model.voyage.Voyage;
import net.java.cargotracker.domain.model.voyage.VoyageNumber;
import net.java.cargotracker.domain.model.voyage.VoyageRepository;
import net.java.cargotracker.interfaces.booking.facade.dto.RouteCandidate;

public class ItineraryCandidateDtoAssembler {

    private static final DateTimeFormatter DATE_FORMAT
            = DateTimeFormatter.ofPattern("MM/dd/yyyy hh:mm a z");

    public RouteCandidate toDTO(Itinerary itinerary) {
        List<net.java.cargotracker.interfaces.booking.facade.dto.Leg> legDTOs = new ArrayList<>(
                itinerary.getLegs().size());
        for (Leg leg : itinerary.getLegs()) {
            legDTOs.add(toLegDTO(leg));
        }
        return new RouteCandidate(legDTOs);
    }

    protected net.java.cargotracker.interfaces.booking.facade.dto.Leg toLegDTO(
            Leg leg) {
        VoyageNumber voyageNumber = leg.getVoyage().getVoyageNumber();
        return new net.java.cargotracker.interfaces.booking.facade.dto.Leg(
                voyageNumber.getIdString(),
                leg.getLoadLocation().getUnLocode().getIdString(),
                leg.getLoadLocation().getName(),
                leg.getUnloadLocation().getUnLocode().getIdString(),
                leg.getUnloadLocation().getName(),
                leg.getLoadTime(),
                leg.getUnloadTime());
    }

    public Itinerary fromDTO(RouteCandidate routeCandidateDTO,
            VoyageRepository voyageRepository,
            LocationRepository locationRepository) {
        List<Leg> legs = new ArrayList<>(routeCandidateDTO.getLegs().size());

        for (net.java.cargotracker.interfaces.booking.facade.dto.Leg legDto
                : routeCandidateDTO.getLegs()) {
            VoyageNumber voyageNumber = new VoyageNumber(
                    legDto.getVoyageNumber());
            Voyage voyage = voyageRepository.find(voyageNumber);
            Location from = locationRepository.find(new UnLocode(legDto
                    .getFromUnLocode()));
            Location to = locationRepository.find(new UnLocode(legDto.getToUnLocode()));

            legs.add(new Leg(voyage, from, to,
                    LocalDate.parse(legDto.getLoadTime(), DATE_FORMAT),
                    LocalDate.parse(legDto.getUnloadTime(),
                            DATE_FORMAT)));
        }

        return new Itinerary(legs);
    }
}
