package com.robot.app.mapProcess
{
   import com.robot.app.control.SptKnifeYaKuBuController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_948 extends BaseMapProcess
   {
      
      public function MapProcess_948()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86064215);
         btnLevel["yakubuBtn"].visible = false;
         SptKnifeYaKuBuController.instance.start();
         getDefinitionByName("com.robot.app2.mapProcess.control.DarkAllianceVSMagicSoldierController").init();
         super.init();
      }
      
      override public function setup() : void
      {
         super.setup();
      }
      
      override public function destroy() : void
      {
         SptKnifeYaKuBuController.instance.destroy();
         getDefinitionByName("com.robot.app2.mapProcess.control.DarkAllianceVSMagicSoldierController").destroy();
         super.destroy();
      }
   }
}

