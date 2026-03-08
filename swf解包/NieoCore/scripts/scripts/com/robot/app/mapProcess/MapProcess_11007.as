package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_11007 extends BaseMapProcess
   {
      
      public function MapProcess_11007()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.control.LookForSonOfMoonStep3Controller").init11007();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.LookForSonOfMoonStep3Controller").destroy11007();
         super.destroy();
      }
   }
}

