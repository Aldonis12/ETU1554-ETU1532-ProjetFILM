package com.example.film.model;

import com.example.film.dao.HibernateDAO;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Tournage{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtournage", nullable = false)
    private int id;
    @ManyToOne
    @JoinColumn(name = "idfilm")
    private Film film;
    @Column(name = "tournage")
    private String tournage;

    @Column(name="date")
    private Timestamp date;

    public void plannificationPlateau(LocalDate debut , LocalDate fin, Plateau plateau, ArrayList<Plateau> listPlateau, ArrayList<Plateau> GetPlateau, List<Scene> scene){
        if(plateau != null){
            debut = plateau.planeListScenne(debut,fin,scene);
            GetPlateau.add(plateau);
            this.plannificationPlateau(debut,fin,this.PlateauProche(plateau,listPlateau,GetPlateau),listPlateau,GetPlateau,scene);
        }
    }

    public Plateau PlateauProche(Plateau plateau,ArrayList<Plateau> listPlateau,ArrayList<Plateau> GetPlateau){
        int i = 0, g = 0;
        Plateau p = null;
        for(i = 0 ; i < listPlateau.size() ; i++){
            if(Tournage.isExiste(listPlateau.get(i),GetPlateau) == false){
                p = listPlateau.get(i);
                g = i;
                break;
            }
        }
        if(p != null){
            for(i = 0 ; i < listPlateau.size() ; i++){
                if(Tournage.isExiste(listPlateau.get(i),GetPlateau) == false  && Tournage.calculDistance(p,plateau) > Tournage.calculDistance(plateau,listPlateau.get(i))){
                    p = listPlateau.get(i);
                }
            }
        }

        return p;
    }

    public static double calculDistance(Plateau p , Plateau p2){
        return Math.sqrt((p.getX() - p2.getX()) * (p.getX() - p2.getX()) - (p.getY() - p2.getY()) * (p.getY() - p2.getY()) );
    }

    public static Plateau maxScene(ArrayList<Plateau> list,ArrayList<Plateau> stock){
        int i = 0,g=0;
        Plateau p = null;
        for(i = 0 ; i < list.size() ; i++){
            if(Tournage.isExiste(list.get(i),stock) == false){
                p = list.get(i);
                g = i;
                break;
            }
        }
        if(p != null){
            for(i = g ; i < list.size() ; i++){
                if(p.getListScene().size() < list.get(i).getListScene().size()){
                    p = list.get(i);
                }
            }
        }
        return p;
    }

    public static boolean isExiste(Plateau p,ArrayList<Plateau> list){
        int i = 0;
        boolean is = false;
        for(i = 0 ; i < list.size() ; i++){
            if(list.get(i).getId() == p.getId()){
                is = true;
                break;
            }
        }
        return is;
    }

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


    public Timestamp getDate() {
        return date;
    }
    public void setDate(Timestamp date) {
        this.date = date;
    }
}