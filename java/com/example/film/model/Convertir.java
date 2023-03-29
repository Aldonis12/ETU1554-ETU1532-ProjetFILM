package com.example.film.model;

import javax.persistence.AttributeConverter;
import java.sql.Date;

public class Convertir implements AttributeConverter<String , Date> {
    @Override
    public Date convertToDatabaseColumn(String s) {
        return Date.valueOf(s);
    }

    @Override
    public String convertToEntityAttribute(Date date) {
        return null;
    }
}
