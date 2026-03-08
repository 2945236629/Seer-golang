package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_11402 extends BaseMapProcess
   {
      
      public function MapProcess_11402()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.TheSecretOfAnjunshenwu1Controller").initMap(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

