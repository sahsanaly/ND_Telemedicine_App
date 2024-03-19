package com.team12.booking.model;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.time.LocalTime;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class BookingTest {

    @Test
    @DisplayName("Test booking object initialisation with default constructor")
    void testBookingDefaultObjectCreation(){
//        Booking testBooking = new Booking();
//        LocalDate date = LocalDate.now();
//        LocalTime time = LocalTime.now();
//        Booking testBooking2 = new Booking(1, 1, 2,
//                date, time, "chat link", true, true);
//        assertNotEquals(testBooking, testBooking2);
    }

    @Test
    @DisplayName("Test booking object initialisation with non-default constructor")
    void testBookingNonDefaultObjectCreation(){
//        LocalDate date = LocalDate.now();
//        LocalTime time = LocalTime.now();
//        Booking testBooking = new Booking(1, 1, 2,
//                date, time, "chat link", true, true);
//        assertEquals(testBooking.getBookingId(), 1);
//        assertEquals(testBooking.getPatientId(), 1);
//        assertEquals(testBooking.getDoctorId(), 2);
//        assertEquals(testBooking.getBookingDate(), date);
//        assertEquals(testBooking.getBookingTime(), time);
//        assertEquals(testBooking.getChatLink(), "chat link");
//        assertTrue(testBooking.isHasPaid());
//        assertTrue(testBooking.isIsAvailability());
    }

    @Test
    @DisplayName("Test booking object initialisation returns the correct bookingId")
    void getBookingId() {
//        LocalDate date = LocalDate.now();
//        LocalTime time = LocalTime.now();
//        Integer bookingId = 1;
//        Booking testBooking = new Booking(1, 1, 2,
//                date, time, "chat link", true, true);
//        assertEquals(testBooking.getBookingId(), bookingId);
    }
}