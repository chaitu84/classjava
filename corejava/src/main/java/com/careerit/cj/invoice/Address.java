package com.careerit.cj.invoice;

import lombok.Data;

@Data
public class Address {
    private String line1;
    private String city;
    private String state;
    private String country;
    private String pincode;
}
