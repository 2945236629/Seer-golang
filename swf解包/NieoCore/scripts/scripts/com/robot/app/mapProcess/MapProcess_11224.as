package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1312;
   import com.robot.app.task.taskscollection.Task1320;
   import com.robot.app.task.taskscollection.Task1330;
   import com.robot.app.task.taskscollection.Task1343;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_11224 extends BaseMapProcess
   {
      
      public function MapProcess_11224()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.afterPlayGo();
      }
      
      private function afterPlayGo() : void
      {
         Task1312.initForMap102(this);
         Task1320.initForMap102(this);
         Task1330.initForMap102(this);
         Task1343.initForMap102(this);
      }
      
      override public function destroy() : void
      {
         Task1312.destroy();
         Task1320.destroy();
         Task1330.destroy();
         Task1343.destroy();
      }
   }
}

