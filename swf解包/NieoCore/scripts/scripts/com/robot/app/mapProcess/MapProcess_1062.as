package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.loading.Loading;
   
   public class MapProcess_1062 extends BaseMapProcess
   {
      
      public function MapProcess_1062()
      {
         super();
      }
      
      override public function destroy() : void
      {
         ModuleManager.destroy(ClientConfig.getAppModule("StarPetReturnMapPanel"));
         super.destroy();
      }
      
      override protected function init() : void
      {
         ModuleManager.hideAllModule();
         ModuleManager.showAppModule("StarPetReturnMapPanel",null,Loading.NO_ALL);
         super.init();
      }
   }
}

