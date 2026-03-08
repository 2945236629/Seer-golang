package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10622 extends BaseMapProcess
   {
      
      public function MapProcess_10622()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app.task.control.TaskController_3017").setup(10622);
      }
   }
}

