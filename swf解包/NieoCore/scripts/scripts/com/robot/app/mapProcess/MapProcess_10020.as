package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10020 extends BaseMapProcess
   {
      
      public function MapProcess_10020()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.newSeer.NewSeerLeiyiEvo").enterMap10020();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.newSeer.NewSeerLeiyiEvo").leaveMap10020();
      }
   }
}

