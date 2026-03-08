package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_980 extends BaseMapProcess
   {
      
      public function MapProcess_980()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = true;
         topLevel.mouseEnabled = true;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

