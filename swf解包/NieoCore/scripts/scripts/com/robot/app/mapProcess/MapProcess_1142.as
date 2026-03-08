package com.robot.app.mapProcess
{
   import com.robot.app.control.MiningcrystalController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1142 extends BaseMapProcess
   {
      
      public function MapProcess_1142()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.WindWhispersForestGuardianController").enterMap();
         MiningcrystalController.init(this,5);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.WindWhispersForestGuardianController").destroy();
         MiningcrystalController.destroy(this);
         super.destroy();
      }
   }
}

