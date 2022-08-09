package it.unibo.big.m3d.m3dschema;

import java.util.Random;

public class Browser {

    public String browser;
    public String[] browserList = { "INTERNET_EXPLORER", "FIREFOX", "CHROME", "SAFARI", "OPERA" };

    public Browser(Random random){
        this.browser = browserList[random.nextInt(browserList.length)];
    }

    @Override
    public String toString() {
        return "Browser: " + browser;
    }

}
