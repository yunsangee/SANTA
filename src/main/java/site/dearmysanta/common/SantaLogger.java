package site.dearmysanta.common;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


public class SantaLogger {
	private static final Logger logger = LogManager.getLogger(SantaLogger.class);
	
	
	public SantaLogger() {
		
	}
	
	public static void makeLog(String logType, String sentence) {
		switch (logType.toLowerCase()) {
        case "info":
            logger.info(sentence);
            break;
        case "error":
            logger.error(sentence);
            break;
        default:
            logger.info("Unknown logType: " + logType + ". Log: " + sentence);
            break;
		}
	}
	
}
