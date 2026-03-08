package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_1160 extends BaseMapProcess
   {
      
      public function MapProcess_1160()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
      }
      
      override public function destroy() : void
      {
      }
   }
}

