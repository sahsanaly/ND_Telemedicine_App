package com.team12.booking.dao;

import com.team12.booking.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BookingDAO extends JpaRepository<Booking, Integer> {


}
