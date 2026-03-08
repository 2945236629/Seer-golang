package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_797 extends BaseMapProcess
   {
      
      public function MapProcess_797()
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

