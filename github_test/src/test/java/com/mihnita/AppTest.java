package com.mihnita;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class AppTest extends TestCase {
    public AppTest( String testName ) {
        super( testName );
    }
    public static Test suite() {
        return new TestSuite( AppTest.class );
    }
    public void testApp() {
        System.out.println( "Hello \033[91m RED \033[m World!" );
        assertTrue( true );
    }
}
