package com.houyi.management.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class ZipUtils {
	   
	    public static void zipFile(File[] subs, String baseName, ZipOutputStream zos) throws IOException {         
	          for (int i=0;i<subs.length;i++) {
		           File f=subs[i];    
		           zos.putNextEntry(new ZipEntry(baseName + f.getName()));       
		           FileInputStream fis = new FileInputStream(f);       
		           byte[] buffer = new byte[1024];       
		           int r = 0;       
		           while ((r = fis.read(buffer)) != -1) {       
		               zos.write(buffer, 0, r);       
		           }  
		           fis.close();   
		           zos.closeEntry();
	          }    
	     }   
}
