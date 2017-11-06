CQS.C_Sync();                                                                       //同步代码到CQS插件
CQS.C_SendMsg_QQ(QQ, msg);                                                          //发送私聊消息
CQS.C_SendMsg_Group(groupid, msg);                                                  //发送群消息
CQS.C_SendMsg_Discuss(discussid, msg);                                              //发送讨论组消息
CQS.C_SendLike(QQ);                                                                 //发送手机赞
CQS.C_SetGroupKick(groupid, QQID, rejectaddrequest)                                 //置群员移除
CQS.C_SetGroupBan(groupid, QQID, duration);                                         //置群员禁言
CQS.C_SetGroupAdmin(groupid, QQID, setadmin);                                       //置群管理员
CQS.C_SetGroupWholeBan(groupid, enableban);                                         //置全群禁言
CQS.C_SetGroupAnonymousBan(groupid, anomymous, duration);                           //置匿名群员禁言
CQS.C_SetGroupAnonymous(groupid, enableanomymous);                                  //置群匿名设置
CQS.C_SetGroupCard(groupid, QQID, newcard);                                         //置群成员名片
CQS.C_SetGroupLeave(groupid, isdismiss);                                            //置群退出
CQS.C_SetGroupSpecialTitle(groupid, QQID, newspecialtitle, duration);               //置群成员专属头衔
CQS.C_SetDiscussLeave(discussid);                                                   //置讨论组退出
CQS.C_SetFriendAddRequest(responseflag, responseoperation, remark);                 //置好友添加请求
CQS.C_SetGroupAddRequestV2(responseflag, requesttype, responseoperation, reason)    //置群添加请求
CQS.C_GetGroupMemberInfoV2(groupid, QQID, nocache);                                 //取群成员信息
CQS.C_GetStrangerInfo(QQID, nocache);                                               //取陌生人信息
CQS.C_AddLog(priority, category, content);                                          //日志
CQS.C_GetCookies();                                                                 //取Cookies
CQS.C_GetCsrfToken();                                                               //取CsrfToken
CQS.C_GetLoginQQ();                                                                 //取登录QQ
CQS.C_GetLoginNick();                                                               //取登录QQ昵称
CQS.C_GetAppDirectory();                                                            //取应用目录
CQS.C_SetFatal(errorinfo);                                                          //置致命错误提示
CQS.C_GetRecord(file, outformat);                                                   //接收语音
CQS.C_GetPicUrl(a);                                                                 //获取图片URL
CQS.C_Msgbox(a, b);                                                                 //在登陆酷Q的电脑上弹框
CQS.C_HttpGet(url, head);                                                           //发送GET请求
CQS.C_HttpPost(url, head, data);                                                    //发送POST请求
CQS.C_Smid(zhong, qian, hou, QnH, QHJ, QK);                                         //通过前后字符串截取数据
CQS.C_Len(a);                                                                       //获取字符串的长度
CQS.C_Mid(a, b, c);                                                                 //通过位置截取数据
CQS.C_Left(a, b);                                                                   //从左截取数据
CQS.C_Right(a, b);                                                                  //从右截取数据
CQS.C_trim(a);                                                                      //清除字符串前后空格
CQS.C_replace(a, b, c);                                                             //替换字符串里的内容




//同步代码到CQS插件
CQS.C_Sync();

//发送私聊消息
//QQID 目标QQ号
//msg 消息内容
CQS.C_SendMsg_QQ(QQ, msg);

//发送群消息
//groupid 群号
//msg 消息内容
CQS.C_SendMsg_Group(groupid, msg);

//发送讨论组消息
//discussid 讨论组号
//msg 消息内容
CQS.C_SendMsg_Discuss(discussid, msg);

//发送赞 发送手机赞
//QQID QQ号
CQS.C_SendLike(QQ);

//置群员移除
//groupid 目标群
//QQID QQ号
//rejectaddrequest 不再接收此人加群申请，请慎用
CQS.C_SetGroupKick(groupid, QQID, rejectaddrequest)

//置群员禁言
//groupid 目标群
//QQID QQ号
//duration 禁言的时间，单位为秒。如果要解禁，这里填写0。
CQS.C_SetGroupBan(groupid, QQID, duration);

//置群管理员
//groupid 目标群
//QQID QQ号
//setadmin true:设置管理员 false:取消管理员
CQS.C_SetGroupAdmin(groupid, QQID, setadmin);

//置全群禁言
//groupid 目标群
//enableban true:开启 false:关闭
CQS.C_SetGroupWholeBan(groupid, enableban);

//置匿名群员禁言
//groupid 目标群
//anomymous 群消息事件收到的 anomymous 参数
//duration 禁言的时间，单位为秒。不支持解禁。
CQS.C_SetGroupAnonymousBan(groupid, anomymous, duration);

//置群匿名设置
//groupid 目标群
//enableanomymous true:开启 false:关闭
CQS.C_SetGroupAnonymous(groupid, enableanomymous);

//置群成员名片
//groupid 目标群
//QQID 目标QQ
//newcard 新名片(昵称)
CQS.C_SetGroupCard(groupid, QQID, newcard);

//置群退出 慎用, 此接口需要严格授权
//groupid 目标群
//isdismiss 是否解散 true:解散本群(群主) false:退出本群(管理、群成员)
CQS.C_SetGroupLeave(groupid, isdismiss);

//置群成员专属头衔 需群主权限
//groupid 目标群
//QQID 目标QQ
//newspecialtitle 头衔（如果要删除，这里填空）
//duration 专属头衔有效期，单位为秒。如果永久有效，这里填写-1。
CQS.C_SetGroupSpecialTitle(groupid, QQID, newspecialtitle, duration);

//置讨论组退出
//discussid 目标讨论组号
CQS.C_SetDiscussLeave(discussid);

//置好友添加请求
//responseflag 请求事件收到的 responseflag 参数
//responseoperation REQUEST_ALLOW 或 REQUEST_DENY
//remark 添加后的好友备注
CQS.C_SetFriendAddRequest(responseflag, responseoperation, remark);

//置群添加请求
//responseflag 请求事件收到的 responseflag 参数
//requesttype根据请求事件的子类型区分 REQUEST_GROUPADD 或 REQUEST_GROUPINVITE
//responseoperation  REQUEST_ALLOW 或 REQUEST_DENY
//reason 操作理由，仅 REQUEST_GROUPADD 且 REQUEST_DENY 时可用
CQS.C_SetGroupAddRequestV2(responseflag, requesttype, responseoperation, reason)

//取群成员信息
//groupid 目标QQ所在群
//QQID 目标QQ号
//nocache 不使用缓存
CQS.C_GetGroupMemberInfoV2(groupid, QQID, nocache);

//取陌生人信息
//QQID 目标QQ
//nocache 不使用缓存
CQS.C_GetStrangerInfo(QQID, nocache);

//日志
//priority 优先级，CQLOG 开头的常量
//category 类型
//content 内容
CQS.C_AddLog(priority, category, content);

//取Cookies 慎用, 此接口需要严格授权
CQS.C_GetCookies();

//取CsrfToken 慎用, 此接口需要严格授权
CQS.C_GetCsrfToken();

//取登录QQ
CQS.C_GetLoginQQ();

//取登录QQ昵称
CQS.C_GetLoginNick();

//取应用目录，返回的路径末尾带"\"
CQS.C_GetAppDirectory();

//置致命错误提示
//errorinfo 错误信息
CQS.C_SetFatal(errorinfo);

//接收语音，接收消息中的语音(record),返回保存在 \data\record\ 目录下的文件名
//file 收到消息中的语音文件名(file)
//outformat 应用所需的语音文件格式，目前支持 mp3 amr wma m4a spx ogg wav flac
CQS.C_GetRecord(file, outformat);

//获取图片URL
//a 收到消息中的图片文件名
CQS.C_GetPicUrl(a);

//在登陆酷Q的电脑上弹框(调试用)
//a 弹框内容
//b 弹框标题
CQS.C_Msgbox(a, b);

//发送GET请求
//url 请求地址
//head 协议头(可选) 格式 xx:123123  一个换行一条
CQS.C_HttpGet(url, head);

//发送POST请求
//url 请求地址
//head 协议头(可选) 格式 xx:123123  一个换行一条
//data Post的数据(可选)
CQS.C_HttpPost(url, head, data);

//通过前后字符串截取数据(超级截取函数)
//zhong 需要截取的字符串
//qian 前字符串
//hou 后字符串
//QnH 后字符串从总字符串后面开始搜索(可选),0 为默认取消，1为设置
//QHJ 前字符串从总字符串后面开始搜索(可选),0 为默认取消，1为设置
//QK 后字符串从前字符串后面开始搜索(可选),0 为默认取消，1为设置
CQS.C_Smid(zhong, qian, hou, QnH, QHJ, QK);

//获取字符串的长度
//a 字符串
CQS.C_Len(a);

//通过位置截取数据
//a 需要截取的字符串
//b 开始截取位置(最小是1)
//c 截取长度(可选)
CQS.C_Mid(a, b, c);

//从左截取数据
//a 需要截取的字符串
//b 截取长度
CQS.C_Left(a, b);

//从右截取数据
//a 需要截取的字符串
//b 截取长度
CQS.C_Right(a, b);

//清除字符串前后空格
//a 字符串
CQS.C_trim(a);

//替换字符串里的内容
//a 字符串
//b 需要替换的字符
//c 替换后的字符
CQS.C_replace(a, b, c);