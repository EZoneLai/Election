中文
進入前
    進入頁面        file name  = Entry
        首次進入    class name = FirstEntryViewController
        QR掃描器    class name = QRReaderViewController
        行業選單    class name = OccupationViewController
        縣市選單    class name = CitysViewController
        區選單      class name = DistrictViewController
        里別選單    class name = VillageViewController
        申請帳號    class name = SignInViewController
        再次進入    class name = ReturnLoginViewController
        帳號登入    class name = LoginViewController
進入後
    主要頁面（首頁）  class name = MainViewController

    安卓分頁容器
        服務公告項   AnnouncementTabbarController
        福利        welfare



    功能分頁
        留言板      class name = BoardTabBarViewController

        服務器      class name = ServerViewController

        工具箱      class name = ToolboxViewController
            升級    class name = UpgradeViewController
            插件    class name = PluginViewController
            發送通知 class name = PushNoticeViewController
        控制台      class name = SetUpViewController
                   設定照片 class name = SetPhotoViewController

        檢視器      class name = ViewerViewController
                   區域圖示 class name = AreaIconViewController
                   關係圖示 class name = RelationViewController
                   選情資訊 class name = InformationViewController
        總部服務
            服務公告        class name = AnnouncementViewController
            公共政策          class name = PolicyViewController
        緊急事件處理 
            緊急處理指南    class name = EmergencyViewController
            服務團隊        class name = AidesViewController
            選民留言板       class name = PublicOpinionViewController
        話術輯      class name = ManuscriptViewController
        公司首頁    class name =  myHomePageViewController


QR彈出頁    segue id = showQREveryWhere 
           class name = popQRCodeViewController
留言板      segue id = board
總部服務公告 segue id = announcement
緊急事件處理 segue id = emergency
工具箱      segue id = toolbox
服務器      segue id = server
檢視器      segue id = viewer




