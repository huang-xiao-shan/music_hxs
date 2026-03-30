import { getSongList } from '../apis';
import { SongItemType, SongItem } from '../models/Index';

// 分层颜色管理 - 基础色板
interface GeneratedObjectLiteralInterface_1 {
  primary: string;
  primaryLight: string;
  darkBg: string;
  cardBg: string;
  textPrimary: string;
  textSecondary: string;
  accent: string;
  divider: string;
}

const BaseColors: GeneratedObjectLiteralInterface_1 = {
  primary: '#FF3A79',         // 主色调 (粉色)
  primaryLight: '#FF8AB0',    // 主色浅版
  darkBg: '#121215',          // 深色背景
  cardBg: '#1D1D24',          // 卡片背景
  textPrimary: '#FFFFFF',     // 主要文本
  textSecondary: '#B0B0B0',   // 次要文本
  accent: '#6A5AF9',          // 强调色 (紫色)
  divider: '#2A2A32'          // 分割线
};

// 分层颜色管理 - 主题配置
interface GeneratedObjectLiteralInterface_2 {
  headerBg: string;
  cardBg: string;
  textPrimary: string;
  textSecondary: string;
  accent: string;
  primary: string;
}

const Theme: GeneratedObjectLiteralInterface_2 = {
  headerBg: BaseColors.darkBg,
  cardBg: BaseColors.cardBg,
  textPrimary: BaseColors.textPrimary,
  textSecondary: BaseColors.textSecondary,
  accent: BaseColors.accent,
  primary: BaseColors.primary
};

@Component
export default struct Mine {
  @State songList: SongItemType[] = [];

  async aboutToAppear() {
    const list: SongItemType[] = await getSongList() as SongItemType[];
    this.songList = list.map(i => new SongItem(i));
  }

  build() {
    Column() {
      // 头部个人信息卡片（保持不变）
      Column() {
        Row() {
          Image($r('app.media.logo'))
            .width(80)
            .aspectRatio(1)
            .borderRadius(40)
            .border({ width: 2, color: Theme.primary })
            .shadow({ radius: 10, color: Color.Black, offsetX: 0, offsetY: 4 })

          Column({ space: 8 }) {
            Row({ space: 8 }) {
              Text('黑马云音乐')
                .fontColor(Theme.textPrimary)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)

              Image($r('app.media.ic_vip'))
                .width(36)
                .margin({ top: 2 })
            }

            Row() {
              Image($r('app.media.ic_boy'))
                .width(14)
                .fillColor('#ff23496b')
                .margin({ right: 4 })
              Text('00后')
                .fontColor('#555')
                .margin({ right: 12 })
                .fontSize(14)
              Text('双子座')
                .fontColor('#555')
                .margin({ right: 12 })
                .fontSize(14)
              Text('北京')
                .fontColor('#555')
                .margin({ right: 12 })
                .fontSize(14)
              Text('歌龄·2年')
                .fontColor('#555')
                .fontSize(14)
            }

            Row({ space: 20 }) {
              Column({ space: 4 }) {
                Text('1')
                  .fontColor(Theme.primary)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                Text('关注')
                  .fontColor(Theme.textSecondary)
                  .fontSize(12)
              }

              Column({ space: 4 }) {
                Text('10万')
                  .fontColor(Theme.primary)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                Text('粉丝')
                  .fontColor(Theme.textSecondary)
                  .fontSize(12)
              }

              Column({ space: 4 }) {
                Text('167万')
                  .fontColor(Theme.primary)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                Text('点赞')
                  .fontColor(Theme.textSecondary)
                  .fontSize(12)
              }
            }
            .margin({ top: 15 })
          }
          .margin({ left: 15 })
        }
        .padding(20)
      }
      .width('100%')
      .backgroundColor(Theme.headerBg)
      .borderRadius(24)
      .margin({ top: 12 })
      .shadow({ radius: 16, color: '#00000040', offsetX: 0, offsetY: 6 })

      // 歌单标题区域
      Row() {
        Text('我的歌单')
          .fontColor(Theme.textPrimary)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)

        Blank()

        Text('全部 >')
          .fontColor(Theme.accent)
          .fontSize(14)
      }
      .width('90%')
      .margin({ top: 25, bottom: 15 })

      // 歌单列表区域 - 修改为垂直布局，每个歌曲占一行
      List({ space: 12 }) {
        ForEach(this.songList, (item: SongItemType, index: number) => {
          ListItem() {
            // 每一行是一个歌曲项，使用 Row 实现水平布局
            Row() {
              // 1. 歌曲封面图
              Image(item.img)
                .width(55)
                .height(55)
                .borderRadius(8)
                .objectFit(ImageFit.Cover)

              // 2. 歌曲名称 - 靠左紧贴图片
              Text(item.title)
                .fontColor(Theme.textPrimary)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ left: 12 })  // 与图片保持适当间距
                .layoutWeight(1)  // 占据剩余空间

              // 3. VIP 标签 - 放在歌曲名右侧
              Text('VIP')
                .fontSize(10)
                .fontColor('#FFD700')
                .border({ width: 1, color: '#FFD700' })
                .borderRadius(4)
                .padding({ left: 6, right: 6, top: 3, bottom: 3 })
                .margin({ right: 12 })

              // 4. 更多按钮
              Image($r('app.media.ic_more'))
                .width(20)
                .height(20)
                .fillColor(Theme.textSecondary)
                .margin({ right: 8 })
            }
            .width('100%')
            .height(71)
            .padding({ left: 12, right: 12 })
            .backgroundColor(Theme.cardBg)
            .borderRadius(12)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 12, right: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0A0A0C')
  }
}

// 标签组件（保留备用）
@Component
struct Tag {
  private content: string = '';

  build() {
    Text(this.content)
      .fontSize(12)
      .padding({ left: 10, right: 10, top: 4, bottom: 4 })
  }
}