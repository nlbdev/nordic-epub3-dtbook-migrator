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
import java.time.Instant;
import java.time.LocalTime;
import java.time.ZoneId;
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

    private static final Pattern milliPattern = Pattern.compile(
            "(ntp=)?(\\d{1,2}:)?(\\d{1,2}:)?(\\d+)(\\.\\d+)?(ms|h|min|s)?"
    );

    public static final long parseMilliSeconds(String s) {

        Matcher m = milliPattern.matcher(s);
        if (m.find()) {
            double val = 0;

            if (m.group(2) != null) {
                val += Long.parseLong(m.group(2).substring(0, m.group(2).length() - 1)) * 3600;
            }
            if (m.group(3) != null) {
                val += Long.parseLong(m.group(3).substring(0, m.group(3).length() - 1)) * 60;
            }
            if (m.group(4) != null) {
                val += Long.parseLong(m.group(4));
            }
            if (m.group(5) != null) {
                val += Double.parseDouble(m.group(5));
            }

            if (m.group(6) != null) {
                if ("h".equals(m.group(6))) {
                    val *= 3600 * 1000;
                } else if ("min".equals(m.group(6))) {
                    val *= 60 * 1000;
                } else if ("ms".equals(m.group(6))) {
                } else {
                    val *= 1000;
                }
            } else {
                val *= 1000;
            }

            return Math.round(val);
        }
        return 0;
    }

    public static String formatTime(long time) {
        Instant inst = Instant.ofEpochMilli(time);
        LocalTime localTime = LocalTime.ofInstant(inst, ZoneId.of("UTC"));
        return localTime.toString();
    }
}
