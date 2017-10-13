package src.main.java.cn.net.communion.helper;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class PropsReader {
    static PropsReader instance = new PropsReader();
    private Properties props;

    private PropsReader() {
        props = new Properties();
        try {
            InputStreamReader in = new InputStreamReader(new FileInputStream(ArgParser.CONFIGFILE),"utf-8");
            props.load(in);

        } catch (IOException e) {
            System.out.println("config.properties");
        }
    }

    static public PropsReader getInstance() {
        return instance;
    }

    public String getProperty(String param) {
        if (props.containsKey(param))
        {
            return props.getProperty(param);
        }
        return null;
    }

}
