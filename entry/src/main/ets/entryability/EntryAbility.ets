import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { SAFE_TOP, SAFE_BOTTOM } from '../contants';
import AVPlayerManager from '../utils/AVPlayerManager';
import AVSessionManager from '../utils/AVSessionManager';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      hilog.error(DOMAIN, 'testTag', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // 日志打印
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 加载页面
    windowStage.loadContent('pages/Start', (err) => {
      // 1. 获取主窗口
      const mainWindow = windowStage.getMainWindowSync();
      // 2. 设置全屏布局（沉浸式）
      mainWindow.setWindowLayoutFullScreen(true);
      // 3. 设置状态栏文字颜色为白色
      mainWindow.setWindowSystemBarProperties({
        statusBarContentColor: '#ffffff'
      });
      // 4. 获取顶部系统避让区（状态栏高度）
      const avoidArea = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      const safeTop = mainWindow.getUIContext().px2vp(avoidArea.topRect.height);
      AppStorage.setOrCreate(SAFE_TOP, safeTop);
      // 5. 获取底部导航避让区（虚拟导航栏高度）
      const navigationArea = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      const safeBottom = mainWindow.getUIContext().px2vp(navigationArea.bottomRect.height);
      AppStorage.setOrCreate(SAFE_BOTTOM, safeBottom);
      // 初始化播放器
      AVPlayerManager.init();//新增
      AVSessionManager.init(this.context);
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}