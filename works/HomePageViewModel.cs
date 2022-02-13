using EasyConnector.Behaviors;
using EasyConnector.DataManager;
using EasyConnector.DataModel.Client;
using EasyConnector.Helpers;
using EasyConnector.Resx;
using Prism.Commands;
using Prism.Navigation;
using Xamarin.Forms;

namespace EasyConnector.ViewModels
{
    public class HomePageViewModel : ViewModelBase
    {
        protected static bool UpdateChecked = false;
        /// <summary>
        /// Route background img path.
        /// </summary>
        public string RouteImg
        {
            get
            {
                if (Session.Site.Id == AppConstants.SU_ZHOU_SITE_ID)
                    return PlatformStaicResource("suzhou_bg_route.png");
                return PlatformStaicResource("bg_route.png");
            }
        }
        /// <summary>
        /// Map background img path
        /// </summary>
        public string MapImg
        {
            get
            {
                if (Session.Site.Id == AppConstants.SU_ZHOU_SITE_ID)
                    return PlatformStaicResource("suzhou_bg_map.png");
                return PlatformStaicResource("bg_map.png");
            }
        }

        /// <summary>
        /// Notification background img path.
        /// </summary>
        public string NotificationImg
        {
            get
            {
                if (Session.Site.Id == AppConstants.SU_ZHOU_SITE_ID)
                    return PlatformStaicResource("suzhou_bg_notification.png");
                return PlatformStaicResource("bg_notification.png");
            }
        }

        /// <summary>
        /// Feedback background img path.
        /// </summary>
        public string FeedbackImg
        {
            get
            {
                if (Session.Site.Id == AppConstants.SU_ZHOU_SITE_ID)
                    return PlatformStaicResource("suzhou_bg_feedback.png");
                return PlatformStaicResource("bg_feedback.png");
            }
        }

        /// <summary>
        /// Return title color base site id
        /// </summary>
        public string TileLabelColor
        {
            get
            {
                if (Session.Site.Id == AppConstants.SU_ZHOU_SITE_ID)
                    return "#2c2c2c";
                return "#CCC";
            }
        }
        public DelegateCommand SwitchSiteCommand { get; set; }
        public DelegateCommand NavToRoutePageCommand { get; set; }
        public DelegateCommand NavToMapPageCommand { get; set; }
        public DelegateCommand NavToFeedbackPageCommand { get; set; }
        public DelegateCommand NavToNotificationPageCommand { get; set; }

        public HomePageViewModel(INavigationService navigationService, CompositeDataManager dataManager)
            : base(navigationService, dataManager)
        {
            NavToRoutePageCommand = new DelegateCommand(()=>NavigateToPage(Pages.RouteList));
            NavToMapPageCommand = new DelegateCommand(()=>NavigateToPage(Pages.FindStation));
            NavToFeedbackPageCommand = new DelegateCommand(()=>NavigateToPage(Pages.FeedbackFormPage));
            NavToNotificationPageCommand = new DelegateCommand(()=>NavigateToPage(Pages.NotificationListPage));
            SwitchSiteCommand = new DelegateCommand(ExecuteSwitchSiteCommand);
        }


        public override async void OnBackButtonPressed(NavigationParameters parameters = null)
        {
            var isCloseApp = await ApplicationHelper.Alert(AppResources.ExitTitle, AppResources.ExitPrompt, AppResources.YesLabel, AppResources.NoLabel);
            if (isCloseApp)
            {
                ApplicationHelper.Close();
            }
        }

        private void ExecuteSwipeCommand(object obj)
        {
            //var direction = (SwipeDirection)obj;
            //if (direction == SwipeDirection.Left)
            //{
            //    NavigateToPage(Pages.Site);
            //}
        }

        public override async void OnNavigatedTo(NavigationParameters parameters, bool isBackMode = false)
        {
            base.OnNavigatedTo(parameters, isBackMode);

            if(UpdateChecked)
            {
                return;
            }
            UpdateChecked = true;

            var appVersion = await WebRequestHelper.Get<AppVersion>(AppConstants.VersionControlUrl);
            if(appVersion == null)
            {
                return;
            }
            var installedVersion = DeviceHelper.GetPackageVersion();
            
            if ((Device.RuntimePlatform == Device.iOS && AppVersion.CompareVersion(appVersion.IOSVersion, installedVersion) > 0)
                || (Device.RuntimePlatform == Device.Android && AppVersion.CompareVersion(appVersion.AndroidVersion, installedVersion) > 0))
            {
                var update = await ApplicationHelper.Alert(AppResources.UpdateTitle, AppResources.UpdateMessage, AppResources.UpdateYesButton, AppResources.UpdateNoButton);
                if (update)
                {
                    string updateUrl = "";
                    if(Device.RuntimePlatform == Device.iOS)
                    {
                        updateUrl = AppConstants.IOSUpdateUrl;
                    }
                    if (Device.RuntimePlatform == Device.Android)
                    {
                        updateUrl = AppConstants.AndroidUpdateUrl;
                    }

                    await CompositeDataManager.UserDataManager.ClearUserData();
                    Device.OpenUri(new System.Uri(updateUrl));
                    ApplicationHelper.Close();
                }
            }
        }

        private void ExecuteSwitchSiteCommand()
        {
            NavToPageCommand.Execute(Pages.Initialize);
        }

        public async void UpdateClientSettings()
        {
            await CompositeDataManager.RouteDataManager.SyncRouteListAsync(Session.Site.Id);
            Session.Routes = await CompositeDataManager.RouteDataManager.GetCachedRouteListAsync(Session.Site.Id);
            await CompositeDataManager.SettingDataManager.InsertOrUpdateSettingAsync(Session.ClientSettings);
            this.UpdateSiteName();
        }

        /// <summary>
        /// Return static resource base platform
        /// </summary>
        /// <param name="res">static resource</param>
        /// <returns>static resource path</returns>
        private string PlatformStaicResource(string res)
        {
            if (Device.RuntimePlatform == Device.WinPhone || Device.RuntimePlatform == Device.Windows)
                return $"Assets/{res}";
            return res;
        }
    }
}
