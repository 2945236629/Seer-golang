package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10873 extends BaseMapProcess
   {
      
      public function MapProcess_10873()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.WuYiAct1Control").initMap10873(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.WuYiAct1Control").destroy();
      }
   }
}

