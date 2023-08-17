package api.runner;

import com.intuit.karate.junit5.Karate;

public class SmokeRunner {
	@Karate.Test
	public Karate runTest() {
		//address for our feature files
		//and also add the tag like smoke test or regression
		
		return Karate.run("classpath:features")
				.tags("@Smoke");
	}

}
