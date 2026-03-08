package com.robot.app.mapProcess
{
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10522 extends BaseMapProcess
   {
      
      public function MapProcess_10522()
      {
         super();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("支线暗影布莱克","进入魔界之门",StatManager.RUN_ACT);
         getDefinitionByName("com.robot.app2.control.BulaikeSecretController").initMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.BulaikeSecretController").destroy();
      }
   }
}

