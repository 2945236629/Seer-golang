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
   
   public class MapProcess_11355 extends BaseMapProcess
   {
      
      public function MapProcess_11355()
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
         NpcDialogNew_1.show(2128,["我是最强防御的史莱姆，当然被打了还是会疼！"],["用体力药剂恢复下吧。（10个高级体力药剂）"],[function():void
         {
            ItemManager.updateAndGetItemsNum([300013],function(param1:Array):void
            {
               var a:Array = param1;
               if(a[0] >= 10)
               {
                  KTool.doExchange(9380,function():void
                  {
                     NpcDialogNew_1.show(2128,["我是最强防御的史莱姆，有了体力药剂，被打会疼也不怕！"],["哈哈哈，那就好。"],[function():void
                     {
                        KTool.changeMapWithCallBack(1,function():void
                        {
                           Alarm.show("你成功医治了史莱姆，获得了10点善心度！");
                           ModuleManager.showAppModule("DaWeiSiMWComeSubPanel");
                        });
                     }]);
                  });
               }
               else
               {
                  Alarm.show("需要给防御史莱姆10个高级体力药剂，目前你的高级体力药剂不足！");
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

