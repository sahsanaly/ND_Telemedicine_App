package com.example.nd_telemedicine_app.model;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;

class SignInTest {

    @Test
    public void testCreationSignInObject(){
        SignIn signin = new SignIn("username", "password");

        Assertions.assertThat(signin.getEmail()).isEqualTo("username");
        Assertions.assertThat(signin.getPassword()).isEqualTo("password");
    }

    @Test
    public void testEmailIsString(){
        SignIn signin = new SignIn("username", "password");

        Assertions.assertThat(signin.getEmail()).asString();
    }

    @Test
    public void testPasswordIsString(){
        SignIn signin = new SignIn("username", "password");

        Assertions.assertThat(signin.getPassword()).asString();
    }
}