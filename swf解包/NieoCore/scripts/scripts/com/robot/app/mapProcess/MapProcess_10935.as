package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10935 extends BaseMapProcess
   {
      
      public function MapProcess_10935()
      {
         super();
      }
      
      override public function setup() : void
      {
         super.setup();
         getDefinitionByName("com.robot.app2.mapProcess.control.FrozenMonsterController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         getDefinitionByName("com.robot.app2.mapProcess.control.FrozenMonsterController").destroy();
      }
   }
}

