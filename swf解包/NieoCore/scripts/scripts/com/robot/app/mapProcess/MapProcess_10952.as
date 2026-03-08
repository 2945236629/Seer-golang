package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10952 extends BaseMapProcess
   {
      
      public function MapProcess_10952()
      {
         super();
         getDefinitionByName("com.robot.app2.mapProcess.control.MeyersPrefectivePreViewController").initForMap(this);
      }
      
      override public function setup() : void
      {
         super.setup();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.MeyersPrefectivePreViewController").destroy();
         super.destroy();
      }
   }
}

