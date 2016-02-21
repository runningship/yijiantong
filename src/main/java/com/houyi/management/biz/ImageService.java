package com.houyi.management.biz;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.houyi.management.biz.entity.Image;
import com.houyi.management.cache.ConfigCache;
import com.houyi.management.util.ImageHelper;


@Module(name="/image")
public class ImageService {

	static final int MAX_SIZE = 1024000*100;
	static final String BaseFileDir = ConfigCache.get("article_image_path", "C:\\inetpub\\wwwroot\\article_image_path");
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView upload(Image image){
		ModelAndView mv = new ModelAndView();
		HttpServletRequest request = ThreadSession.HttpServletRequest.get();
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		try{
			List<FileItem> items = upload.parseRequest(request);
//			HouseImage po = dao.getUniqueByParams(HouseImage.class, new String[]{"hid","uid" , "chuzu"}, new Object[]{image.hid ,image.uid, image.chuzu});
//			if(po!=null){
//				image = po;
//			}
//			image.isPrivate = 0;
//			image.addtime = new Date();
//			image.sh = 0;
			String serverPathList = new String();
			for(FileItem item : items){
				if(item.isFormField()){
					continue;
				}
				if(item.getSize()<=0){
					throw new RuntimeException("至少先选择一张图片.");
				}else if(item.getSize()>=MAX_SIZE){
						throw new RuntimeException("单个图片不能超过2M");
				}else{
					image.path = image.uid+"/"+item.getName();
					String thumbName = item.getName();
					thumbName =  item.getName()+".t.jpg";
					String savePath = BaseFileDir+File.separator +image.uid+File.separator+item.getName();
					String thumbPath = BaseFileDir+File.separator +image.uid+File.separator+thumbName;
					FileUtils.copyInputStreamToFile(item.getInputStream(), new File(savePath));
					ImageHelper.resize(savePath, 270, 270, thumbPath);
					serverPathList+=item.getName()+";";
				}
			}
			dao.saveOrUpdate(image);
			mv.data.put("result", 0);
			mv.data.put("serverPathList", serverPathList);
			return mv;
		}catch(Exception ex){
			throw new GException(PlatformExceptionType.BusinessException,"文件图片失败" , ex);
		}
	}
	
	@WebMethod
	public ModelAndView list(Page<Image> page , String title){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder("from Image where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(title)){
			sql.append(" and title like ?");
			params.add("%"+title+"%");
		}
		page = dao.findPage(page, sql.toString() , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(Integer id){
		ModelAndView mv = new ModelAndView();
		Image po = dao.get(Image.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
}
