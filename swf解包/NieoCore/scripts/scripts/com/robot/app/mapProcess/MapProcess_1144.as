package com.robot.app.mapProcess
{
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_1144 extends BaseMapProcess
   {
      
      public static var COME_FROM_PANEL:Boolean = false;
      
      public function MapProcess_1144()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         StatManager.sendStat2014("1225年费预约大礼包","进入1144号场景",StatManager.RUN_ACT_2015);
         conLevel["spirite"].buttonMode = true;
         if(BitBuffSetClass.getState(23009) == 0)
         {
            conLevel["spirite"].gotoAndStop(1);
            BitBuffSetClass.setState(23009,1);
            AnimateManager.playMcAnimate(conLevel["spirite"],1,"mc",function():void
            {
               if(conLevel["spirite"] != null)
               {
                  conLevel["spirite"].gotoAndStop(2);
                  conLevel["spirite"].addEventListener(MouseEvent.CLICK,clickHandle);
               }
               if(COME_FROM_PANEL)
               {
                  COME_FROM_PANEL = false;
                  ModuleManager.showAppModule("LightKingLeavingPanel");
               }
            });
         }
         else
         {
            conLevel["spirite"].gotoAndStop(2);
            conLevel["spirite"].addEventListener(MouseEvent.CLICK,this.clickHandle);
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("YearVip2016MainPanel");
      }
      
      override public function destroy() : void
      {
         conLevel["spirite"].removeEventListener(MouseEvent.CLICK,this.clickHandle);
         super.destroy();
      }
   }
}

