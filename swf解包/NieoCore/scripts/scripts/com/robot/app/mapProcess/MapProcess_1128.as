package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_1128 extends BaseMapProcess
   {
      
      private var _id:int;
      
      public function MapProcess_1128()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.OpenStargateController").initForMap(this);
         getDefinitionByName("com.robot.app2.control.StargateOpenCountdownController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.OpenStargateController").destroy();
         getDefinitionByName("com.robot.app2.control.StargateOpenCountdownController").destroy();
         super.destroy();
      }
   }
}

