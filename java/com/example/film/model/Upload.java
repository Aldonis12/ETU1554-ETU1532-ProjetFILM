package com.example.film.model;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class Upload {
    public static String uploadImage(String path, CommonsMultipartFile file) throws IOException{
        String fileName = file.getOriginalFilename();

        byte[] bytes = file.getBytes();
        BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(new File(path + File.separator + fileName)));
        out.write(bytes);
        out.flush();
        out.close();
        return fileName;
    }
}
