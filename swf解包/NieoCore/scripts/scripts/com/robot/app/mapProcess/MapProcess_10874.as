package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10874 extends BaseMapProcess
   {
      
      public function MapProcess_10874()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.WuYiAct1Control").initMap10874(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.WuYiAct1Control").destroy();
         super.destroy();
      }
   }
}

