function buildHtmlWithJsonArray(id,json,removeTemplate,remainItems){
    var temp = $('.'+id);

    var subCatagory = temp.parent();
//    var dhtml = temp[0].outerHTML;
//    var copy=$(dhtml);
    var copy = temp.clone();
    temp.removeClass(id);
    temp.remove();
    if(!remainItems){
        $(subCatagory).empty();
    }
    for(var i=0;i<json.length;i++){
        //temp[0]表示dom元素
        var html = buildHtmlWithJson(temp[0],json[i] ,i);
        subCatagory.append(html);
    }

    var shows = subCatagory.find('[show]');
    shows.each(function(index,obj){
        // if(index>0){
            var script = $(obj).attr('show');
            try{
                if(eval(script)){
                    $(obj).css('display','');
                }else{
                    // $(obj).css('display','none');
                    $(obj).remove();
                }
            }catch(e){

            }
        // }
    });

    var runscripts = subCatagory.find('[runscript=true]');
    runscripts.each(function(index,obj){
        // if(index>0){
            var val="";
            try{
                //val = eval(obj.textContent);
                val = eval($(obj).text());
                if(obj.tagName=='INPUT'){
                    obj.value = val;        
                }else{
                    // obj.textContent = val;  
                    obj.innerHTML = val;  
                }
            }catch(e){
                console.log(e);
                console.log(obj.textContent);
                obj.textContent = "";
            }
        // }
    });

    if(!removeTemplate){
        copy.css('display','none');
        subCatagory.prepend(copy);
    }
}
function buildHtmlWithJson(temp,json , rowIndex){
    temp.style.display='';
    var dhtml = temp.outerHTML;
    for(var key in json){
        var v = json[key];
        if(v==null){
            v="";
        }
        dhtml = dhtml.replace("$[rowIndex]",rowIndex);
        // dhtml = dhtml.replace(/\$\[name\]/g,v);
        dhtml = dhtml.replace(new RegExp("\\$\\["+key+"\\]","gm"),v);
    }
    return dhtml;
}

function getEnumTextByCode(enumArr,code){
    if(code==null){
        return "";
    }
    for(var i=0;i<enumArr.length;i++){
        if(enumArr[i]['code']==code){
            return enumArr[i]['name'];
        }
    }
}

//获取url里需要的值
function getParam(name){
var reg = new RegExp("(^|\\?|&)"+ name +"=([^&]*)(\\s|&|$)", "i");
return (reg.test(location.search))? encodeURIComponent(decodeURIComponent(RegExp.$2.replace(/\+/g, " "))) : '';
}

window.blockAlert = window.alert;
window.alert=function(msg){
	layer.msg(msg);
}
YW={
    options:{
        beforeSend: function(XMLHttpRequest){
            // $(window.parent.document.body).append('<img src="/style/images/ajax-loading.gif" style="display:block;position:absolute;margin-left:auto;margin-right:auto;" id="loading" />');
        },
        complete: function(XMLHttpRequest, textStatus){
            // $('#loading').remove();
        },
        error: function(data){
        },
        success:function(data){
        	if(data.responseText!=undefined && data.responseText.indexOf('relogin')!=-1){
        		window.parent.location='/login/index.html';
        	}else{
        		var json;
        		if(typeof(data)=='string'){
        			json = JSON.parse(data);
        		}else{
        			json = data;
        		}
        		if(json.return_status==302){
                    alert('操作不成功，请联系管理员.');
                }else if(json.return_status==303){
                    if(json.type=='ParameterMissingError'){
                        var field = json.field;
                        var arr = $('[name="'+field+'"]');
                        var desc;
                        if(arr!=null && arr.length>0){
                            desc = $(arr[0]).attr('desc');
                        }
                        if(desc==undefined){
                            desc = field;
                        }
                        $(arr[0]).focus();
                        alert("请先填写 "+ desc);

                    }else if(json.type=='ParameterTypeError'){
                        var field = json.field;
                        var arr = $('[name="'+field+'"]');
                        var desc;
                        if(arr!=null && arr.length>0){
                            desc = $(arr[0]).attr('desc');
                        }
                        if(desc==undefined){
                            desc = field;
                        }
                        $(arr[0]).focus();
                        alert(desc+json.msg);
                    }else{
                        alert(json['msg']);   
                    }
                    
                }else if(data.return_status){
                    alert('请求服务失败，请稍后重试');
                }else{
                	if(YW.options.mysuccess!=undefined){
                		YW.options.mysuccess(json);
                	}
                }
        	}
        }
    },
    ajax:function(options){
         if(options.beforeSend==undefined){
             options.beforeSend = YW.options.beforeSend;
         }
         if(options.complete==undefined){
             options.complete = YW.options.complete;
         }
        if(options.error==undefined){
            options.error = YW.options.error;
        }
        options.success = YW.options.success;
        YW.options.mysuccess = options.mysuccess;
        $.ajax(options);
    }
}

function fillData(data){
  $('.form-control').each(function(index,obj){
    $(obj).val(data[$(obj).attr('name')]);
  });
}

function setCookie(c_name, value, expiredays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + expiredays);
	document.cookie = c_name
			+ "="
			+ escape(value)
			+ ((expiredays == null) ? "" : ";expires="
					+ exdate.toGMTString());
}

//取回cookie
function getCookie(c_name) {
	if (document.cookie.length > 0) {
		c_start = document.cookie.indexOf(c_name + "=");
		if (c_start != -1) {
			c_start = c_start + c_name.length + 1;
			c_end = document.cookie.indexOf(";", c_start);
			if (c_end == -1)
				c_end = document.cookie.length;
			return unescape(document.cookie.substring(c_start, c_end));
		}
	}
	return ""
}

function clearCookie(name){
	setCookie(name,'',0);
	alert('缓存已清空');
}

function isMobile(tel){
	var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
	if(!myreg.test(tel)) 
	{ 
	    alert('请输入有效的手机号码！'); 
	    return false; 
	}
	return true;
}