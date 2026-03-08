package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialogNew_1;
   
   public class MapProcess_11562 extends BaseMapProcess
   {
      
      public function MapProcess_11562()
      {
         super();
      }
      
      override protected function init() : void
      {
         var mainState:int = 0;
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         LevelManager.toolsLevel.visible = false;
         KTool.hideMapAllPlayerAndMonster();
         if(BitBuffSetClass.getState(23544))
         {
            mainState = 4;
         }
         else if(BitBuffSetClass.getState(23543))
         {
            mainState = 3;
         }
         else if(BitBuffSetClass.getState(23542))
         {
            mainState = 2;
         }
         else
         {
            mainState = 1;
         }
         if(mainState < 4)
         {
            this.playStory(mainState,function():void
            {
               BitBuffSetClass.setState(23542 + mainState - 1,1,function():void
               {
                  KTool.showMapAllPlayerAndMonster(true);
                  KTool.changeMapWithCallBack(1,function():void
                  {
                     ModuleManager.showAppModule("LaiYinTeComeOutPanel");
                  });
               });
            });
         }
         else
         {
            KTool.showMapAllPlayerAndMonster(true);
            KTool.changeMapWithCallBack(1,function():void
            {
               ModuleManager.showAppModule("LaiYinTeComeOutPanel");
            });
         }
      }
      
      private function playStory(param1:int, param2:Function) : void
      {
         var index:int = param1;
         var func:Function = param2;
         if(index == 2)
         {
            conLevel["mc"].gotoAndStop(index);
            AnimateManager.playMcAnimate(conLevel["mc"],index,"mc",function():void
            {
               conLevel.mouseEnabled = conLevel.mouseChildren = false;
               NpcDialogNew_1.show(2820,["可据我所知，就连冥域的主人，冥皇修罗都无法掌控逝者巨樽的力量，魔誓者要找它干什么"],["修罗大人只是无法“掌握”巨樽的力量，并不是“无法打开”它…"],[function():void
               {
                  NpcDialogNew_1.show(2820,["什么意思？"],["您也知道，就算是冥域，其实也并非不死之地。"],[function():void
                  {
                     NpcDialogNew_1.show(2820,["是的，若在冥域之中再度死去的亡者，无论是怨念也好，遗恨也罢，都将整个汇入逝者巨樽之中。"],["嗯，所以上万年来，巨樽中已经积累了无可估量的亡者之力。"],[function():void
                     {
                        NpcDialogNew_1.show(2820,["等等，你之前说修罗并不是“无法打开”它，难道魔誓者他们要！"],["嗯，要打开它却并非难事…"],[function():void
                        {
                           NpcDialogNew_1.show(2820,["一旦打开，失去巨樽上万年以来束缚的亡者之力将喷涌而出，而这股无法掌控的力量，必然会暴走并席卷冥域！不，不光是冥域，整个宇宙都会被这些上古亡者所吞没！"],["整个宇宙…吗…"],[function():void
                           {
                              if(func != null)
                              {
                                 func();
                              }
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            });
         }
         else if(index == 3)
         {
            conLevel["mc"].gotoAndStop(index);
            AnimateManager.playMcAnimate(conLevel["mc"],index,"mc",function():void
            {
               conLevel.mouseEnabled = conLevel.mouseChildren = false;
               NpcDialogNew_1.show(2820,["我是大地之祖，并不会偏袒任何一个种族，就算冥域之人，只要不是奸邪之辈，我都不会坐视不管，更何况这还是会波及整个宇宙的危机。"],["那您…愿意出手了？"],[function():void
               {
                  NpcDialogNew_1.show(2820,["没错，其实之前我一直担心进入冥域的赛尔和奥兰他们，但是因为我要维持这地脉之轮的运作，一时半会才没跟随他们一同深入"],["那现在…？"],[function():void
                  {
                     NpcDialogNew_1.show(2820,["现在地脉之轮已经暂时稳定了，我就算离开片刻，也不会有什么问题。但为了以防魔誓者来动些手脚，你现在前往赛尔号飞船把这个消息告诉罗杰他们"],["好的，我这就前往赛尔号。"],[function():void
                     {
                        if(func != null)
                        {
                           func();
                        }
                     }]);
                  }]);
               }]);
            });
         }
         else if(index == 1)
         {
            conLevel["mc"].gotoAndStop(index);
            AnimateManager.playMcAnimate(conLevel["mc"],index,"mc",function():void
            {
               conLevel.mouseEnabled = conLevel.mouseChildren = false;
               NpcDialogNew_1.show(2820,["你是冥域的住民？ "],["我叫艾拉，是修罗大殿中的侍女之一。"],[function():void
               {
                  NpcDialogNew_1.show(2820,["修罗大殿在冥域的最深处，我听说那里已被魔誓者攻占，你是怎么出来的？"],["当魔誓者攻占大殿时，我趁他们不注意，冲了出来。"],[function():void
                  {
                     NpcDialogNew_1.show(2820,["可怕的东西？"],["是的，莱茵哈特大人，这件东西想必您也有所听闻…"],[function():void
                     {
                        if(func != null)
                        {
                           func();
                        }
                     }]);
                  }]);
               }]);
            });
         }
         else if(func != null)
         {
            func();
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         LevelManager.toolsLevel.visible = true;
         super.destroy();
      }
   }
}

