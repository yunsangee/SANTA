package site.dearmysanta.common;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


public class SantaLogger {
	private static final Logger logger = LogManager.getLogger(SantaLogger.class);
	
	
	public SantaLogger() {
		
	}
	
	public static void makeLog(String logType, String sentence) {
		if(logType.equals("debug") | logType.equals("DEBUG")) {
			logger.debug(sentence);
		}else if(logType.equals("error") | logType.equals("ERROR")) {
			logger.error(sentence);
		}
	}
	
}
