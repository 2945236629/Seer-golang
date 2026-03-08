package com.robot.app.mapProcess
{
   import com.robot.app.task.control.TianKongZhiChengController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_965 extends BaseMapProcess
   {
      
      public function MapProcess_965()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         TianKongZhiChengController.instance.start();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         TianKongZhiChengController.instance.destory();
      }
   }
}

