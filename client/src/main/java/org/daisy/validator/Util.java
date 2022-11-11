package org.daisy.validator;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Util {
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
}
