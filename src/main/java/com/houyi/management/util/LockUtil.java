package com.houyi.management.util;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class LockUtil {

	private static Map<String , Lock> locks = new HashMap<String , Lock>();
	
	public static Lock getLock(String code){
		if(locks.containsKey(code)){
			return locks.get(code);
		}
		Lock lock = new ReentrantLock();
		locks.put(code, lock);
		return lock;
	}
	
	public static void releaseLock(String code){
		locks.remove(code);
	}
	
	public static void main(String[] args){
		TestThread t1 = new TestThread("t1");
		TestThread t2 = new TestThread("t2");
		TestThread t3 = new TestThread("t3");
		t1.start();
		t2.start();
		t3.start();
	}
	
	
}

class TestThread extends Thread{
	String name;
	
	public TestThread(String name){
		this.name = name;
	}
	
	@Override
	public void run() {
		while(true){
			Lock lock = LockUtil.getLock("test");
			lock.lock();
			System.out.println(name+"running...");
			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println(name+"finished...");
//			LockUtil.releaseLock("test");
			lock.unlock();
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
	
}