package com.robot.app.mapProcess
{
   import com.robot.app.fightLevel.FightPetBagController;
   import com.robot.app.mapProcess.control.YingkaluosiTestController;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcess_10016 extends BaseMapProcess
   {
      
      public function MapProcess_10016()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         MapListenerManager.add(topLevel["bag"],this.onBag,"精灵背包");
         MapListenerManager.add(depthLevel["yingkaluosi"],this.onYingkaluosi,"英卡洛斯");
         MapListenerManager.add(depthLevel["gift"],this.onGift,"勇气礼盒");
         topLevel["level"].visible = false;
         topLevel["level"].gotoAndStop(YingkaluosiTestController.time + 1);
         if(YingkaluosiTestController.hasPlay == false)
         {
            YingkaluosiTestController.hasPlay = true;
            this.onFight(null);
         }
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onFight);
      }
      
      private function onBag(param1:MouseEvent) : void
      {
         FightPetBagController.show();
      }
      
      private function onYingkaluosi(param1:MouseEvent) : void
      {
         YingkaluosiTestController.startFight();
      }
      
      private function onGift(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86049859);
         ModuleManager.showModule(ClientConfig.getAppModule("YingkaluosiTestGiftPanel"),"正在加载....");
      }
      
      private function onFight(param1:PetFightEvent) : void
      {
         var e:PetFightEvent = param1;
         if(YingkaluosiTestController.time >= 10)
         {
            return;
         }
         LevelManager.closeMouseEvent();
         topLevel["effect"].addEventListener(Event.ENTER_FRAME,function(param1:Event):void
         {
            if(topLevel["effect"].currentFrame == 11)
            {
               topLevel["level"].visible = true;
            }
            else if(topLevel["effect"].currentFrame == 31)
            {
               topLevel["level"].visible = false;
            }
            else if(topLevel["effect"].currentFrame == topLevel["effect"].totalFrames)
            {
               LevelManager.openMouseEvent();
               topLevel["level"].visible = false;
               topLevel["effect"].visible = false;
               topLevel["effect"].removeEventListener(Event.ENTER_FRAME,arguments.callee);
            }
         });
         topLevel["effect"].gotoAndPlay(2);
      }
      
      public function leave() : void
      {
         YingkaluosiTestController.leaveMap();
      }
      
      override public function destroy() : void
      {
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFight);
      }
   }
}

