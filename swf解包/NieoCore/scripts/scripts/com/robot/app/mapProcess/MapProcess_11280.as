package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_11280 extends BaseMapProcess
   {
      
      public function MapProcess_11280()
      {
         super();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.ResuscitateShenyuQishiController").destroy();
         super.destroy();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.ResuscitateShenyuQishiController").initMap(this);
      }
   }
}

