package DAO;
import java.util.UUID;
public class TrimExample {
	
	public static void main(String [] args)
	{
		String str = "savan'";
		
		String str1= str.replaceAll(".(?!$)", "$0/");
		System.out.println(str1);
	}

}
