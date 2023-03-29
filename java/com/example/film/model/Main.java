package com.example.film.model;

import com.example.film.dao.HibernateDAO;
import com.itextpdf.text.pdf.*;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.itextpdf.text.*;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.time.Duration;
import java.time.LocalTime;

import javax.imageio.ImageIO;

public class Main {
    public static void main(String[] args) throws FileNotFoundException, DocumentException {
        ApplicationContext context = new ClassPathXmlApplicationContext("Conf.xml");
        HibernateDAO db = context.getBean(HibernateDAO.class);

        int id = 1;
        String sql = " select * from FilmValider where idfilm="+id +" order by daty";

        System.out.println(db.findQuery(FilmValider.class,sql).get(0).getScene().getNomScene());

        /*Document document = new Document();
        PdfWriter.getInstance(document, new FileOutputStream("data.pdf"));
        document.open();

        Paragraph para1 = new Paragraph("Test ");
        Paragraph para2 = new Paragraph("Test ");
        Paragraph para3 = new Paragraph("Test ");
        Paragraph para4 = new Paragraph("Test ");


        PdfPTable table = new PdfPTable(1);
        table.addCell("Header 1");
        table.addCell("Header 2");
        table.addCell("Header 3");
        table.addCell("Header 3");
        table.addCell("Header 3");
        table.addCell("Row 1 , Column 1" );
        table.addCell("Row 1 , Column 2" );

        Phrase par = new Phrase("Text hafa mitsy");
        Font font = new Font();
        par.setFont(font);
        par.add(new Chunk("okoko", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD, BaseColor.BLUE)));

        document.add(par);

        document.add(para1);
        document.add(para2);
        document.add(para3);
        document.add(para4);
        document.add(table);
        document.close();

        try {
            String chemin = "data.pdf";
            PdfReader pdf = new PdfReader(chemin);
            int n = pdf.getNumberOfPages();
            System.out.println("nombre "+n);
            pdf.close();
        }catch (IOException e){
            e.printStackTrace();
        } */


    }
}
