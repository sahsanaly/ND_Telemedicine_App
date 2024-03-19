package com.team12.booking.service;
import com.team12.booking.dao.BookingDAO;
import com.team12.booking.model.Booking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
public class BookingService {

    @Autowired
    BookingDAO bookingDao;



    final private LocalTime OPENING_HOURS = LocalTime.parse("08:59:59");
    final private LocalTime CLOSING_HOURS = LocalTime.parse("15:00:00");
    final private long APPOINTMENT_DURATION = 15;

    /**
     * Generates new booking and saves to database
     * manually increments primary key booking_id based on number of bookings in database.
     * @param booking
     * @return Booking object to confirm successful creation.
     */
    public List<Booking> createBooking(Booking booking) throws Exception {
        try {
            if (!availabilityIsNotDuplicate(booking.getBookingDate(), booking.getDoctorId()) ){
                    List<Booking> allBookings = createBookingsForDoctor(booking);
                    return allBookings;
            }
            return null;

        } catch (Exception e) {
            throw new Exception("Booking was not made successfully. Check booking_id");
        }
    }

//    public Availability createAvailability(Availability availability) throws Exception {
//        try {
//
//
//            return null;
//        } catch (Exception e){
//            throw new Exception("Availabilty was not made successfully. Check availability_id");
//        }
//    }

    /**
     * Find a single booking by primary key bookingId.
     * @param bookingId
     * @return
     * @throws NoSuchElementException
     */
    public Optional findBookingById(Integer bookingId) throws NoSuchElementException {
        try {
            return bookingDao.findById(bookingId);
        } catch (Exception e) {
            throw new NoSuchElementException("Booking ID not found");
        }
    }

    /**
     * Find all bookings for a particular patientId
     * @param patientId foreign key of patient (user) id
     * @return ArrayList of bookings
     * @throws NoSuchElementException
     */
    public List findBookingByPatientId(Integer patientId) throws NoSuchElementException {
        List<Booking> allBookings;
        List<Booking> patientBookings;
        try {
           allBookings = bookingDao.findAll();
           patientBookings = new ArrayList<>();
           for (int i = 0; i < allBookings.size(); i++){
               if (allBookings.get(i).getPatientId() == patientId){
                   patientBookings.add(allBookings.get(i));
               }
           }
        return patientBookings;

        } catch (Exception e){
            throw new NoSuchElementException("No bookings exist for this patient or patient doesn't exist. ");
        }
    }

    /**
     * Searches all bookings in database to find bookings associated with a doctor
     * @param doctorId Doctor's user id (primary key in user table)
     * @return List of all bookings associated with a particular doctor
     * @throws NoSuchElementException
     */
    public List findBookingByDoctorId(Integer doctorId) throws NoSuchElementException {
        List<Booking> allBookings;
        List<Booking> doctorBookings;
        try {
            allBookings = bookingDao.findAll();
            doctorBookings = new ArrayList<>();
            for (int i = 0; i < allBookings.size(); i++){
                if (allBookings.get(i).getDoctorId() == doctorId){
                    doctorBookings.add(allBookings.get(i));
                }
            }
            return doctorBookings;

        } catch (Exception e){
            throw new NoSuchElementException("No bookings exist for this patient or patient doesn't exist. ");
        }
    }

//    public List<Availability> getAllBookingsForDoctor(Integer doctorId){
//        List<Availability> allAvailabilities = availabilityDao.findAll();
//        List<Availability> availabilitiesForDoctorId = new ArrayList<>();
//
//        for (int i = 0; i < allAvailabilities.size(); i++) {
//            if (allAvailabilities.get(i).getDoctorId() == doctorId) {
//                availabilitiesForDoctorId.add(allAvailabilities.get(i));
//            }
//        }
//        return availabilitiesForDoctorId;
//    }

    /**
     * Verifies that availability is of exactly 15 minute duration.
     * @param startTime
     * @param endTime
     * @return Integer value representing the comparison of the start and endtimes. 0 = valid appointment duration
     */
    private int isWithinTimeLimit(LocalTime startTime, LocalTime endTime){
        LocalTime durationAppointment = endTime.minusMinutes(APPOINTMENT_DURATION);
        return (durationAppointment.compareTo(startTime));
    }

    private boolean availabilityIsNotDuplicate(LocalDate date, Integer doctorId){
        System.out.println("AVAILABILITY NOT DUPLICATE METHOD");
        List<Booking> allBookings = findBookingByDoctorId(doctorId);
        System.out.println("AFTER BOOKING LIST RETRIEVED");
        boolean isAlreadyEntered = false;
        for (int i = 0; i < allBookings.size(); i++){
            if ((allBookings.get(i).getBookingDate()).compareTo(date) == 0) {
                isAlreadyEntered = true;
            }
        }
        return isAlreadyEntered;
    }

    public List<Booking> getAllBookingsForDate(LocalDate bookingDate){
        List<Booking> allAvailabilities = bookingDao.findAll();
        List<Booking> bookingsForDate = new ArrayList<>();

        for (int i = 0; i < allAvailabilities.size(); i++) {
            if (allAvailabilities.get(i).getBookingDate().compareTo(bookingDate) == 0
                && allAvailabilities.get(i).isIsAvailability() == true) {
                System.out.println("Is Availability: " + allAvailabilities.get(i).isIsAvailability());
                bookingsForDate.add(allAvailabilities.get(i));

            }
        }
        return bookingsForDate;
    }

    public List<Booking> getAllAvailabilities(){
        LocalDate date = LocalDate.now();
        List<Booking> allAvailabilities = bookingDao.findAll();
        List<Booking> availabilities = new ArrayList<>();
        for (int i = 0; i < allAvailabilities.size(); i++){
            if (allAvailabilities.get(i).isIsAvailability() == true &&
                (allAvailabilities.get(i).getBookingDate().isAfter(date))){
                availabilities.add(allAvailabilities.get(i));
            }
        }
        return availabilities;
    }

    public List<Booking> deleteBookingByDoctorId(Integer doctorId) throws Exception {
        try{
            List<Booking> allBookings = bookingDao.findAll();
            List<Booking> doctorBookings = new ArrayList<>();
            for (int i=0; i < allBookings.size(); i++){
                if (allBookings.get(i).getDoctorId() == doctorId){
                    bookingDao.delete(allBookings.get(i));
                    doctorBookings.add(allBookings.get(i));
                }
            }
            return doctorBookings;
        } catch (Exception e) {
            throw new Exception("Cannot delete any booking from the doctor!");
        }
    }

    public Optional deleteBookingByBookingId(Integer bookingId) {
        Optional booking = bookingDao.findById(bookingId);
        bookingDao.deleteById(bookingId);
        return booking;
    }

    public void updateBooking(Booking booking){
        List<Booking> allBookings = bookingDao.findAll();
        for (int i = 0; i < allBookings.size(); i++){
            if (allBookings.get(i).getBookingId() == booking.getBookingId()){
                allBookings.get(i).setPatientId(booking.getPatientId());
                allBookings.get(i).setIsAvailability(false);
                bookingDao.save(allBookings.get(i));
            }
        }
    }

    public List<Booking> createBookingsForDoctor(Booking booking){
        List<Booking> allBookings = new ArrayList<>();
//            System.out.println("after list");
//
////            int numOfBookings = bookingDao.findAll().size();
//            for (int i = 0; i < 6; i++){
//                System.out.println("in loop" + i);
//                allBookings.add(new Booking());
//                System.out.println("after adding");
//                int numOfBookings = bookingDao.findAll().size();
//                allBookings.get(i).setBookingId(numOfBookings+1);
//                System.out.println("after setting" + allBookings.get(i).getBookingId());
////                bookingDao.save(allBookings.get(i));
////                System.out.println("after saving");
//            }
//            System.out.println(booking.getBookingId());

        Booking booking1 = new Booking();
        booking1.setDoctorId(booking.getDoctorId());
        booking1.setBookingDate(booking.getBookingDate());
        int numOfBookings = bookingDao.findAll().size();
        booking1.setBookingId(numOfBookings+1);
        booking1.setBookingTime(LocalTime.parse("09:00:00"));
        booking1.setBookingEndTime(LocalTime.parse("09:15:00"));
        bookingDao.save(booking1);
        allBookings.add(booking1);

        Booking booking2 = new Booking();
        booking2.setDoctorId(booking.getDoctorId());
        booking2.setBookingDate(booking.getBookingDate());
        booking2.setBookingId(numOfBookings+2);
        booking2.setBookingTime(LocalTime.parse("10:00:00"));
        booking2.setBookingEndTime(LocalTime.parse("10:15:00"));
        bookingDao.save(booking2);
        allBookings.add(booking2);

        Booking booking3 = new Booking();
        booking3.setDoctorId(booking.getDoctorId());
        booking3.setBookingDate(booking.getBookingDate());
        booking3.setBookingId(numOfBookings+3);
        booking3.setBookingTime(LocalTime.parse("11:00:00"));
        booking3.setBookingEndTime(LocalTime.parse("11:15:00"));
        bookingDao.save(booking3);
        allBookings.add(booking3);

        Booking booking4 = new Booking();
        booking4.setDoctorId(booking.getDoctorId());
        booking4.setBookingDate(booking.getBookingDate());
        booking4.setBookingId(numOfBookings+4);
        booking4.setBookingTime(LocalTime.parse("12:00:00"));
        booking4.setBookingEndTime(LocalTime.parse("12:15:00"));
        bookingDao.save(booking4);
        allBookings.add(booking4);

        Booking booking5 = new Booking();
        booking5.setDoctorId(booking.getDoctorId());
        booking5.setBookingDate(booking.getBookingDate());
        booking5.setBookingId(numOfBookings+5);
        booking5.setBookingTime(LocalTime.parse("13:00:00"));
        booking5.setBookingEndTime(LocalTime.parse("13:15:00"));
        bookingDao.save(booking5);
        allBookings.add(booking5);

        Booking booking6 = new Booking();
        booking6.setDoctorId(booking.getDoctorId());
        booking6.setBookingDate(booking.getBookingDate());
        booking6.setBookingId(numOfBookings+6);
        booking6.setBookingTime(LocalTime.parse("14:00:00"));
        booking6.setBookingEndTime(LocalTime.parse("14:15:00"));
        bookingDao.save(booking6);
        allBookings.add(booking6);

        return allBookings;
    }

}
