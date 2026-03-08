package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11354 extends BaseMapProcess
   {
      
      public function MapProcess_11354()
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
         NpcDialogNew_1.show(2305,["啊啊啊！没有泰坦之灵玩我快要死了！"],["额，那我给你吧。（5000泰坦之灵）"],[function():void
         {
            ItemManager.updateAndGetItemsNum([1400352],function(param1:Array):void
            {
               var a:Array = param1;
               if(a[0] >= 5000)
               {
                  KTool.doExchange(9379,function():void
                  {
                     NpcDialogNew_1.show(2305,["（泰灵不想跟你说话并向你扔了一个泰坦之灵）"],["……你开心就好。"],[function():void
                     {
                        KTool.changeMapWithCallBack(1,function():void
                        {
                           Alarm.show("你成功满足了泰灵的愿望，获得了15点善心度！");
                           ModuleManager.showAppModule("DaWeiSiMWComeSubPanel");
                        });
                     }]);
                  });
               }
               else
               {
                  Alarm.show("需要给泰灵5000泰坦之灵，目前你的泰坦之灵不足！");
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

