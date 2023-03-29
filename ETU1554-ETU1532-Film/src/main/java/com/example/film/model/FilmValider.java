package com.example.film.model;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Time;

@Entity
public class FilmValider {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "idfilm")
    private Film film = null;

    @ManyToOne
    @JoinColumn(name = "idscene")
    private Scene scene = null;

    @Column(name = "daty")
    private Date daty;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Film getFilm() {
        return film;
    }

    public void setFilm(Film film) {
        this.film = film;
    }

    public Scene getScene() {
        return scene;
    }

    public void setScene(Scene scene) {
        this.scene = scene;
    }

    public Date getDaty() {
        return daty;
    }
}
