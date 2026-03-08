package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11352 extends BaseMapProcess
   {
      
      public function MapProcess_11352()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["npc"].addEventListener(MouseEvent.CLICK,this.onMouseClick);
         (conLevel["npc"] as MovieClip).buttonMode = true;
      }
      
      public function onMouseClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialogNew_1.show(20,["嘿呀！好气呀！为什么我老是抓不到精灵呢？太失败了！"],["我来给你一些高级精灵胶囊，抓精灵很有效！（50个高级精灵胶囊）"],[function():void
         {
            ItemManager.updateAndGetItemsNum([300003],function(param1:Array):void
            {
               var a:Array = param1;
               if(a[0] >= 50)
               {
                  KTool.doExchange(9377,function():void
                  {
                     NpcDialogNew_1.show(20,["太感谢你了，我这就去抓精灵啦！"],["嗯嗯，加油哦！"],[function():void
                     {
                        KTool.changeMapWithCallBack(1,function():void
                        {
                           Alarm.show("你成功帮助了赛尔，获得了10点善心度！");
                           ModuleManager.showAppModule("DaWeiSiMWComeSubPanel");
                        });
                     }]);
                  });
               }
               else
               {
                  Alarm.show("需要给这位赛尔50个高级精灵胶囊，目前你的胶囊不足！");
                  ModuleManager.showModule(ClientConfig.getAppModule("DrugBuyPanel"),"正在加载...");
               }
            });
         }]);
      }
      
      override public function destroy() : void
      {
         conLevel["npc"].removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
   }
}

