package com.example.nd_telemedicine_app.model;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(classes = UserTest.class)
class UserTest {

    @Test
    void ShouldEnterValidFirstName(){
        User user = new User();
        user.setFirstName("Abdulrahman");
        Assertions.assertThat(user.getFirstName()).doesNotContain("@","%");
    }

    @Test
    void ShouldEnterValidEmail(){
        User user = new User();
        user.setEmail("Abdul@Alanazi.com");
        Assertions.assertThat(user.getEmail()).contains("@");
    }

    @Test
    void ShouldEnterValidPasswordLength(){
        User user = new User();
        user.setPassword("12345abcd");
        Assertions.assertThat(user.getPassword().length()).isGreaterThanOrEqualTo(8);

    }

    @Test
    void ShouldEnterValidPhoneNumber(){
        User user = new User();
        //my number
        user.setPhoneNum("0433851537");
        Assertions.assertThat(user.getPhoneNum().length()).isEqualTo(10);
    }

}