package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10875 extends BaseMapProcess
   {
      
      public function MapProcess_10875()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.WuYiAct1Control").initMap10875(this);
      }
   }
}

