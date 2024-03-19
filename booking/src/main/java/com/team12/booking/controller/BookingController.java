package com.team12.booking.controller;

import com.team12.booking.model.Booking;
import com.team12.booking.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(path="/booking")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    /**
     * Retrieve a particular booking from database
     * @param bookingId Primary key identifier of booking
     * @return Booking object if a match is found with
     * @throws Exception
     */
    @GetMapping(path="/{bookingId}", produces = "application/json")
    public ResponseEntity<Object> getBookingById(@PathVariable("bookingId") Integer bookingId)
            throws Exception {
        Optional booking = bookingService.findBookingById(bookingId);
        if (booking == null){
            throw new Exception("Booking not found");
        } else
            return new ResponseEntity<>(booking, HttpStatus.OK);
    }

    /**
     * Find all bookings for a particular patient ID
     * @param patientId Integer value of patient's userId
     * @return List of all bookings associated with patientID
     * @throws Exception
     */
    @GetMapping(path="/patient{patientId}", produces = "application/json")
    public ResponseEntity<Object> getBookingByPatientId(@PathVariable("patientId") Integer patientId)
        throws Exception {
        List<Booking> bookingList = bookingService.findBookingByPatientId(patientId);
        if (bookingList.size() > 0) {
            return  new ResponseEntity<>(bookingList, HttpStatus.OK);
        } else  {
            throw new Exception("Could not find bookings for patient");
        }
    }

    /**
     * Find all bookings for a particular doctor id
     * @param doctorId Integer value of doctor's userId
     * @return List of all bookings associated with a particular doctor id
     * @throws Exception
     */
    @GetMapping(path="/doctor{doctorId}", produces = "application/json")
    public ResponseEntity<Object> getBookingByDoctorId(@PathVariable("doctorId") Integer doctorId)
            throws Exception {
        List<Booking> bookingList = bookingService.findBookingByDoctorId(doctorId);
        if (bookingList.size() > 0) {
            return  new ResponseEntity<>(bookingList, HttpStatus.OK);
        } else  {
            throw new Exception("Could not find bookings for doctor");
        }
    }

    /**
     * Create new booking in the database. Booking ID is added internally.
     * @param booking - booking object as json
     * @return booking object as created in database.
     * @throws Exception
     */
    @PostMapping(path = "/new", consumes = "application/json", produces = "application/json")
    public ResponseEntity<Object> makeBooking(@RequestBody Booking booking)
            throws Exception {
        List<Booking> createdService = bookingService.createBooking(booking);
        if (createdService == null){
            return new ResponseEntity<>("Bookings already created!", HttpStatus.OK);
        }
        return new ResponseEntity<>(createdService, HttpStatus.CREATED);
    }

    // UPDATE booking --> patient's name, change isAvailability to false.

    @GetMapping(path="/date{bookingDate}", produces = "application/json")
    public ResponseEntity<Object> getBookingsByDate(@PathVariable("bookingDate")
                                                          @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate bookingDate)
            throws Exception {
        List<Booking> bookingList = bookingService.getAllBookingsForDate(bookingDate);
        if (bookingList.size() > 0) {
            return  new ResponseEntity<>(bookingList, HttpStatus.OK);
        } else  {
            return new ResponseEntity<>("No bookings found", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping(path="/", produces = "application/json")
    public ResponseEntity<Object> getAllAvailabilities()
            throws Exception {
        List<Booking> availabilityList = bookingService.getAllAvailabilities();
        if (availabilityList.size() > 0) {
            return  new ResponseEntity<>(availabilityList, HttpStatus.OK);
        } else  {
            return new ResponseEntity<>("No availabilities found", HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping(path="/doctor{doctorId}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<Object> deleteBookingByDoctorId(@PathVariable("doctorId") Integer doctorId)
            throws Exception {
        List<Booking> bookingList = bookingService.deleteBookingByDoctorId(doctorId);
        if (bookingList.size() > 0) {
            return  new ResponseEntity<>(bookingList, HttpStatus.OK);
        } else  {
            throw new Exception("Cannot delete bookings for the doctor. No booking exists.");
        }
    }

    @DeleteMapping(path="/booking{bookingId}",produces = "application/json")
    public ResponseEntity<Object> deleteBookingByBookingId(@PathVariable("bookingId") Integer bookingId)
            throws Exception{
        Optional booking = bookingService.deleteBookingByBookingId(bookingId);
        if (booking != null) {
            return new ResponseEntity<>("Booking successfully deleted!", HttpStatus.OK);
        }else{
            throw new Exception("No booking found!");
        }
    }

    @PutMapping(path = "/update", consumes = "application/json", produces = "application/json")
    public ResponseEntity<Object> updateBooking(@RequestBody Booking booking)
            throws Exception {
//        System.out.println("Inside the update booking function");
//        System.out.println(booking.getBookingId());
        bookingService.updateBooking(booking);
        return new ResponseEntity<>("Updated booking", HttpStatus.CREATED);
    }

}
