package org.daisy.validator;

import org.apache.log4j.Logger;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Enumeration;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Util {
    private static final Logger logger = Logger.getLogger(Util.class.getName());

    public static String readStreamText(InputStream is) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();
        String line;
        while((line = br.readLine()) != null) {
            sb.append(line);
            sb.append("\n");
        }
        return sb.toString();
    }

    public static File createTempDirectory() throws IOException {
        final File temp;
        temp = File.createTempFile("NordicEPUB", Long.toString(System.nanoTime()));

        if(!(temp.delete())) {
            throw new IOException("Could not delete temp file: " + temp.getAbsolutePath());
        }
        if(!(temp.mkdir())) {
            throw new IOException("Could not create temp directory: " + temp.getAbsolutePath());
        }
        return (temp);
    }

    public static void appendXML(BufferedWriter bw, InputStream inputStream) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));
        String line;
        while((line = br.readLine()) != null) {
            line = removeTags(line);
            bw.write(line);
        }
        inputStream.close();
    }

    final static Pattern tagRemoval = Pattern.compile("<[?!][^>]+>");

    private static String removeTags(String line) {
        Matcher m = tagRemoval.matcher(line);
        while(m.find()) {
            line = m.replaceAll("");
            m = tagRemoval.matcher(line);
        }
        return line;
    }

    public static void writeFile(File outputFile, InputStream inputStream) throws Exception {
        if (inputStream == null) return;
        outputFile.getParentFile().mkdirs();

        OutputStream outputStream = new FileOutputStream(outputFile);

        byte[] buffer = new byte[8 * 1024];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
        inputStream.close();
        outputStream.close();
    }

    public static void deleteDirectory(File outputDir) {
        for(File f : outputDir.listFiles()) {
            if(f.isDirectory()) deleteDirectory(f);
            f.delete();
        }
        outputDir.deleteOnExit();
    }


    public static void unpackSchemaDir(String schemaResource, File schemaDir) throws Exception {
        final File jarFile = new File(Util.class.getProtectionDomain().getCodeSource().getLocation().getPath());

        if(jarFile.isFile()) {  // Run with JAR file
            final JarFile jar = new JarFile(jarFile);
            final Enumeration<JarEntry> entries = jar.entries();
            while(entries.hasMoreElements()) {
                final String name = entries.nextElement().getName();
                if (name.startsWith(schemaResource + "/")) {
                    Util.writeFile(
                            new File(schemaDir, new File(name).getName()),
                            EPUBFiles.class.getResourceAsStream(
                                    "/" + schemaResource + "/" + new File(name).getName()
                            )
                    );
                }
            }
            jar.close();
        } else {
            final URL url = EPUBFiles.class.getResource("/" + schemaResource);
            if (url != null) {
                try {
                    final File apps = new File(url.toURI());
                    for (File app : apps.listFiles()) {
                        Util.writeFile(
                                new File(schemaDir, app.getName()),
                                EPUBFiles.class.getResourceAsStream(
                                        "/" + schemaResource + "/" + app.getName()
                                )
                        );
                    }
                } catch (URISyntaxException ex) {
                    logger.fatal(ex.getMessage(), ex);
                }
            }
        }
    }
}
