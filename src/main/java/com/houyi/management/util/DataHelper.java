package com.houyi.management.util;

import java.text.SimpleDateFormat;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Level;
import org.bc.sdak.utils.LogUtil;

public class DataHelper {

	public static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static SimpleDateFormat dateSdf = new SimpleDateFormat("yyyy-MM-dd");
	public static SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	public static SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	public static SimpleDateFormat sdf4 = new SimpleDateFormat("yyyyMMdd");
	
	
	private static final HanyuPinyinOutputFormat format = new HanyuPinyinOutputFormat();
	static{
		format.setVCharType(HanyuPinyinVCharType.WITH_V);
		format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
	}
	
	public static String toPinyin(String hanzi){
		try {
			String pinyin="";
			for(int i=0;i<hanzi.length();i++){
				String[] arr = PinyinHelper.toHanyuPinyinStringArray(hanzi.charAt(i), format);
				if(arr!=null && arr.length>0){
					pinyin+=arr[0];
				}else{
					LogUtil.warning("汉字["+hanzi.charAt(i)+"]转拼音失败,");
					continue;
				}
			}
			return pinyin;
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			LogUtil.log(Level.WARN, "汉字["+hanzi+"]转拼音失败", e);
		}
		return "";
	}
	
	public static String toPinyinShort(String hanzi){
		try {
			String pinyin="";
			for(int i=0;i<hanzi.length();i++){
				String[] arr = PinyinHelper.toHanyuPinyinStringArray(hanzi.charAt(i), format);
				if(arr!=null && arr.length>0){
					if(StringUtils.isNotEmpty(arr[0])){
						pinyin+=arr[0].charAt(0);
					}
				}else{
					LogUtil.warning("汉字["+hanzi.charAt(i)+"]转拼音失败,");
					continue;
				}
			}
			return pinyin;
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			LogUtil.log(Level.WARN, "汉字["+hanzi+"]转拼音失败", e);
		}
		return "";
	}
}
