package hr.javacro.proguard;

import java.io.*;

import org.apache.commons.io.IOUtils;
import org.apache.commons.codec.binary.Base64;

public class B64 {
    public static void main(final String[] args) throws IOException {
        pipe(System.in, System.out);
    }

    public static void pipe(final InputStream is, final OutputStream os) throws IOException {
        final byte[] body = IOUtils.toByteArray(is);
        final byte[] encoded = Base64.encodeBase64(body);
        IOUtils.write(encoded, os);
    }
}
