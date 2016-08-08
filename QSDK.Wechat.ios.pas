{ ******************************************************* }
{ QSDK.Wechat.iOS 1.0 }
{ Interfaces for libWeChatSDK 1.7.1 }
{ Created by TU2(Ticr),and agree to share with QSDK }
{ ******************************************************* }

unit QSDK.Wechat.ios;

interface

uses
  iOSapi.Foundation, FMX.Platform.ios, Macapi.ObjectiveC, iOSapi.UIKit,
  Macapi.Helpers,
  //����ĵ�Ԫ��΢�� SDK ��Ҫ��������ĵ�Ԫ
  System.ZLib {libz.dylib} , System.Sqlite {libsqlite3.0.dylib} ,
  iOSapi.CFNetwork, iOSapi.SCNetworkReachability, iOSapi.Security;

type
  BaseReq = interface;
  BaseResp = interface;
  SendAuthReq = interface;
  WXMediaMessage = interface;

  /// <summary>΢��Api�ӿں�������</summary>
  WXApi = interface(NSObject) // �������������󷽷�(-)
    ['{D2B85162-56EC-49A1-8147-44FF05A43147}']
  end;

  /// <summary>΢��Api�ӿں�����</summary>
  WXApiClass = interface(NSObjectClass) // �����������෽��(+)
    ['{1EFADA09-CB9B-4625-857D-733E00C5B266}']
    /// <summary>��΢���ն˳���ע�������Ӧ�á�</summary>
    /// <param name="appid">΢�ſ�����ID</param>
    /// <remarks>��Ҫ��ÿ������������Ӧ�ó���ʱ���á��뱣֤�����߳��е��ô˺�����
    /// ��һ�ε��ú󣬻���΢�ŵĿ���Ӧ���б��г��֡�
    /// iOS7������ϵͳ��Ҫ����һ��΢�ŲŻ������΢�ŵĿ���Ӧ���б��С�
    /// </remarks>
    function registerApp(appid: NSString): Boolean; cdecl;
    /// <summary>��΢���ն˳���ע�������Ӧ�á�</summary>
    /// <param name="appid">΢�ſ�����ID</param>
    /// <param name="appdesc">Ӧ�ø�����Ϣ�����Ȳ�����1024�ֽ�</param>
    /// <remarks>��Ҫ��ÿ������������Ӧ�ó���ʱ���á��뱣֤�����߳��е��ô˺�����
    /// ��һ�ε��ú󣬻���΢�ŵĿ���Ӧ���б��г��֡�
    /// iOS7������ϵͳ��Ҫ����һ��΢�ŲŻ������΢�ŵĿ���Ӧ���б��С�
    /// </remarks>
    [MethodName('registerApp:withDescription:')]
    function registerAppwithDescription(appid, appdesc: NSString)
      : Boolean; cdecl;
    /// <summary>��΢���ն˳���ע��Ӧ��֧�ִ򿪵��ļ����͡�</summary>
    /// <param name="typeFlag">Ӧ��֧�ִ򿪵���������,enAppSupportContentFlagö������ ��|�� ��������</param>
    /// <remarks>��Ҫ��ÿ������������Ӧ�ó���ʱ���á����ú󲢵�һ�γɹ��������ݵ�΢�ź󣬻���΢�ŵĿ���Ӧ���б��г��֡�</remarks>
    procedure registerAppSupportContentFlag(typeFlag: UInt64); cdecl;
    /// <summary>����΢��ͨ��URL����Appʱ���ݵ����ݡ�</summary>
    /// <param name="url">΢������������Ӧ��ʱ���ݹ�����URL</param>
    /// <param name="delegate">WXApiDelegate������������΢�Ŵ�������Ϣ</param>
    /// <remarks>��Ҫ�� application:openURL:sourceApplication:annotation:����application:handleOpenURL�е��á�</remarks>
    function handleOpenURL(url: NSURL; delegate: Pointer): Boolean; cdecl;
    /// <summary>���΢���Ƿ��ѱ��û���װ��</summary>
    function isWXAppInstalled: Boolean; cdecl;
    /// <summary>�жϵ�ǰ΢�ŵİ汾�Ƿ�֧��OpenApi��</summary>
    function isWXAppSupportApi: Boolean; cdecl;
    /// <summary>��ȡ΢�ŵ�itunes��װ��ַ��</summary>
    function getWXAppInstallUrl: NSString; cdecl;
    /// <summary>��ȡ��ǰ΢��SDK�İ汾�š�</summary>
    function getApiVersion: NSString; cdecl;
    /// <summary>��΢�š�</summary>
    function openWXApp: Boolean; cdecl;
    /// <summary>��������΢�ţ��ȴ�΢�ŷ���onResp��</summary>
    /// <param name="req">����ķ��������ڵ��ú��������Լ��ͷ�</param>
    /// <remarks>�������ú󣬻��л���΢�ŵĽ��档������Ӧ�ó���ȴ�΢�ŷ���onResp��
    /// ΢�����첽������ɺ�һ�������onResp��֧��SendAuthReq��SendMessageToWXReq��PayReq��</remarks>
    function sendReq(req: BaseReq): Boolean; cdecl;
    /// <summary>����Auth����΢�ţ�֧���û�û��װ΢�ţ��ȴ�΢�ŷ���onResp��</summary>
    /// <param name="req">����ķ��������ڵ��ú��������Լ��ͷ�</param>
    /// <param name="viewController">��ǰ�������</param>
    /// <param name="delegate">WXApiDelegate������������΢�Ŵ�������Ϣ</param>
    /// <remarks>�������ú󣬻��л���΢�ŵĽ��档������Ӧ�ó���ȴ�΢�ŷ���onResp��
    /// ΢�����첽������ɺ�һ�������onResp��֧��SendAuthReq���͡�</remarks>
    function SendAuthReq(req: SendAuthReq; viewController: UIViewController;
      delegate: Pointer): Boolean; cdecl;
    /// <summary>�յ�΢��onReq�����󣬷��Ͷ�Ӧ��Ӧ���΢�ţ����л���΢�Ž��档</summary>
    /// <param name="resp">�����Ӧ�����ݣ����ú��������Լ��ͷ�</param>
    /// <remarks>�������ú󣬻��л���΢�ŵĽ��档������Ӧ�ó����յ�΢��onReq�������첽�����������ɺ������øú�����
    /// ���ܷ��͵���Ӧ��GetMessageFromWXResp��ShowMessageFromWXResp�ȡ�</remarks>
    function sendResp(resp: BaseResp): Boolean; cdecl;
  end;

  TWXApi = class(TOCGenericImport<WXApiClass, WXApi>)
  end;

  // ------------------------------------------------------------------------------
  /// <summary>΢���ն�SDK����������Ϣ�Ļ���</summary>
  BaseReq = interface(NSObject)
    ['{2669AE3E-02DD-46B9-B1B8-7705A47FF5E6}']
    /// <summary>��������</summary>
    [MethodName('type:')]
    function _type: Integer; cdecl;
    procedure setType(AType: Integer); cdecl;
    /// <summary>���û�΢�źź�AppID��ɵ�Ψһ��ʶ</summary>
    /// <remarks>��������ʱ���������������д������У��΢���û��Ƿ񻻺ŵ�¼</remarks>
    function openID: NSString; cdecl;
    procedure setOpenID(openID: NSString); cdecl;
  end;

  /// <summary>��֤����</summary>
  SendAuthReq = interface(BaseReq)
    ['{0719D7AB-B0CB-4D16-8A64-6E270D9D98A7}']
    function scope: NSString; cdecl;
    /// <remarks>scope�ַ������Ȳ��ܳ���1K</remarks>
    procedure setScope(scope: NSString); cdecl;
    function state: NSString; cdecl;
    /// <remarks>state�ַ������Ȳ��ܳ���1K</remarks>
    procedure setState(state: NSString); cdecl;
  end;

  /// <summary>֧������</summary>
  PayReq = interface(BaseReq)
    ['{5B7DC0E5-386E-4B5F-AADE-EA646C8F40E5}']
    /// <summary>�̼���Ƹ�ͨ������̼�id</summary>
    function partnerId: NSString; cdecl;
    procedure setPartnerId(partnerId: NSString); cdecl;
    /// <summary>Ԥ֧������id</summary>
    function prepayId: NSString; cdecl;
    procedure setPrepayId(prepayId: NSString); cdecl;
    /// <summary>����������ط�</summary>
    function nonceStr: NSString; cdecl;
    procedure setNonceStr(nonceStr: NSString); cdecl;
    /// <summary>ʱ��������ط�</summary>
    function timeStamp: UInt32; cdecl;
    procedure setTimeStamp(timeStamp: UInt32); cdecl;
    /// <summary>�̼Ҹ��ݲƸ�ͨ�ĵ���д�����ݺ�ǩ��</summary>
    function package: NSString; cdecl;
    procedure setPackage(package: NSString); cdecl;
    /// <summary>�̼Ҹ���΢�ſ���ƽ̨�ĵ�����������ǩ��</summary>
    function sign: NSString; cdecl;
    procedure setSign(sign: NSString); cdecl;
  end;

  /// <summary>����ҵ�������</summary>
  HBReq = interface(BaseReq)
    ['{F0886BC2-E740-48C2-8B24-99CC9357B081}']
    /// <summary>����������ط�</summary>
    function nonceStr: NSString; cdecl;
    procedure setNonceStr(nonceStr: NSString); cdecl;
    /// <summary>ʱ��������ط�</summary>
    function timeStamp: UInt32; cdecl;
    procedure setTimeStamp(timeStamp: UInt32); cdecl;
    /// <summary>�̼Ҹ���΢����ҵ��������ĵ���д�����ݺ�ǩ��</summary>
    function package: NSString; cdecl;
    procedure setPackage(package: NSString); cdecl;
    /// <summary>�̼Ҹ���΢����ҵ��������ĵ�����������ǩ��</summary>
    function sign: NSString; cdecl;
    procedure setSign(sign: NSString); cdecl;
  end;

  /// <summary>����Ϣ����</summary>
  SendMessageToWXReq = interface(BaseReq)
    ['{97149A16-9975-406C-A992-4AEF5323CE7E}']
    /// <summary>������Ϣ���ı�����</summary>
    /// <remarks>�ı����ȱ������0��С��10K</remarks>
    function text: NSString; cdecl;
    procedure setText(text: NSString); cdecl;
    /// <summary>������Ϣ�Ķ�ý������</summary>
    function message: WXMediaMessage; cdecl;
    procedure setMessage(message: WXMediaMessage); cdecl;
    /// <summary>�Ƿ����ı���Ϣ</summary>
    function bText: Boolean; cdecl;
    procedure setBText(bText: Boolean); cdecl;
    /// <summary>Ŀ�곡����Ĭ�Ϸ��͵��Ự��</summary>
    function scene: Integer; cdecl;
    procedure setScene(scene: Integer); cdecl;
  end;

  SendMessageToWXReqClass = interface(NSObjectClass)
    ['{25BA201D-4209-4987-8A0B-249A0D3D8ED3}']
  end;

  TSendMessageToWXReq = class(TOCGenericImport<SendMessageToWXReqClass,
    SendMessageToWXReq>)
  end;

  /// <summary>����ʱ�Ự����</summary>
  OpenTempSessionReq = interface(BaseReq)
    ['{5E4F94F8-2526-471F-BAFE-CEECC7650822}']
    /// <summary>��Ҫ�򿪵��û���(���Ȳ��ܳ���512�ֽ�)</summary>
    function username: NSString; cdecl;
    procedure setUsername(username: NSString); cdecl;
    /// <summary>�������Զ��������������ʱ�Ự��ᷢ�������ߺ�̨����������ʶ�𳡾�(���Ȳ��ܳ���32λ)</summary>
    function sessionFrom: NSString; cdecl;
    procedure setSessionFrom(sessionFrom: NSString); cdecl;
  end;

  /// <summary>��ָ����ַ����</summary>
  OpenWebviewReq = interface(BaseReq)
    ['{D60EDE96-9B9A-4508-A68C-98C95C2972F1}']
    /// <summary>��Ҫ�򿪵���ҳ��Ӧ��Url(���Ȳ��ܳ���1024)</summary>
    function url: NSString; cdecl;
    procedure setUrl(url: NSString); cdecl;
  end;

  /// <summary>��Ӳ�����а�����</summary>
  OpenRankListReq = interface(BaseReq)
    ['{955D93EC-AA2F-4C4D-9193-D94EC81A1C37}']
  end;

  /// <summary>��ָ��΢�Ź��ں�profileҳ��</summary>
  JumpToBizProfileReq = interface(BaseReq)
    ['{141D08FA-D6B2-4BCC-8114-09639561AD87}']
    /// <summary>��ת���ù��ںŵ�profile(���Ȳ��ܳ���512�ֽ�)</summary>
    function username: NSString; cdecl;
    procedure setUsername(username: NSString); cdecl;
    /// <summary>����û����˸ù��ں�Ϊ���ѣ�extMsg���ϴ���������(���Ȳ��ܳ���1024�ֽ�)</summary>
    function extMsg: NSString; cdecl;
    procedure setExtMsg(extMsg: NSString); cdecl;
    /// <summary>��ת�Ĺ��ں�����</summary>
    function profileType: Integer; cdecl;
    procedure setProfileType(profileType: Integer); cdecl;
  end;

  /// <summary>��ָ��΢�Ź��ں�profile��ҳ��</summary>
  JumpToBizWebviewReq = interface(BaseReq)
    ['{3154F62A-9D93-4ABC-AE24-CA547B211249}']
    /// <summary>��ת����ҳ���ͣ�Ŀǰֻ֧�ֹ��ҳ</summary>
    function webType: Integer; cdecl;
    procedure setWebType(webType: Integer); cdecl;
    /// <summary>��ת���ù��ںŵ�profile��ҳ��(���Ȳ��ܳ���512�ֽ�)</summary>
    function tousrname: NSString; cdecl;
    procedure setTousrname(tousrname: NSString); cdecl;
    /// <summary>����û����˸ù��ں�Ϊ���ѣ�extMsg���ϴ���������(���Ȳ��ܳ���1024�ֽ�)</summary>
    function extMsg: NSString; cdecl;
    procedure setExtMsg(extMsg: NSString); cdecl;
  end;

  /// <summary>������ӿ�ȯ</summary>
  AddCardToWXCardPackageReq = interface(BaseReq)
    ['{F7547572-9BD0-431F-8AAA-DE8FB0AB8814}']
    /// <summary>���б��������ܳ���40��WXCardItem��</summary>
    function cardAry: NSArray; cdecl;
    procedure setCardAry(cardAry: NSArray); cdecl;
  end;

  /// <summary>����ѡȡ��ȯ</summary>
  WXChooseCardReq = interface(BaseReq)
    ['{B9B20AC0-C4CC-4CB2-B3D5-EFC32EF56CCF}']
    function appid: NSString; cdecl;
    procedure setAppID(appid: NSString); cdecl;
    function shopID: UInt32; cdecl;
    procedure setShopID(shopID: UInt32); cdecl;
    function canMultiSelect: UInt32; cdecl;
    procedure setCanMultiSelect(canMultiSelect: UInt32); cdecl;
    function cardType: NSString; cdecl;
    procedure setCardType(cardType: NSString); cdecl;
    function cardTpID: NSString; cdecl;
    procedure setCardTpID(cardTpID: NSString); cdecl;
    function signType: NSString; cdecl;
    procedure setSignType(signType: NSString); cdecl;
    function cardSign: NSString; cdecl;
    procedure setCardSign(cardSign: NSString); cdecl;
    function timeStamp: UInt32; cdecl;
    procedure setTimeStamp(timeStamp: UInt32); cdecl;
    function nonceStr: NSString; cdecl;
    procedure setNonceStr(nonceStr: NSString); cdecl;
  end;

  /// <summary>΢�������ṩ���ݵ���Ϣ</summary>
  GetMessageFromWXReq = interface(BaseReq)
    ['{A78D6373-B23A-4EAC-958B-F90F3304226D}']
    function lang: NSString; cdecl;
    procedure setLang(lang: NSString); cdecl;
    function country: NSString; cdecl;
    procedure setCountry(country: NSString); cdecl;
  end;

  /// <summary>΢��֪ͨ��ʾ���ݵ���Ϣ</summary>
  ShowMessageFromWXReq = interface(BaseReq)
    ['{0AC5F853-9268-4223-85EA-E405F61BA277}']
    /// <summary>�����������账��Ķ�ý������</summary>
    function message: WXMediaMessage; cdecl;
    procedure setMessage(message: WXMediaMessage); cdecl;
    function lang: NSString; cdecl;
    procedure setLang(lang: NSString); cdecl;
    function country: NSString; cdecl;
    procedure setCountry(country: NSString); cdecl;
  end;

  /// <summary>΢�ŷ��͵Ĵ�������Ϣ��������Ӧ��</summary>
  LaunchFromWXReq = interface(BaseReq)
    ['{18AC138F-C24F-490B-8C6A-CAEAC8294241}']
    /// <summary>�����������账��Ķ�ý������</summary>
    function message: WXMediaMessage; cdecl;
    procedure setMessage(message: WXMediaMessage); cdecl;
    function lang: NSString; cdecl;
    procedure setLang(lang: NSString); cdecl;
    function country: NSString; cdecl;
    procedure setCountry(country: NSString); cdecl;
  end;

  // ------------------------------------------------------------------------------
  /// <summary>����Ϊ΢���ն�SDK������Ӧ��Ϣ�Ļ���</summary>
  BaseResp = interface(NSObject)
    ['{535824F8-CAE8-4C73-A688-136A72745D38}']
    /// <summary>������</summary>
    function errCode: Integer; cdecl;
    procedure setErrCode(errCode: Integer); cdecl;
    /// <summary>������ʾ�ַ���</summary>
    function errStr: NSString; cdecl;
    procedure setErrStr(errStr: NSString); cdecl;
    /// <summary>��Ӧ����</summary>
    [MethodName('type:')]
    function _type: Integer; cdecl;
    procedure setType(AType: Integer); cdecl;
  end;

  /// <summary>��֤��Ӧ</summary>
  SendAuthResp = interface(BaseResp)
    ['{42C82024-4966-456A-98A4-164F7F1269A0}']
    function code: NSString; cdecl;
    procedure setCode(code: NSString); cdecl;
    function state: NSString; cdecl;
    procedure setState(state: NSString); cdecl;
    function lang: NSString; cdecl;
    procedure setLang(lang: NSString); cdecl;
    function country: NSString; cdecl;
    procedure setCountry(country: NSString); cdecl;
  end;

  /// <summary>֧����Ӧ</summary>
  PayResp = interface(BaseResp)
    ['{BD7E06A1-1EC0-4150-86D7-F83BE56BDA33}']
    function returnKey: NSString; cdecl;
    procedure setReturnKey(returnKey: NSString); cdecl;
  end;

  /// <summary>����ҵ�����Ӧ</summary>
  HBResp = interface(BaseResp)
    ['{C702597C-8F91-4EA0-AA06-01BB91F71E4A}']
  end;

  /// <summary>����Ϣ��Ӧ</summary>
  SendMessageToWXResp = interface(BaseResp)
    ['{3F183020-33C1-469A-8689-DB9CE8C62F1C}']
    function lang: NSString; cdecl;
    procedure setLang(lang: NSString); cdecl;
    function country: NSString; cdecl;
    procedure setCountry(country: NSString); cdecl;
  end;

  /// <summary>����ʱ�Ự��Ӧ</summary>
  OpenTempSessionResp = interface(BaseResp)
    ['{8934A492-0051-4E83-B652-5D685ED573EE}']
  end;

  /// <summary>��ָ����ַ��Ӧ</summary>
  OpenWebviewResp = interface(BaseResp)
    ['{E132F3B9-471C-4F6E-B5AA-89181CEF4069}']
  end;

  /// <summary>��Ӳ�����а���Ӧ</summary>
  OpenRanklistResp = interface(BaseResp)
    ['{FC4635D7-8680-4526-94DD-9AFD6E1AD5A1}']
  end;

  /// <summary>������ӿ�ȯ��Ӧ</summary>
  AddCardToWXCardPackageResp = interface(BaseResp)
    ['{44A8BDC7-0366-4566-B52C-BCC0527090EA}']
    /// <summary>���б��������ܳ���40��WXCardItem��</summary>
    function cardAry: NSArray; cdecl;
    procedure setCardAry(cardAry: NSArray); cdecl;
  end;

  /// <summary>����ѡȡ��ȯ��Ӧ</summary>
  WXChooseCardResp = interface(BaseResp)
    ['{72913849-CE84-4964-81CC-643B7F110695}']
    /// <summary>���б��������ܳ���40��WXCardItem��</summary>
    function cardAry: NSArray; cdecl;
    procedure setCardAry(cardAry: NSArray); cdecl;
  end;

  /// <summary>΢�������ṩ���ݵ���Ӧ</summary>
  GetMessageFromWXResp = interface(BaseResp)
    ['{59AA8D34-236E-4983-B27C-C0E252DCE551}']
    /// <summary>��΢���ն��ṩ���ı�����</summary>
    /// <remarks>�ı����ȱ������0��С��10K</remarks>
    function text: NSString; cdecl;
    procedure setText(text: NSString); cdecl;
    /// <summary>��΢���ն��ṩ�Ķ�ý������</summary>
    function message: WXMediaMessage; cdecl;
    procedure setMessage(message: WXMediaMessage); cdecl;
    /// <summary>�Ƿ����ı���Ϣ</summary>
    function bText: Boolean; cdecl;
    procedure setBText(bText: Boolean); cdecl;
  end;

  /// <summary>΢��֪ͨ��ʾ���ݵ���Ӧ</summary>
  ShowMessageFromWXResp = interface(BaseResp)
    ['{7C91EA04-C0A0-417F-9C61-07DF77091877}']
  end;

  // ------------------------------------------------------------------------------
  /// <summary>��ý����Ϣ</summary>
  WXMediaMessage = interface(NSObject)
    ['{DBE9475E-43DE-4699-9D5F-41AC0D6666CA}']
    /// <summary>����(���Ȳ��ܳ���512�ֽ�)</summary>
    function title: NSString; cdecl;
    procedure setTitle(title: NSString); cdecl;
    /// <summary>��������(���Ȳ��ܳ���1K)</summary>
    function description: NSString; cdecl;
    procedure setDescription(description: NSString); cdecl;
    /// <summary>����ͼ����(��С���ܳ���32K)</summary>
    function thumbData: NSData; cdecl;
    procedure setThumbData(thumbData: NSData); cdecl;
    /// <summary>ý���ǩ��(���Ȳ��ܳ���64�ֽ�)</summary>
    function mediaTagName: NSString; cdecl;
    procedure setMediaTagName(mediaTagName: NSString); cdecl;
    function messageExt: NSString; cdecl;
    procedure setMessageExt(messageExt: NSString); cdecl;
    function messageAction: NSString; cdecl;
    procedure setMessageAction(messageAction: NSString); cdecl;
    /// <summary>��ý�����ݶ��󣬿���ΪWXImageObject��WXMusicObject��WXVideoObject��WXWebpageObject��</summary>
    function mediaObject: Pointer; cdecl;
    procedure setMediaObject(mediaObject: Pointer); cdecl;
    /// <summary>������Ϣ����ͼ(��С���ܳ���32K)</summary>
    procedure setThumbImage(image: UIImage); cdecl;
  end;

  WXMediaMessageClass = interface(NSObjectClass)
    ['{E47D92D1-ED26-419E-840A-CACFD7797FC4}']
    function message: WXMediaMessage; cdecl;
  end;

  TWXMediaMessage = class(TOCGenericImport<WXMediaMessageClass, WXMediaMessage>)
  end;

  /// <summary>ͼƬ���ݶ���</summary>
  WXImageObject = interface(NSObject)
    ['{5A346557-3ABB-4BEE-9E0A-03ABA319737F}']
    /// <summary>ͼƬ��ʵ��������(��С���ܳ���10M)</summary>
    function imageData: NSData; cdecl;
    procedure setImageData(imageData: NSData); cdecl;
  end;

  WXImageObjectClass = interface(NSObjectClass)
    ['{57F80B15-17FF-4C18-977E-8706DE5BE724}']
    [MethodName('object')]
    function _object: WXImageObject; cdecl;
  end;

  TWXImageObject = class(TOCGenericImport<WXImageObjectClass, WXImageObject>)
  end;

  /// <summary>�������ݶ���</summary>
  WXMusicObject = interface(NSObject)
    ['{9EFD0E25-7B2A-4044-ACB0-220EF151E0FC}']
    /// <summary>������ҳ��url��ַ(���Ȳ��ܳ���10K)</summary>
    function musicUrl: NSString; cdecl;
    procedure setMusicUrl(musicUrl: NSString); cdecl;
    /// <summary>����lowband��ҳ��url��ַ(���Ȳ��ܳ���10K)</summary>
    function musicLowBandUrl: NSString; cdecl;
    procedure setMusicLowBandUrl(musicLowBandUrl: NSString); cdecl;
    /// <summary>��������url��ַ(���Ȳ��ܳ���10K)</summary>
    function musicDataUrl: NSString; cdecl;
    procedure setMusicDataUrl(musicDataUrl: NSString); cdecl;
    /// <summary>����lowband����url��ַ(���Ȳ��ܳ���10K)</summary>
    function musicLowBandDataUrl: NSString; cdecl;
    procedure setMusicLowBandDataUrl(musicLowBandDataUrl: NSString); cdecl;
  end;

  WXMusicObjectClass = interface(NSObjectClass)
    ['{FF46237F-F8BC-4444-A96C-CC40901406D7}']
    /// <summary>����һ��WXMusicObject����(�Զ��ͷ�)</summary>
    [MethodName('object')]
    function _object: WXMusicObject; cdecl;
  end;

  TWXMusicObject = class(TOCGenericImport<WXMusicObjectClass, WXMusicObject>)
  end;

  /// <summary>��Ƶ���ݶ���</summary>
  WXVideoObject = interface(NSObject)
    ['{DF30900E-6A3E-4296-98A9-E1DE67D18703}']
    /// <summary>��Ƶ��ҳ��url��ַ(���Ȳ��ܳ���10K)</summary>
    function videoUrl: NSString; cdecl;
    procedure setVideoUrl(videoUrl: NSString); cdecl;
    /// <summary>��Ƶlowband��ҳ��url��ַ(���Ȳ��ܳ���10K)</summary>
    function videoLowBandUrl: NSString; cdecl;
    procedure setVideoLowBandUrl(videoLowBandUrl: NSString); cdecl;
  end;

  WXVideoObjectClass = interface(NSObjectClass)
    ['{BC4FA2FD-C81E-4D72-8626-C3BEAC1CDB6C}']
    [MethodName('object')]
    function _object: WXVideoObject; cdecl;
  end;

  TWXVideoObject = class(TOCGenericImport<WXVideoObjectClass, WXVideoObject>)
  end;

  /// <summary>��ҳ���ݶ���</summary>
  WXWebpageObject = interface(NSObject)
    ['{4A693270-7940-4D5E-A659-87A2867D72DE}']
    /// <summary>��ҳ��url��ַ(���Ȳ��ܳ���10K)</summary>
    function webpageUrl: NSString; cdecl;
    procedure setWebpageUrl(webpageUrl: NSString); cdecl;
  end;

  WXWebpageObjectClass = interface(NSObjectClass)
    ['{619F490C-4C0A-427D-B2EE-C5B924EBEDC9}']
    [MethodName('object')]
    function _object: WXWebpageObject; cdecl;
  end;

  TWXWebpageObject = class(TOCGenericImport<WXWebpageObjectClass,
    WXWebpageObject>)
  end;

  /// <summary>App��չ���ݶ���</summary>
  WXAppExtendObject = interface(NSObject)
    ['{2AC0B025-CC2C-4B07-AF1A-57614450DC6F}']
    /// <summary>�����������򲻴��ڣ�΢���ն˻�򿪸�url��ָ��App���ص�ַ(���Ȳ��ܳ���10K)</summary>
    function url: NSString; cdecl;
    procedure setUrl(url: NSString); cdecl;
    /// <summary>�����������Զ�������ݣ�΢���ն˻�ش���������������(���Ȳ��ܳ���2K)</summary>
    function extInfo: NSString; cdecl;
    procedure setExtInfo(extInfo: NSString); cdecl;
    /// <summary>App�ļ����ݣ������ݷ��͸�΢�ź��ѣ�΢�ź�����Ҫ������������ݣ�΢���ն˻�ش���������������(���ܳ���10M)</summary>
    function fileData: NSData; cdecl;
    procedure setFileData(fileData: NSData); cdecl;
  end;

  WXAppExtendObjectClass = interface(NSObjectClass)
    ['{57D0899C-454D-4A97-B77E-3C1CAB515239}']
    [MethodName('object')]
    function _object: WXAppExtendObject; cdecl;
  end;

  TWXAppExtendObject = class(TOCGenericImport<WXAppExtendObjectClass,
    WXAppExtendObject>)
  end;

  WXEmoticonObject = interface(NSObject)
    ['{468BA611-B5EC-4546-A8BD-56EC57F0931C}']
    /// <summary>������ʵ��������(���ܳ���10M)</summary>
    function emoticonData: NSData; cdecl;
    procedure setEmoticonData(emoticonData: NSData); cdecl;
  end;

  WXEmoticonObjectClass = interface(NSObjectClass)
    ['{CF96FDDA-4AE9-443A-903C-F7D76FA1DA5B}']
    [MethodName('object')]
    function _object: WXEmoticonObject; cdecl;
  end;

  TWXEmoticonObject = class(TOCGenericImport<WXEmoticonObjectClass,
    WXEmoticonObject>)
  end;

  WXFileObject = interface(NSObject)
    ['{B8B681B2-5CA8-425B-B802-41F63A4C1A73}']
    /// <summary>�ļ���׺��(���Ȳ��ܳ���64B)</summary>
    function fileExtension: NSString; cdecl;
    procedure setFileExtension(fileExtension: NSString); cdecl;
    /// <summary>�ļ���ʵ��������(���ܳ���10M)</summary>
    function fileData: NSData; cdecl;
    procedure setFileData(fileData: NSData); cdecl;
  end;

  WXFileObjectClass = interface(NSObjectClass)
    ['{7FE49721-CC4B-4E0E-8B52-D3EF481FB642}']
    [MethodName('object')]
    function _object: WXFileObject; cdecl;
  end;

  TWXFileObject = class(TOCGenericImport<WXFileObjectClass, WXFileObject>)
  end;

  WXLocationObject = interface(NSObject)
    ['{F2817744-0887-4BF6-B31E-8DF1CF2CA434}']
    /// <summary>����</summary>
    function lng: Double; cdecl;
    procedure setLng(lng: Double); cdecl;
    /// <summary>γ��</summary>
    function lat: Double; cdecl;
    procedure setLat(lat: Double); cdecl;
  end;

  WXLocationObjectClass = interface(NSObjectClass)
    ['{F3426D6B-0BDF-497B-8086-95DAF300D660}']
    [MethodName('object')]
    function _object: WXLocationObject; cdecl;
  end;

  TWXLocationObject = class(TOCGenericImport<WXLocationObjectClass,
    WXLocationObject>)
  end;

  WXTextObject = interface(NSObject)
    ['{816ABB06-F0FA-4DF7-A7E8-90399C783806}']
    /// <summary>�ı�����</summary>
    function contentText: NSString; cdecl;
    procedure setContentText(contentText: NSString); cdecl;
  end;

  WXTextObjectClass = interface(NSObjectClass)
    ['{01B24EA7-9EFB-46A9-B470-A778AA87EDBC}']
    [MethodName('object')]
    function _object: WXTextObject; cdecl;
  end;

  TWXTextObject = class(TOCGenericImport<WXTextObjectClass, WXTextObject>)
  end;

  /// <summary>��ȯ</summary>
  WXCardItem = interface(NSObject)
    ['{97C86C90-37A8-4B9D-A6A7-276DBB42A168}']
    /// <summary>��id(���Ȳ��ܳ���512�ֽ�)</summary>
    function cardId: NSString; cdecl;
    procedure setCardId(cardId: NSString); cdecl;
    /// <summary>ext��Ϣ(���Ȳ��ܳ���2024�ֽ�)</summary>
    function extMsg: NSString; cdecl;
    procedure setExtMsg(extMsg: NSString); cdecl;
    /// <summary>����״̬,req����Ҫ��(resp:0Ϊδ��ӣ�1Ϊ�����)</summary>
    function cardState: UInt32; cdecl;
    procedure setCardState(cardState: UInt32); cdecl;
    /// <remarks>req����Ҫ�chooseCard���ص�</remarks>
    function encryptCode: NSString; cdecl;
    procedure setEncryptCode(encryptCode: NSString); cdecl;
    /// <remarks>req����Ҫ�chooseCard���ص�</remarks>
    function appid: NSString; cdecl;
    procedure setAppID(appid: NSString); cdecl;
  end;

  WXCardItemClass = interface(NSObjectClass)
    ['{52B17245-F914-4970-B4F2-637948A15022}']
    { class method declarations }
  end;

  TWXCardItem = class(TOCGenericImport<WXCardItemClass, WXCardItem>)
  end;

  WechatAuthSDK = interface(NSObject)
    ['{148DE279-2C4F-4777-A6FF-E7BCAEF953D2}']
    /// <summary> WechatAuthAPIDelegate</summary>
    function delegate: Pointer; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    /// <summary>authSDK�汾��</summary>
    function sdkVersion: NSString; cdecl;
    procedure setSdkVersion(sdkVersion: NSString); cdecl;
    /// <summary>���͵�¼���󣬵ȴ�WechatAuthAPIDelegate�ص�</summary>
    /// <param name="appId">΢�ſ�����ID</param>
    /// <param name="nonceStr">һ������ľ������ظ����ַ���������ʹ��ÿ�ε�signature��ͬ</param>
    /// <param name="timeStamp">ʱ���</param>
    /// <param name="scope">Ӧ����Ȩ������ӵ�ж���������ö��ţ�,���ָ�</param>
    /// <param name="signature">ǩ��</param>
    /// <param name="schemeData">����ɨ���ƴ��scheme��</param>
    /// <remarks>��ʵ��ֻ��֤ͬʱֻ��һ��Auth�����У�Authδ��ɻ�δStop�ٴε���Auth�ӿ�ʱ�᷵��False</remarks>
    function Auth(appid, nonceStr, timeStamp, scope, signature,
      schemeData: NSString): Boolean; cdecl;
    /// <summary>��ͣ��¼����</summary>
    function StopAuth: Boolean; cdecl;
  end;

  WechatAuthSDKClass = interface(NSObjectClass)
    ['{14058241-BD3B-42C7-90D0-D3F0D2B6CF41}']
    { class method declarations }
  end;

  TWechatAuthSDK = class(TOCGenericImport<WechatAuthSDKClass, WechatAuthSDK>)
  end;

  /// <summary>���ղ���������΢���ն˳�����¼�ί��</summary>
  WXApiDelegate = interface(IObjectiveC)
    ['{892B17F1-1C38-497B-B6E6-12A451B09D6B}']
    /// <summary>�յ�һ������΢�ŵ�����</summary>
    /// <param name="req">�����������ݣ����Զ��ͷŵ�</param>
    /// <remarks>������Ӧ�ó����첽������ɺ�������sendResp���ʹ�������΢�š������յ���������GetMessageFromWXReq��ShowMessageFromWXReq�ȡ�</remarks>
    procedure onReq(req: BaseReq); cdecl;
    /// <summary>����һ��sendReq���յ�΢�ŵĻ�Ӧ</summary>
    /// <param name="resp">����Ļ�Ӧ���ݣ����Զ��ͷŵ�</param>
    /// <remarks>�����յ��Ĵ�������SendMessageToWXResp��SendAuthResp�ȡ�</remarks>
    procedure onResp(resp: BaseResp); cdecl;
  end;

  WechatAuthAPIDelegate = interface(IObjectiveC)
    ['{44080D14-CDAE-4178-938A-268438059B7C}']
    /// <summary>�õ���ά��</summary>
    procedure onAuthGotQrcode(image: UIImage); cdecl;
    /// <summary>��ά�뱻ɨ��</summary>
    procedure onQrcodeScanned; cdecl;
    /// <summary>�ɹ���¼</summary>
    procedure onAuthFinish(errCode: Integer; authCode: NSString); cdecl;
  end;

  TWeChatHelper = class(TOCLocal, WXApiDelegate)
  private
    class

      var WCH: TWeChatHelper;
    class function GetDefault: TWeChatHelper; static;
  public
    /// <summary>���΢���Ƿ��ѱ��û���װ��</summary>
    /// <remarks>�÷�����ʧЧ</remarks>
    class function isWXAppInstalled: Boolean;
    /// <summary>�жϵ�ǰ΢�ŵİ汾�Ƿ�֧��OpenApi</summary>
    /// <remarks>�÷�����ʧЧ</remarks>
    class function isWXAppSupportApi: Boolean;
    /// <summary>��ȡ΢�ŵ�itunes��װ��ַ��</summary>
    class function getWXAppInstallUrl: string;
    /// <summary>��ȡ��ǰ΢��SDK�İ汾�š�</summary>
    class function getApiVersion: string;
    class property Default: TWeChatHelper read GetDefault;
  private
    FScene: Integer;
  protected
    { WXApiDelegate }
    procedure onReq(req: BaseReq); cdecl;
    procedure onResp(resp: BaseResp); cdecl;
  public
    function registerApp(const appid: string;
      const appdesc: string = ''): Boolean;
    /// <summary>��΢�š�</summary>
    function openWXApp: Boolean;
    function DoHandleOpenURL(AContext: TObject): Boolean;
    procedure SendMessageToWX(const AText: string);
    property scene: Integer read FScene write FScene;
  end;

const
  /// <summary>���ͳ������������</summary>
  WXSceneSession = 0;
  /// <summary>���ͳ���������Ȧ</summary>
  WXSceneTimeline = 1;
  /// <summary>���ͳ������ղ�</summary>
  WXSceneFavorite = 2;

  /// <summary>��תprofile���ͣ���ͨ���ں�</summary>
  WXBizProfileType_Normal = 0;
  /// <summary>��תprofile���ͣ�Ӳ�����ں�</summary>
  WXBizProfileType_Device = 1;
  /// <summary>��תprofile��ҳ�����ͣ������ҳ</summary>
  WXMPWebviewType_Ad = 0;

  /// <summary>�ɹ�</summary>
  WXSuccess = 0;
  /// <summary>��ͨ��������</summary>
  WXErrCodeCommon = -1;
  /// <summary>�û����ȡ��������</summary>
  WXErrCodeUserCancel = -2;
  /// <summary>����ʧ��</summary>
  WXErrCodeSentFail = -3;
  /// <summary>��Ȩʧ��</summary>
  WXErrCodeAuthDeny = -4;
  /// <summary>΢�Ų�֧��</summary>
  WXErrCodeUnsupport = -5;

  WXAPISupportSession = 0;

  // Ӧ��֧�ֽ���΢�ŵ��ļ�����
  MMAPP_SUPPORT_NOCONTENT = $0;
  MMAPP_SUPPORT_TEXT = $1;
  MMAPP_SUPPORT_PICTURE = $2;
  MMAPP_SUPPORT_LOCATION = $4;
  MMAPP_SUPPORT_VIDEO = $8;
  MMAPP_SUPPORT_AUDIO = $10;
  MMAPP_SUPPORT_WEBPAGE = $20;
  // Suport File Type
  MMAPP_SUPPORT_DOC = $40; // doc
  MMAPP_SUPPORT_DOCX = $80; // docx
  MMAPP_SUPPORT_PPT = $100; // ppt
  MMAPP_SUPPORT_PPTX = $200; // pptx
  MMAPP_SUPPORT_XLS = $400; // xls
  MMAPP_SUPPORT_XLSX = $800; // xlsx
  MMAPP_SUPPORT_PDF = $1000; // pdf

  WechatAuth_Err_Ok = 0; // Auth�ɹ�
  WechatAuth_Err_NormalErr = -1; // ��ͨ����
  WechatAuth_Err_NetworkErr = -2; // �������
  WechatAuth_Err_GetQrcodeFailed = -3; // ��ȡ��ά��ʧ��
  WechatAuth_Err_Cancel = -4; // �û�ȡ����Ȩ
  WechatAuth_Err_Timeout = -5; // ��ʱ

implementation

{$IFDEF CPUARM}
{$O-}
function WXApi_FakeLoader: WXApi; cdecl;
  external 'libWeChatSDK.a' name 'OBJC_CLASS_$_WXApi';
{$O+}
{$ENDIF}

{ TWeChatHelper }
class function TWeChatHelper.getApiVersion: string;
begin
  Result := NSStrToStr(TWXApi.OCClass.getApiVersion);
end;

class function TWeChatHelper.getWXAppInstallUrl: string;
begin
  Result := NSStrToStr(TWXApi.OCClass.getWXAppInstallUrl);
end;

class function TWeChatHelper.isWXAppInstalled: Boolean;
begin
  Result := TWXApi.OCClass.isWXAppInstalled;
end;

class function TWeChatHelper.isWXAppSupportApi: Boolean;
begin
  Result := TWXApi.OCClass.isWXAppSupportApi;
end;

class function TWeChatHelper.GetDefault: TWeChatHelper;
begin
  if WCH = nil then
  begin
    WCH := TWeChatHelper.Create;
  end;
  Result := WCH;
end;

function TWeChatHelper.registerApp(const appid, appdesc: string): Boolean;
begin
  if (appdesc = '') then
    Result := TWXApi.OCClass.registerApp(StrToNSStr(appid))
  else
    Result := TWXApi.OCClass.registerAppwithDescription(StrToNSStr(appid),
      StrToNSStr(appdesc));
end;

function TWeChatHelper.openWXApp: Boolean;
begin
  Result := TWXApi.OCClass.openWXApp;
end;

function TWeChatHelper.DoHandleOpenURL(AContext: TObject): Boolean;
begin
  Result := TWXApi.OCClass.handleOpenURL
    (StrToNSUrl(TiOSOpenApplicationContext(AContext).url), GetObjectID);
end;

procedure TWeChatHelper.SendMessageToWX(const AText: string);
var
  req: SendMessageToWXReq;
begin
  req := TSendMessageToWXReq.Wrap(TSendMessageToWXReq.Alloc.init);
  req.setText(StrToNSStr(AText));
  req.setBText(True);
  req.setScene(FScene);
  TWXApi.OCClass.sendReq(req);
end;

procedure TWeChatHelper.onReq(req: BaseReq);
begin
  // {
  // if([req isKindOfClass:[GetMessageFromWXReq class]])
  // {
  // // ΢������App�ṩ���ݣ� ��Ҫapp�ṩ���ݺ�ʹ��sendRsp����
  // NSString *strTitle = [NSString stringWithFormat:@"΢������App�ṩ����"];
  // NSString *strMsg = @"΢������App�ṩ���ݣ�AppҪ����sendResp:GetMessageFromWXResp���ظ�΢��";
  //
  // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  // alert.tag = 1000;
  // [alert show];
  // [alert release];
  // }
  // else if([req isKindOfClass:[ShowMessageFromWXReq class]])
  // {
  // ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
  // WXMediaMessage *msg = temp.message;
  //
  // //��ʾ΢�Ŵ�����������
  // WXAppExtendObject *obj = msg.mediaObject;
  //
  // NSString *strTitle = [NSString stringWithFormat:@"΢������App��ʾ����"];
  // NSString *strMsg = [NSString stringWithFormat:@"���⣺%@ \n���ݣ�%@ \n������Ϣ��%@ \n����ͼ:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
  //
  // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  // [alert show];
  // [alert release];
  // }
  // else if([req isKindOfClass:[LaunchFromWXReq class]])
  // {
  // //��΢������App
  // NSString *strTitle = [NSString stringWithFormat:@"��΢������"];
  // NSString *strMsg = @"���Ǵ�΢����������Ϣ";
  //
  // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  // [alert show];
  // [alert release];
  // }
  // }

end;

procedure TWeChatHelper.onResp(resp: BaseResp);
begin
  // -(void) onResp:(BaseResp*)resp
  // {
  // if([resp isKindOfClass:[SendMessageToWXResp class]])
  // {
  // NSString *strTitle = [NSString stringWithFormat:@"����ý����Ϣ���"];
  // NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
  //
  // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  // [alert show];
  // [alert release];
  // }
  // }

end;

end.
