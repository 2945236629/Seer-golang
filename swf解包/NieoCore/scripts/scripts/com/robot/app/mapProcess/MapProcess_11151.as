package com.robot.app.mapProcess
{
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.loading.Loading;
   
   public class MapProcess_11151 extends BaseMapProcess
   {
      
      public function MapProcess_11151()
      {
         super();
      }
      
      override public function destroy() : void
      {
         ToolBarController.panel.visible = true;
         LevelManager.iconLevel.visible = true;
         ModuleManager.destroy(ClientConfig.getAppModule("StarPetReturnSixiongMapPanel"));
         super.destroy();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("0212明星神宠回归四凶篇","进入副本场景","2016运营活动");
         ModuleManager.hideAllModule();
         ToolBarController.panel.visible = false;
         LevelManager.iconLevel.visible = false;
         ModuleManager.showAppModule("StarPetReturnSixiongMapPanel",null,Loading.NO_ALL);
         super.init();
      }
   }
}

