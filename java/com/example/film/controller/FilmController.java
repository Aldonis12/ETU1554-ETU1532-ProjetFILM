package com.example.film.controller;

import com.example.film.dao.HibernateDAO;
import com.example.film.model.*;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.view.RedirectView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;


@Controller
public class FilmController
{
    @Autowired
    HibernateDAO dao;

    //////////////////////////////////////////////////////

    //Film
    @GetMapping("AddFilm")
    private String AjouterFilm(Model model)
    {
        return "AjoutFilm";
    }

    @PostMapping("NouveauFilm")
    private Object NouveauFilm(@ModelAttribute Film film, @RequestParam CommonsMultipartFile file, Model model, HttpSession session) throws IOException
    {
        String path = session.getServletContext().getRealPath("/images");
        String fileName = Upload.uploadImage(path,file);
        film.setImage(fileName);
        dao.create(film);
        return new RedirectView("AddFilm");
    }

    @GetMapping("/pagination")
    public String listeFilm(@RequestParam(value="numero") int numero,Model model){
        model.addAttribute("liste",dao.pagination(numero,8));
        return "ListeFilm";
    }


    // Scène planifié par film
    @GetMapping("/ScenePlanifie")
    public String listeScenePlanifier(@RequestParam("id") int id,Model model){
        String sql = " select * from FilmValider where idfilm="+id+" order by daty";
        model.addAttribute("liste",dao.findQuery(FilmValider.class,sql));
        return "ListeScenePlanifie";
    }


    /////////////////////////////////////////////////////////

    // Scene

    @GetMapping("ListScene")
    private String ListSceneParFilm(@RequestParam int id,@RequestParam int div,Model model,HttpServletRequest request)
    {
        model.addAttribute("plateau",dao.findAll(Plateau.class));
        model.addAttribute("scene",dao.findQuery(Scene.class,"select * from scene where idfilm="+id));
        request.setAttribute("id",id);
        request.setAttribute("div",div);
        return "Scene";
    }

    //Scene
    @PostMapping("/NouveauScene")
    private Object NouveauScene(@ModelAttribute Scene scene, HttpServletRequest request)
    {
        Integer idfilm = Integer.valueOf(request.getParameter("idfilm"));
        Film t = new Film();
        t.setId(idfilm);

        Integer idPlateau = Integer.valueOf(request.getParameter("idplateau"));
        Plateau p = new Plateau();
        p.setId(idPlateau);

        scene.setFilm(t);
        scene.setPlateau(p);
        dao.create(scene);
        return new RedirectView("ListScene?id="+idfilm+"&div=1");
    }

    @GetMapping("/Recherche")
    public String Recherche(@RequestParam("idfilm") int idfilm, @RequestParam("scene") String scene, @RequestParam("idplateau") int idplateau, Model model, HttpServletRequest request){
        String sql = "Select * from scene where idfilm="+idfilm;
        if (idplateau != 0)
            sql = sql + " and idplateau="+idplateau;
        if (scene.isEmpty() == false)
            sql = sql + " And  nom_scene like '%"+scene+"%'";
        model.addAttribute("plateau",dao.findAll(Plateau.class));
        model.addAttribute("scene",dao.findQuery(Scene.class,sql));
        request.setAttribute("id",idfilm);
        request.setAttribute("div",1);
        return "Scene";
    }

    ////////////////////////////////////////////////////////


    // Tache

    @GetMapping("/ListeTache")
    private String ListeTache(@RequestParam int id,@RequestParam int div,Model model,HttpServletRequest request)
    {
        model.addAttribute("action",dao.findAll(Action.class));
        model.addAttribute("personnage",dao.findAll(Personnage.class));
        model.addAttribute("tache",dao.findQuery(Tache.class,"select * from tache where idscene="+id));
        request.setAttribute("id",id);
        request.setAttribute("div",div);
        return "Tache";
    }


    @PostMapping("/NouveauTache")
    private Object NouveauTache(@ModelAttribute Tache tache,HttpServletRequest request, Model model)
    {

            Integer scene = Integer.valueOf(request.getParameter("idscene"));
            Scene sc = new Scene();
            sc.setId(scene);
            Integer pers = Integer.valueOf(request.getParameter("idpers"));
            Personnage p = new Personnage();
            p.setId(pers);
            Integer action = Integer.valueOf(request.getParameter("idaction"));
            Action ac = new Action();
            ac.setId(action);
            tache.setScene(sc);
            tache.setPersonnage(p);
            tache.setType(ac);
            dao.create(tache);
            return new RedirectView("ListeTache?id=" + scene + "&div=2");
    }

    ////////////////////////////////////////////////////////

    // Plannification

    @GetMapping("/ListeAPlannifier")
    private String ListeAPlanifier(@RequestParam int id,Model model,HttpServletRequest request)
    {
        Film t = dao.findById(Film.class,id);
        model.addAttribute("film",t);
        model.addAttribute("scene",dao.findQuery(Scene.class,"select * from vscene where idfilm="+id+" order by debut,idplateau asc "));
        request.setAttribute("id",id);
        return "AjoutPlannification";
    }

    @GetMapping("/ReponsePlannification")
    private String ReponsePlannification(@RequestParam String debut, @RequestParam String fin, @RequestParam int id, Model model, HttpServletRequest request) {
        try {
            Film t = dao.findById(Film.class, id);
            model.addAttribute("film", t);
            model.addAttribute("scene", t.Plannification(debut, fin, dao, request.getParameterValues("scene")));
            request.setAttribute("id", id);
            return "ReponsePlannification";
        }
        catch (Exception e){
            String error = "Veuillez checker au moins une scène, et mettre une date de debut et une date de fin!";
            model.addAttribute("exception",error);
            return "Exception";
        }
    }

        // Validation Scène Dans le planning
    @PostMapping("/ValidationScene")
    public Object ValidationScene(@RequestParam int IdFilm, @RequestParam("scene") int[] scene, @RequestParam("daty") String[] daty, Model model){
        try{
            for (int i=0; i<scene.length;i++) {
                dao.addSceneValider(IdFilm, scene[i], daty[i]);
            }
            return new RedirectView("ListeAPlannifier?id="+IdFilm);
        }catch (Exception e){
            String error = "l'une de ces scenes a déjà été valider!";
            model.addAttribute("exception",error);
            return "Exception";
        }
    }

        // Version PDF du Planning

    @GetMapping("/Version_pdf")
    public void GenererPdf(HttpServletResponse response,@RequestParam("Film") String film,@RequestParam("idfilm") int idfilm, @RequestParam("myDate") String[] myDate, @RequestParam("myArray") String[] myArray,@RequestParam("myAuteur") String[] myAuteur,  @RequestParam("myPlateau") String[] myPlateau ,  @RequestParam("myDebut") String[] myDebut, @RequestParam("myFin") String[] myFin) throws Exception {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Planning.pdf");

        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        Paragraph vide = new Paragraph("                 ",new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD));
        // Ajout de l'en-tête
        Paragraph entete = new Paragraph("Planning du film :"+film, new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD));
        entete.setAlignment(Element.ALIGN_CENTER);
        document.add(entete);
        document.add(vide);


        Paragraph perso = new Paragraph("Personnage : "+dao.GetAllPerso(idfilm).toString(), new Font(Font.FontFamily.TIMES_ROMAN,12));
        document.add(perso);
        document.add(vide);

        // Ajout de la liste d'objets
        for (int i=0; i<myArray.length;i++) {
            Paragraph numero = new Paragraph(" ", new Font(Font.FontFamily.TIMES_ROMAN,12));
            int a = i+1;
            Chunk chunk = new Chunk("Numero "+a);
            chunk.setUnderline(0.1f,-2f);
            numero.add(chunk);
            document.add(numero);
            Paragraph auteur = new Paragraph("- Auteur : "+myAuteur[i], new Font(Font.FontFamily.HELVETICA, 12));
            Paragraph date = new Paragraph("- Date et Heure : "+myDate[i], new Font(Font.FontFamily.HELVETICA, 12));
            Paragraph Scene = new Paragraph("- Scene : "+myArray[i], new Font(Font.FontFamily.HELVETICA, 12));
            Paragraph plateau = new Paragraph("- Plateau : "+myPlateau[i], new Font(Font.FontFamily.HELVETICA, 12));
            Paragraph deb = new Paragraph("- Heure Debut : "+myDebut[i], new Font(Font.FontFamily.HELVETICA, 12));
            Paragraph fin = new Paragraph("- Heure Fin : "+myFin[i], new Font(Font.FontFamily.HELVETICA, 12));
            document.add(auteur);
            document.add(date);
            document.add(Scene);
            document.add(plateau);
            document.add(deb);
            document.add(fin);
            document.add(vide);
        }

        document.close();
    }

    /////////////////////////////////////

    //Indisponibilité


    //liste Film pour mettre l'indisponibilité
    @GetMapping("/DetailsIndisponibilite")
    public String DetailsIndisponibilite(Model model){
        model.addAttribute("personnage",dao.findAll(Personnage.class));
        model.addAttribute("plateau",dao.findAll(Plateau.class));
        model.addAttribute("film",dao.findAll(Film.class));
        return "DetailsIndisponibilite";
    }


    // Page pour ajouter l'Indidsponibilité pour une scène
    @GetMapping("/IndisponibilitePlateau")
    private String IndispoPlateauParScene(@RequestParam int id,Scene scene, Model model){
        Film s = new Film();
        s.setId(id);
        scene.setFilm(s);
        model.addAttribute("liste",dao.findWhere(scene));
        return "AjoutIndisponiblePlateau";
    }

    //Validation de l'indisponibilité

    @PostMapping("NouveauIndisponibilite")
    private Object NouveauIndisponibilite(@ModelAttribute Disponibilite disponibilite, HttpServletRequest request) throws IOException
    {
        Integer idscene = Integer.valueOf(request.getParameter("idscene"));
        Scene s = new Scene();
        s.setId(idscene);

        Integer idPlateau = Integer.valueOf(request.getParameter("idplateau"));
        Plateau p = new Plateau();
        p.setId(idPlateau);

        disponibilite.setScene(s);
        disponibilite.setPlateau(p);

        dao.create(disponibilite);
        return new RedirectView("DetailsIndisponibilite");
    }

    //Liste des plateaux pour voir leur indisponibilité

    @GetMapping("ListePlateau")
    private String ListePlateau(Model model)
    {
        model.addAttribute("plateau",dao.findAll(Plateau.class));
        return "Plateau";
    }


    // L'indisponibilité pour un plateau
    @GetMapping("/IndisponibiliteParPlateau")
    private String IndisponibiliteParPlateau(@RequestParam int id,Model model,HttpServletRequest request)
    {
        model.addAttribute("plateau",dao.findById(Plateau.class,id));
        model.addAttribute("disponible",dao.findQuery(Disponibilite.class,"select * from disponibilite where idplateau="+id));
        return "ListDisponiblePlateau";
    }









    @PostMapping("/indispoPerso")
    public Object AddIndispoPerso(@RequestParam int idperso, @RequestParam String debut,@RequestParam String fin){
        dao.AddIndispoPerso(idperso,debut,fin);
        return new RedirectView("indisponibilite");
    }

    @PostMapping("/indispoPlateau")
    public Object AddIndispoPlateau(@RequestParam int idplateau, @RequestParam String debut,@RequestParam String fin){
        dao.AddIndispoPlateau(idplateau,debut,fin);
        return new RedirectView("indisponibilite");
    }


    //Planning
    @GetMapping("/disponibilite")
    private void dispo(@RequestParam int id,@RequestParam String date,Model model,HttpServletRequest request){
        System.out.println(date + " "+id);
        Scene scene = dao.findById(Scene.class,id);
        Disponibilite disp = new Disponibilite();
        disp.setScene(scene);
        disp.setPlateau(scene.getPlateau());
        disp.setDates(Date.valueOf(date));
        System.out.println(disp.getDates() + " "+disp.getPlateau().getNomPlateau());
        dao.create(disp);
    }


}