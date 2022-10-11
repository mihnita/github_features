package com.mihnita;

import static org.junit.Assert.assertTrue;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class AppTest {
    private static final Logger logger = LogManager.getLogger(AppTest.class);

    @Test
    public void testApp() {
        System.out.println( "Hello \033[91m RED \033[m World!" );

        logger.fatal("Hello from Log4j 2");
        logger.error("Hello from Log4j 2");
        logger.warn("Hello from Log4j 2");
        logger.info("Hello from Log4j 2");
        logger.debug("Hello from Log4j 2");
        logger.trace("Hello from Log4j 2");

        assertTrue( true );
    }
}
