LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.only(left: 20,right: 20, top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:  Column(
                          children: [
                            authTopWidget(
                                topImage: Assets.loginImage,
                                title: AppString.letsVerifyYourPhone,
                                subtitle: AppString.pleaseEnterYouPhone),
                            yHeight(40),
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                final loginState = ref.watch(loginProvider);
                                return TextFormField(
                                  controller: loginData.phoneController,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(12),
                                  ],
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.phone,
                                  decoration: fieldDeco(
                                      yPadding: 15.h,
                                      hintText: "000 000 000",
                                      prefixWidget: GestureDetector(
                                        onTap: () async {
                                          var res = await Navigator.pushNamed(context, Routes.countyPicker);
                                          if (res != null) {
                                            loginData.country = res as Country;
                                            loginData.updateCountry(loginData.country);
                                          }
                                        },
                                        child: FittedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.grey.withOpacity(0.1),
                                                  radius: 15.r,
                                                  child: AppText(
                                                    text: loginData.country.flag ?? "",
                                                    textSize: 15.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                AppText(
                                                  text: loginData.country.dialCode ?? "",
                                                  //"${controller.countryValue.value?.dialCode}",
                                                  textSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_down_outlined,
                                                  size: 15.h,
                                                ),
                                                xWidth(5),
                                                Container(
                                                  width: 1,
                                                  color: AppColor.grey8F94AE,
                                                  height: 15,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      suffix: const SizedBox()),
                                );
                              },
                            ),
                            yHeight(40),
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                final loginState = ref.watch(loginProvider);
                                return Btn(
                                  loading: loginState is LoginApiLoading,
                                  title: AppString.login,
                                  onTap: () {
                                    final isValid = Validator.instance.signUpValidator(phoneNumber: loginData.phoneController.text.trim());
                                    if(isValid){
                                      loginData.login();
                                    }else{
                                      toast(msg: Validator.instance.error);
                                    }
                                  },
                                );
                              },
                            ),
                            yHeight(40),
                          ],
                        ),
                      ),
                      const SizedBox(height: 500,),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: AppString.doNotHaveAnAccount,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 15.sp)),
                            TextSpan(
                                text: AppString.signUp,
                                recognizer: TapGestureRecognizer()..onTap = () => offAllNamed(context,Routes.signup),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: AppColor.primary,
                                )),
                          ],
                        ),
                      ).align(),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
