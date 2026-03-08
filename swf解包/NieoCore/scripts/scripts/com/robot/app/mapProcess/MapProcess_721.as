package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.SptTanHuangController;
   import com.robot.app.task.taskscollection.Task994;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_721 extends BaseMapProcess
   {
      
      public function MapProcess_721()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task994.init721(this);
         SptTanHuangController.instance.start();
      }
      
      override public function destroy() : void
      {
         Task994.destroy();
         super.destroy();
      }
   }
}

