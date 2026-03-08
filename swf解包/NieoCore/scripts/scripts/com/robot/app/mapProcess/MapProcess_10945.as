package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10945 extends BaseMapProcess
   {
      
      private var _id:int;
      
      public function MapProcess_10945()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.LeiyiPreHotController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.LeiyiPreHotController").destroyForMap();
         super.destroy();
      }
   }
}

