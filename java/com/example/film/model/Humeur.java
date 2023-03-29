package com.example.film.model;

import javax.persistence.*;

@Entity
public class Humeur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idHumeur", nullable = false)
    int idHumeur;

    @Column(name = "humeur")
    String humeur;

    public int getIdHumeur() {
        return idHumeur;
    }

    public void setIdHumeur(int idHumeur) {
        this.idHumeur = idHumeur;
    }

    public String getHumeur() {
        return humeur;
    }

    public void setHumeur(String humeur) {
        this.humeur = humeur;
    }
}
