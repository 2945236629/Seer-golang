package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10953 extends BaseMapProcess
   {
      
      public function MapProcess_10953()
      {
         super();
         getDefinitionByName("com.robot.app2.mapProcess.control.OscarPrefectivePreViewController").initForMap(this);
      }
      
      override public function setup() : void
      {
         super.setup();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.OscarPrefectivePreViewController").destory();
         super.destroy();
      }
   }
}

