package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_1056 extends BaseMapProcess
   {
      
      public function MapProcess_1056()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         StatManager.sendStat2014("新年福利大回馈第三弹","进入活动场景","2015运营活动");
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("NewYearBenefitsIcePanel"));
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

