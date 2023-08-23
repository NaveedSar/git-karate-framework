package api.utility.data;

import java.util.Random;

public class GenerateData {
	public static String getEmail() {

		String prefix = "Bestof_email";
		String provider = "@tekschool.us";
		int random = (int) (Math.random() * 1000000);
		String email = prefix + random + provider;
		return email;

	}

	public static String getPhoneNumber() {

		String phoneNumber = "7";
		for (int i = 0; i < 9; i++) {
			phoneNumber += (int) (Math.random() * 10);

		}
		return phoneNumber;
	}

	public static void main(String[] args) {
		System.out.println(getPhoneNumber());
	}
}
