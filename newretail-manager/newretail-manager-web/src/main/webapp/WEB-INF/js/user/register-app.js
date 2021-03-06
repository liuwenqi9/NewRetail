'use strict';
var appServer = 'http://39.108.94.35:10080';
var bucket = 'newretail-wechatapp';
var region = 'oss-cn-shenzhen';
var urllib = OSS.urllib;
var Buffer = OSS.Buffer;
var OSS = OSS.Wrapper;
var STS = OSS.STS;
var storeImageUrl = "";
var idCardImage1Url = "";
var idCardImage2Url = "";
var idCardImage3Url = "";
var licenseImageUrl = "";
var applyTokenDo = function(func) {
	var url = appServer;
	return urllib.request(url, {
		method: 'GET'
	}).
	then(function(result) {
		var creds = JSON.parse(result.data);
		var client = new OSS({
			region: region,
			accessKeyId: creds.AccessKeyId,
			accessKeySecret: creds.AccessKeySecret,
			stsToken: creds.SecurityToken,
			bucket: bucket
		});
		var f = func(client);
		return f;
	});
};

var progress = function(p) {
	return function(done) {
		var bar = document.getElementById('progress-bar');
		bar.style.width = Math.floor(p * 100) + '%';
		bar.innerHTML = Math.floor(p * 100) + '%';
		console.log("progress:" + Math.floor(p * 100) + "%");
		done();
	}
};
//上传图片
var uploadFile = function(client) {
	//获取文件
	var storeImage = document.getElementById('preview1Img').files[0];
	var idCardImage1 = document.getElementById('preview2Img').files[0];
	var idCardImage2 = document.getElementById('preview3Img').files[0];
	var idCardImage3 = document.getElementById('preview4Img').files[0];
	var licenseImage = document.getElementById('preview5Img').files[0];
	//获取文件路径
	var storeImageName = filenameUtils(storeImage.name);
	var idCardImage1Name = filenameUtils(idCardImage1.name);
	var idCardImage2Name = filenameUtils(idCardImage2.name);
	var idCardImage3Name = filenameUtils(idCardImage3.name);
	var licenseImageName = filenameUtils(licenseImage.name);

	//店铺封面			
	client.multipartUpload(storeImageName, storeImage).then(function(res) {
		console.log("status1:" + res.res.status);
		console.log("url:" + res.name);
		if(res.res.status == 200) {
			storeImageUrl = res.name;
			//身份证正面照
			client.multipartUpload(idCardImage1Name, idCardImage1).then(function(res) {
				console.log("status2:" + res.res.status);
				console.log("url:" + res.name);
				if(res.res.status == 200) {
					idCardImage1Url = res.name;
					//身份证反面照
					client.multipartUpload(idCardImage2Name, idCardImage2).then(function(res) {
						console.log("status3:" + res.res.status);
						console.log("url:" + res.name);
						if(res.res.status == 200) {
							idCardImage2Url = res.name;
							//手持正面照
							client.multipartUpload(idCardImage3Name, idCardImage3).then(function(res) {
								console.log("status4:" + res.res.status);
								console.log("url:" + res.name);
								if(res.res.status == 200) {
									idCardImage3Url = res.name;
									//营业执照
									client.multipartUpload(licenseImageName, licenseImage).then(function(res) {
										console.log("status5:" + res.res.status);
										console.log("url:" + res.name);
										if(res.res.status == 200) {
											licenseImageUrl = res.name;
												$.ajax({
														type: "post", //用GET方式传输
														dataType: "json", //数据格式:JSON */
														contentType: "application/json; charset=utf-8",
														url: '/user/register', //目标地址
														data: JSON.stringify({
															"mUsername": username,
															"mSex": sex,
															"mPassword": passwd,
															"mPhone": phone,
															"mEmail":email,
															"mPhoneVildate": phoneYzm,
															"mShopName": shopName,
															"mManagerClass": manager_class,
															"mManagerName":managerName,
															"mIdCard": idCard,
															"mLicense": license,
															"mShopImageUrl": storeImageUrl,
															"mIdCardImage1Url": idCardImage1Url,
															"mIdCardImage2Url": idCardImage2Url,
															"mIdCardImage3Url": idCardImage3Url,
															"mLicenseImageUrl": licenseImageUrl,
                                                             "province":$("#province").val(),
															 "city":$("#city").val(),
															 "district":$("#district").val(),
															 "detail_address":$(".detail_address").val()
														}),
														success: function(data) {
															console.log(data);
															if(data.status == 200) { //提交表单成功
																showTips('提交审核成功', 2500, 1);
																window.location.href ='http://localhost:8080/login';
															} else {
																showTips(data.msg, 2500, 1);
																console.log(data.msg);
															}
														}
													});

										}
									});
								}
							});
						}
					});
				}
			});
		}
	});
	return null;
};

function getNowFormatDate() {
	var date = new Date();
	var seperator1 = "/";
	var seperator2 = ":";
	var month = date.getMonth() + 1;
	var strDate = date.getDate();
	if(month >= 1 && month <= 9) {
		month = "0" + month;
	}
	if(strDate >= 0 && strDate <= 9) {
		strDate = "0" + strDate;
	}
	var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
	return currentdate;
};

function filenameUtils(filename) {
	var index1 = filename.lastIndexOf(".");
	var index2 = filename.length;
	var suffix = filename.substring(index1, index2)
	var random = parseInt((Math.random()*9+1)*9*100000);
	return "/business/images/" + getNowFormatDate() + "/" + (new Date()).valueOf() +random+ suffix;
};
//验证是否是手机
function checkMobile(sMobile) {
	if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(sMobile))) {
		return false;
	}
};
//显示提示框，目前三个参数(txt：要显示的文本；time：自动关闭的时间（不设置的话默认1500毫秒）；status：默认0为错误提示，1为正确提示；)
function showTips(txt, time, status) {
	var htmlCon = '';
	if(txt != '') {
		if(status != 0 && status != undefined) {
			htmlCon = '<div class="tipsBox" style="width:220px;padding:10px;background-color:#4AAF33;border-radius:4px;-webkit-border-radius: 4px;-moz-border-radius: 4px;color:#fff;box-shadow:0 0 3px #ddd inset;-webkit-box-shadow: 0 0 3px #ddd inset;text-align:center;position:fixed;top:25%;left:50%;z-index:999999;margin-left:-120px;"><img src="assets/css/images/ok.png" style="vertical-align: middle;margin-right:5px;" alt="OK，"/>' +
				txt + '</div>';
		} else {
			htmlCon = '<div class="tipsBox" style="width:220px;padding:10px;background-color:#D84C31;border-radius:4px;-webkit-border-radius: 4px;-moz-border-radius: 4px;color:#fff;box-shadow:0 0 3px #ddd inset;-webkit-box-shadow: 0 0 3px #ddd inset;text-align:center;position:fixed;top:25%;left:50%;z-index:999999;margin-left:-120px;"><img src="assets/css/images/err.png" style="vertical-align: middle;margin-right:5px;" alt="Error，"/>' +
				txt + '</div>';
		}
		$('body').prepend(htmlCon);
		if(time == '' || time == undefined) {
			time = 1500;
		}
		setTimeout(function() {
			$('.tipsBox').remove();
		}, time);
	}
};
