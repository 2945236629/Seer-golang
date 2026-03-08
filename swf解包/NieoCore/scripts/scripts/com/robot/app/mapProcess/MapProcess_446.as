package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_446 extends BaseMapProcess
   {
      
      public function MapProcess_446()
      {
         super();
      }
      
      override protected function init() : void
      {
      }
      
      override public function destroy() : void
      {
         ModuleManager.destroy(ClientConfig.getAppModule("HolePanel"));
      }
      
      public function gotoHoleFight() : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("HolePanel"),"炫彩山山洞入口面板");
      }
   }
}

