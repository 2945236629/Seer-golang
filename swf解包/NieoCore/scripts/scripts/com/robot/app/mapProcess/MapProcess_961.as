package com.robot.app.mapProcess
{
   import com.robot.app.control.StealtherWarController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_961 extends BaseMapProcess
   {
      
      public function MapProcess_961()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         StealtherWarController.instance.start();
      }
   }
}

