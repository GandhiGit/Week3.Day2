package Week3.Day2;

import java.time.Duration;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import io.github.bonigarcia.wdm.WebDriverManager;

public class Ajio {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		WebDriverManager.chromedriver().setup();
		ChromeDriver driver = new ChromeDriver();
		driver.get("https://www.ajio.com/");
		driver.manage().window().maximize();
		driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
		WebElement Search = driver.findElement(By.xpath("//input[@name='searchVal']"));
		Search.sendKeys("Bags");
		Search.sendKeys(Keys.ENTER);
		driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));

		driver.findElement(By.xpath("//label[@class='facet-linkname facet-linkname-genderfilter facet-linkname-Men']"))
				.click();

		driver.findElement(By.xpath("//li[@class='rilrtl-list-item'][3]")).click();

		String Items = driver.findElement(By.xpath("//div[@class ='length']")).getText();
		System.out.println(Items);

		List<WebElement> bagBrandList = driver.findElements(By.xpath("//div[@class='brand']"));
		System.out.println("# of bagsbrand  " + bagBrandList.size());
		System.out.println("List of Bagbrands below : ");
		for (int i = 0; i < bagBrandList.size(); i++) {
			WebElement webElement = bagBrandList.get(i);

			String text = webElement.getText();
			System.out.println(text);

		}

		List<WebElement> bagnames = driver.findElements(By.xpath("//div[@class='name']"));
		System.out.println("# of bagnames  " + bagnames.size());
		System.out.println("List of Bagnames below :  ");
		for (int i = 0; i < bagnames.size(); i++) {
			WebElement webElement1 = bagnames.get(i);
			String text1 = webElement1.getText();
			System.out.println(text1);

		}

	}

}
