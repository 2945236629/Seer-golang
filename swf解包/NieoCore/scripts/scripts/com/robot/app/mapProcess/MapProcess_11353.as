package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11353 extends BaseMapProcess
   {
      
      public function MapProcess_11353()
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
         NpcDialogNew_1.show(1891,["哎呀我儿子摔倒了，需要赛尔豆亲亲才能起来！但是我没有赛尔豆。"],["赛尔豆我可以给你。（30000赛尔豆）"],[function():void
         {
            if(MainManager.actorInfo._coins > 30000)
            {
               KTool.doExchange(9378,function():void
               {
                  NpcDialogNew_1.show(1891,["真谢谢你了！我这就去扶我儿子去。"],["嗯嗯，快去吧。"],[function():void
                  {
                     KTool.changeMapWithCallBack(1,function():void
                     {
                        Alarm.show("你成功安抚了泰勒斯，获得了15点善心度！");
                        ModuleManager.showAppModule("DaWeiSiMWComeSubPanel");
                     });
                  }]);
               });
            }
            else
            {
               Alarm.show("需要给泰勒斯30000赛尔豆，目前你的赛尔豆不足！");
            }
         }]);
      }
      
      override public function destroy() : void
      {
         conLevel["npc"].removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
   }
}

