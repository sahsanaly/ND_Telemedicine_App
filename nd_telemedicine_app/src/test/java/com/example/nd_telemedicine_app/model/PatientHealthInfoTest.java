package com.example.nd_telemedicine_app.model;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(classes = PatientHealthInfoTest.class)
class PatientHealthInfoTest {

    @Test
    void shouldSetReasonableHeight() {
        PatientHealthInfo phi = new PatientHealthInfo();
        phi.setHeight(170.3);
        Assertions.assertThat(phi.getHeight()).isGreaterThan(0);

    }

    @Test
    void ShouldSetReasonableReasonableWeight(){
        PatientHealthInfo phi = new PatientHealthInfo();
        phi.setWeight(90.3);
        Assertions.assertThat(phi.getWeight()).isBetween(3.6,400.0);
    }

    @Test
    void ShouldEnterValidHealthStatus(){
        PatientHealthInfo phi = new PatientHealthInfo();
        phi.setHealthStatus("Fine");
        Assertions.assertThat(phi.getHealthStatus()).isEqualTo("Fine");
    }


}