package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_1077 extends BaseMapProcess
   {
      
      public function MapProcess_1077()
      {
         super();
      }
      
      override public function destroy() : void
      {
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
      }
   }
}

