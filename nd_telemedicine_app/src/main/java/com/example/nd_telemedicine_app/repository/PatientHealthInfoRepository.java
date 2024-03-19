package com.example.nd_telemedicine_app.repository;

import com.example.nd_telemedicine_app.model.PatientHealthInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PatientHealthInfoRepository extends JpaRepository<PatientHealthInfo, Integer> {

}
