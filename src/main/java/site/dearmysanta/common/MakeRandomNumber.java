package site.dearmysanta.common;

import java.util.Random;

public class MakeRandomNumber {

	public static int makeRandomNumber() {
		
		System.out.println("Random Number Generate");
		Random random = new Random();
		
		int randomNumber = random.nextInt(888888)+111111;
		return randomNumber;
	}
}
