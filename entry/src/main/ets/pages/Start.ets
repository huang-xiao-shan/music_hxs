@Entry
@Component
struct Start {
  router = this.getUIContext().getRouter();
  // 定时器 id
  timerId: number = 0;
  aboutToAppear(): void {
    console.info("Start页面即将显示，开始创建定时器");
    // 5秒后自动跳转到首页
    this.timerId = setTimeout(() => {
      console.info("定时器触发，执行页面跳转");
      this.router.replaceUrl({ url: 'pages/Index' });
    }, 5000);
    console.info("定时器创建完成，timerId = " + this.timerId);
  }

  aboutToDisappear() {
    console.info("Start页面即将消失，开始清除定时器");
    // 清除定时器
    clearTimeout(this.timerId);
    console.info("定时器清除完成，timerId = " + this.timerId);
  }
  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image($r('app.media.ad'))
      Button('跳过')
        .margin(10)
        .backgroundColor('#4d000000')
        .onClick(() => {
          this.router.replaceUrl({ url: 'pages/Index' });
        })
    }
  }
}