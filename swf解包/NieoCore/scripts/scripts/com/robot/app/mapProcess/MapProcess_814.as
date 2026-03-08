package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_814 extends BaseMapProcess
   {
      
      public function MapProcess_814()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = topLevel.mouseEnabled = false;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

