package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10543 extends BaseMapProcess
   {
      
      public function MapProcess_10543()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app.task.control.TaskController_3019").setup(10543);
      }
   }
}

