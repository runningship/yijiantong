package com.houyi.management.product;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class MyRandom {

	private List<String> data = new ArrayList<String>();
	
	private char[] chars = new char[]{'0' , '1' , '2' , '3','4' , '5' , '6' , '7' , '8' , '9' , 'A' , 'B' , 'C' , 'D' , 'E' , 'F'  ,'G' , 'H' , 'I' , 'J' , 'K' , 'L' ,'M','N' , 'O' , 'P' , 'Q' , 'R' , 'S' , 'T' ,'U' , 'V' , 'W' ,'X' , 'Y' , 'Z'};
	public MyRandom(){
		for(int i=0;i<chars.length;i++){
			for(int j=0;j<chars.length;j++){
				data.add(chars[i] +"" + chars[j]);
			}
		}
	}
	
	public String getNextCode(){
		if(data.isEmpty()){
			return "";
		}
		Random ran = new Random();
		int pos = ran.nextInt(data.size());
		String str = data.get(pos);
		data.remove(pos);
		return str;
	}
	
	public static void main(String[] args){
		System.out.println(new MyRandom().getNextCode());
	}
}
