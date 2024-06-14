package site.dearmysanta.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class SantaLogger {
	private static final Logger logger = LoggerFactory.getLogger(SantaLogger.class);
	
	
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
