package com.newretail.controller.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.newretail.common.utils.*;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.newretail.pojo.AddressTable;
import com.newretail.pojo.UserAuthenticationTable;
import com.newretail.pojo.UserPowerTable;
import com.newretail.pojo.UserSellerTable;
import com.newretail.pojo.UserTable;
import com.newretail.pojo.custom.CityInfoCustom;
import com.newretail.service.AddressService;
import com.newretail.service.CityService;
import com.newretail.service.UserPowerService;
import com.newretail.service.UserService;

/**
 * 用户登陆注册相关接口
 * @author Yongjie
 *
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	private UserPowerService userPowerService;
	@Autowired
	private CityService cityService;
	@Autowired
	private AddressService addressService;

	@Value("${SSO_BASE_URL}")
	public String SSO_BASE_URL;

	@Value("${SSO_USER_TOKEN}")
	public String SSO_USER_TOKEN;

	@Value("${SSO_PAGE_LOGIN}")
	public String SSO_PAGE_LOGIN;

	@Value("${SSO_USER_LOGIN}")
	public String SSO_USER_LOGIN;

	/**
	 * 登陆
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping("/login")
	public @ResponseBody NewRetailResult loginUser(HttpServletRequest request, HttpServletResponse response) {
		UserTable userTable = new UserTable();
		String username = request.getParameter("username").toString();
		String password = request.getParameter("password").toString();
		String md5Hex = EncrypationUtils.md5Hex(password);
		if (username == null || username == "") {
			return NewRetailResult.build(0, "账号不能空");
		}
		if (password == null || password == "") {
			return NewRetailResult.build(0, "请输入密码");
		}
		if (ValidatorUtils.isPhone(username)) {
			userTable.setPhone(username);
		}
		if (ValidatorUtils.isEmail(username)) {
			userTable.setEmail(username);
		}

		try {
			CookieUtils.deleteCookie(request, response, "NEWRETAIL_LOGIN");
		} catch (Exception e1) {

		}
		HashMap<String, String> hashMap = new HashMap<String, String>(2);
		hashMap.put("username", username);
		hashMap.put("password", password);
		Logger log = Logger.getLogger(UserController.class);
		String doPost;
		try {
			doPost = HttpClientUtil.doPost(SSO_BASE_URL + SSO_USER_LOGIN, hashMap);
			NewRetailResult jsonToPojo = JsonUtils.jsonToPojo(doPost, NewRetailResult.class);
			String token = jsonToPojo.getData().toString();
			List<UserTable> userList = userService.findUser(userTable);
			UserTable user = userList.get(0);
			UserPowerTable userpojo = new UserPowerTable();
			userpojo.setId(user.getPowerId());
			userpojo = userPowerService.findUser(userpojo);
			System.out.println("========================userpojo:" + userpojo.getPower());
			// 添加写cookie的逻辑，cookie的有效期是关闭浏览器就失效。
			CookieUtils.setCookie(request, response, "NEWRETAIL_LOGIN", token, true);
			CookieUtils.setCookie(request, response, "POWER", userpojo.getPower());
			String cookieValue = CookieUtils.getCookieValue(request, "NEWRETAIL_LOGIN");
			return NewRetailResult.build(200, "登陆成功", token);
		} catch (Exception e) {
			e.printStackTrace();
			return NewRetailResult.build(0, "账号或密码错误", null);

		}
	}

	/**
	 * 获取Token,用于Android客户端调用
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/token")
	public @ResponseBody NewRetailResult getToken(HttpServletRequest request, HttpServletResponse response) {
		UserTable userTable = new UserTable();
		String username = request.getParameter("username").toString();
		String password = request.getParameter("password").toString();
		String md5Hex = EncrypationUtils.md5Hex(password);
		if (username == null || username == "") {
			return NewRetailResult.build(0, "账号不能空");
		}
		if (password == null || password == "") {
			return NewRetailResult.build(0, "请输入密码");
		}
		if (ValidatorUtils.isPhone(username)) {
			userTable.setPhone(username);
		}
		if (ValidatorUtils.isEmail(username)) {
			userTable.setEmail(username);
		}

		HashMap<String, String> hashMap = new HashMap<String, String>(2);
		hashMap.put("username", username);
		hashMap.put("password", password);
		Logger log = Logger.getLogger(UserController.class);
		String doPost;
		try {
			doPost = HttpClientUtil.doPost(SSO_BASE_URL + SSO_USER_LOGIN, hashMap);
			NewRetailResult jsonToPojo = JsonUtils.jsonToPojo(doPost, NewRetailResult.class);
			String token = jsonToPojo.getData().toString();
			List<UserTable> userList = userService.findUser(userTable);
			UserTable user = userList.get(0);
			UserPowerTable userpojo = new UserPowerTable();
			userpojo.setId(user.getPowerId());
			userpojo = userPowerService.findUser(userpojo);
			System.out.println("========================userpojo:" + userpojo.getPower());
			// 添加写cookie的逻辑，cookie的有效期是关闭浏览器就失效。
			CookieUtils.setCookie(request, response, "NEWRETAIL_LOGIN", token, true);
			CookieUtils.setCookie(request, response, "POWER", userpojo.getPower());
			String cookieValue = CookieUtils.getCookieValue(request, "NEWRETAIL_LOGIN");
			Map<String, String> map = new HashMap<String, String>();
			map.put("token", token);
			return NewRetailResult.build(200, "登陆成功", map);
		} catch (Exception e) {
			e.printStackTrace();
			return NewRetailResult.build(0, "账号或密码错误", null);

		}
	}

	/**
	 * 注册
	 *
	 * @param forms
	 * @return
	 */
	@RequestMapping("register")
	@ResponseBody
	public NewRetailResult registerUser(@RequestBody Map<String, Object> forms) {
		String time = DateUtil.getNowDateTime("yyyy-MM-dd HH:mm:ss");
		String mUsername = forms.get("mUsername").toString();
		String mPassword = forms.get("mPassword").toString();
		String mSex = forms.get("mSex").toString();
		String mPhone = forms.get("mPhone").toString();
		String mEmail = forms.get("mEmail").toString();
		String mPhoneVildate = forms.get("mPhoneVildate").toString();
		String mShopName = forms.get("mShopName").toString();
		String mManagerClass = forms.get("mManagerClass").toString();
		String mManagerName = forms.get("mManagerName").toString();
		String mIdCard = forms.get("mIdCard").toString();
		String mLicense = forms.get("mLicense").toString();
		String mShopImageUrl = forms.get("mShopImageUrl").toString();
		String mIdCardImage1Url = forms.get("mIdCardImage1Url").toString();
		String mIdCardImage2Url = forms.get("mIdCardImage2Url").toString();
		String mIdCardImage3Url = forms.get("mIdCardImage3Url").toString();
		String mLicenseImageUrl = forms.get("mLicenseImageUrl").toString();
		// 省份
		String province = forms.get("province").toString();
		// 城市
		String city = forms.get("city").toString();
		// 区县
		String district = forms.get("district").toString();
		// 详细地址
		String detailAddress = forms.get("detail_address").toString();

		// 用户基本信息
		UserTable user = new UserTable();
		String userId = PrimaryKeyUtils.getLocalTrmSeqNum();
		user.setId(userId);
		user.setUsername(mUsername);
		user.setSex(mSex);
		user.setPassword(EncrypationUtils.md5Hex(mPassword));
		user.setPhone(mPhone);
		user.setEmail(mEmail);
		user.setIdentify("2");
		user.setStatus("1");
		user.setRemark("创建");
		user.setDefaultDeliverAddressSeq("1");
		user.setPowerId(2);
		user.setCreateTime(time);
		user.setUpdateTime(time);
		

		//添加用户地址
		AddressTable addressTable = new AddressTable();
		//根据省、市、区 获取城市信息
		CityInfoCustom cityInfoCustom = cityService.getCityInfoCustom(province, city, district);
		addressTable.setUserId(userId);
		addressTable.setProvinceId(cityInfoCustom.getProvinceId());
		addressTable.setProvinceStr(province);
		addressTable.setCityId(cityInfoCustom.getCityId());
		addressTable.setCityStr(city);
		//设置区县
		if(!TextUtils.isEmpty(district)) {
			addressTable.setDistrictId(cityInfoCustom.getDistrictceId());
			addressTable.setDistrictStr(cityInfoCustom.getDistrictName());
		}
		addressTable.setAddress(detailAddress);
		addressTable.setIsDefault(1);
		addressTable.setLinkMan(mUsername);
		addressTable.setMobile(mPhone);
		addressTable.setCode("000000");
		addressTable.setStatus(0);
		addressTable.setDateAdd(DateUtil.getNowDateTime());
		addressTable.setDateUpdate(DateUtil.getNowDateTime());


		// 商家信息
		UserSellerTable userSeller = new UserSellerTable();
		userSeller.setId(IdGenerator.getId());
		userSeller.setShopName(mShopName);
		userSeller.setManagerName(mManagerName);
		userSeller.setAuthenticationStatus(0);
		userSeller.setManagementClass(mManagerClass);
		userSeller.setPicUrl(mShopImageUrl);
		userSeller.setCreateTime(time);
		userSeller.setUpdateTime(time);
		userSeller.setUserId(userId);

		// 商家认证
		UserAuthenticationTable userAuthentication = new UserAuthenticationTable();
		userAuthentication.setId(PrimaryKeyUtils.getLocalTrmSeqNum());
		userAuthentication.setUserId(userId);
		userAuthentication.setIdCard(mIdCard);
		userAuthentication.setIdentity(0);
		userAuthentication.setIdCardPositiveUrl(mIdCardImage1Url);
		userAuthentication.setIdCardNegativeUrl(mIdCardImage2Url);
		userAuthentication.setHandheldIdCardUrl(mIdCardImage3Url);
		userAuthentication.setBusinessLicenseId(mLicense);
		userAuthentication.setBusinessLicenseUrl(mLicenseImageUrl);
		userAuthentication.setAuthenticationStatus(0);
		userAuthentication.setAuthenticationStyle(2);
		userAuthentication.setRemark("商家认证");

		UserTable t1 = new UserTable();
		t1.setPhone(mPhone);
		
		//设置用户地址
		try {
			addressService.setNewAddress(addressTable);
		} catch (Exception e) {
			return NewRetailResult.build(0, "注册失败！", ExceptionUtil.getStackTrace(e));
		}

		try {
			List<UserTable> ls1 = userService.findUser(t1);
			if (ls1 != null && ls1.size() > 0) {
				return NewRetailResult.build(0, "你的手机号码已被注册！");
			}
		} catch (Exception e1) {

		}
		UserTable t2 = new UserTable();
		t2.setEmail(mEmail);
		;
		try {
			List<UserTable> ls1 = userService.findUser(t2);
			if (ls1 != null && ls1.size() > 0) {
				return NewRetailResult.build(0, "你的邮箱已被注册！");
			}
		} catch (Exception e1) {

		}

		try {
			int addUser = userService.addUser(user, userSeller, userAuthentication);
			if (addUser > 0) {
				return NewRetailResult.ok();
			}

		} catch (Exception e) {
			return NewRetailResult.build(0, e.getMessage());
		}
		return NewRetailResult.ok();
	}

}
